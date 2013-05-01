-- TestBench Template 

LIBRARY std;
USE std.textio.ALL;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.all;

use IEEE.fixed_float_types.all;
use IEEE.fixed_pkg.all;
use IEEE.float_pkg.all;

library work;
USE work.fir_pkg.all;

ENTITY testbench IS
	Generic (
			INVEC    : string  := "test_vector.dat";
			COEFFVEC	: string	 := "coeff_vector.dat";
			OUTVEC   : string  := "res_vector.dat");
END testbench;

ARCHITECTURE behavior OF testbench IS 

-- Fill and export rams
   impure function fill_ram (filename : in string) return din_t is                 
      FILE ram_file					: text;                       
      variable ram_line				: line;
      variable vector_input		: real;      
      variable ram					: din_t;  
   begin
      file_open(ram_file, filename, READ_MODE);
      report "Filling RAM from file" severity note;
      for I in 0 to VECTOR_LENGTH-1 loop                                  
         readline (ram_file, ram_line);                             
         read (ram_line, vector_input);
         ram(I) := STD_LOGIC_VECTOR(TO_SIGNED(integer(vector_input*(2.0**DATA_FRA)), work.fir_pkg.DATA_WIDTH));
      end loop;   
		report "Filling RAM from file, done" severity note;
      file_close(ram_file);                                                 
      return ram;                                                  
   end function;
   -- coefficient ram
	impure function fill_coeff_ram (filename : in string) return din_t is                 
      FILE ram_file					: text;                       
      variable ram_line				: line;
      variable vector_input		: real;      
      variable ram					: cin_t;  
   begin
      file_open(ram_file, filename, READ_MODE);
      report "Filling RAM from file" severity note;
      for I in 0 to TAP-1 loop                                  
         readline (ram_file, ram_line);                             
         read (ram_line, vector_input);
         ram(I) := STD_LOGIC_VECTOR(TO_SIGNED(integer(vector_input*(2.0**COEFF_FRA)), work.fir_pkg.COEFF_WIDTH));
      end loop;   
		report "Filling RAM from file, done" severity note;
      file_close(ram_file);                                                 
      return ram;                                                  
   end function;
	
   procedure export_ram ( filename : in string; ram : dout_t) is
      FILE out_file					: text;
      variable ram_line				: line;
      variable int_v					: real;
      --variable seperator			: string(1 downto 0) := ", ";
      --variable closing			: string(1 downto 0) := "*i";
   begin
      file_open(out_file, filename, WRITE_MODE);
      report "Dumping Ram to file" severity note;
      for I in 0 to VECTOR_LENGTH-1 loop
		
			int_v := real(to_integer(signed(ram(I))))/real(2.0**DATA_FRA);

         write(ram_line, int_v);
         --write(ram_line, seperator);
         --write(ram_line, int_v2);
         --write(ram_line, closing);
         writeline (out_file, ram_line);
      end loop;
      file_close(out_file);
   end procedure;

  -- Component Declaration
COMPONENT fir is
	Generic (
			  data_form				: string := "fixed");		-- fixed/floating
	Port (  clk						: in  STD_LOGIC;
           rst						: in  STD_LOGIC;
           ce						: in  STD_LOGIC;
			  coeff_en				: in	STD_LOGIC;
			  coeff					: in	STD_LOGIC_VECTOR (COEFF_WIDTH-1 downto 0);
           data_in				: in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           data_out				: out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
end COMPONENT;

SIGNAL clk	         :  STD_LOGIC;
SIGNAL rst	         :  STD_LOGIC;
SIGNAL ce				:  STD_LOGIC;
SIGNAL coeff_en		: 	STD_LOGIC;
SIGNAL coeff			:  STD_LOGIC_VECTOR (COEFF_WIDTH-1 downto 0);
SIGNAL data_in			:  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
SIGNAL data_out		:  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

signal DataInRam		: din_t;
signal CoeffRam		: din_t;
signal DataOutRam		: dout_t;

constant clk_period	: time := 10 ns;
constant UNLOAD_CYCLES : integer := VECTOR_LENGTH-1;

BEGIN

-- Clock process definitions
   clk_process: process
   begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
   end process; 

  -- Component Instantiation
uut:	fir
		
		PORT MAP(
			clk				=> clk,
			rst				=> rst,
			ce					=> ce,
			coeff_en			=> coeff_en,		
			coeff				=> coeff,
			data_in			=> data_in,
			data_out			=> data_out);

  --  Test Bench Statements
   tb_read : PROCESS
   BEGIN
      report "Starting test bench";
		data_in <= (others => '0');
		rst <= '1';
      ce <= '0';
		wait for 100 ns;
		DataInRam <= (others => (others => '0'));
		
      DataInRam <= fill_ram(INVEC);
		CoeffRam <= fill_coeff_ram(COEFFVEC);
		rst <= '0';
		wait for 100 ns;
		
		-- loading coefficients
		wait for 20 ns;
		coeff_en <= '1';
		
		for i in 0 to TAP-1 loop
			wait until rising_edge(clk);
			coeff <= CoeffRam(i);
		end loop;
		
		coeff_en <= '0';
		wait for 100 ns;
		
		ce <= '1';
		wait for 100 ns;
		-- computation
		for i in 0 to VECTOR_LENGTH-1 loop
			wait until rising_edge(clk);
			data_in <= DataInRam(i);
		end loop;
		wait for clk_period;
		ce <= '0';
		  
      wait; -- will wait forever
   END PROCESS tb_read;
   
--   tb_write : PROCESS
--   BEGIN
--		
--      for j in 0 to VECTOR_LENGTH-1 loop
--        wait until DataOutValid = '1' and rising_edge(clk);
--		  DataOutRam(j) <= data_out;
--      end loop;
--      
--      export_ram(OUTVEC, DataOutRam);
--        
--   END PROCESS tb_write;
--   
   --  End Test Bench  

END;
