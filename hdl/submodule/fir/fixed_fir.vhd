----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:13:18 04/16/2013 
-- Design Name: 
-- Module Name:    fixed_fir - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE_PROPOSED;
use IEEE_PROPOSED.fixed_float_types.all;
use IEEE_PROPOSED.fixed_pkg.all;
use IEEE_PROPOSED.float_pkg.all;

library work;
use work.fir_pkg.all;

entity fixed_fir is
	Port (	clk 				: in  STD_LOGIC;
				rst 				: in  STD_LOGIC;
				ce 				: in  STD_LOGIC;
				
				coeff_en			: in	STD_LOGIC;
				coeff				: in	STD_LOGIC_VECTOR (WIDTH_COEFF_FIXED-1 downto 0);
				
				data_in 			: in  STD_LOGIC_VECTOR (WIDTH_DATA_FIXED-1 downto 0);
				data_out 		: out  STD_LOGIC_VECTOR (WIDTH_DATA_FIXED-1 downto 0));
end fixed_fir;

architecture Behavioral of fixed_fir is

signal data_in_buff, data_out_buff: sfixed(DATA_INT downto -DATA_FRA);

type CoefficientType is array (0 to TAP-1) of sfixed(COEFF_INT downto -COEFF_FRA);
signal coefficient : CoefficientType := (others => (others => '0'));

type TapBuffType is array (0 to TAP-1) of sfixed(DATA_INT + COEFF_INT + 1 
														downto -(DATA_FRA + COEFF_FRA));
signal tap_buff : TapBuffType := (others => (others => '0'));

signal tap_reg : sfixed(DATA_INT + COEFF_INT + 1 
						downto -(DATA_FRA + COEFF_FRA));

begin

-- input/output buffer
process(clk, rst)
begin
	if rst = '1' then
		data_in_buff <= (others => '0');
		data_out <= (others => '0');
	elsif rising_edge(clk) then
		if ce = '1' then
			data_in_buff <= to_sfixed(data_in, DATA_INT, -DATA_FRA);
			data_out <= to_slv(data_out_buff);
		end if;
	end if;
end process;

-- loading coefficients process
process(clk, rst)
begin
	if rst = '1' then
		coefficient <= (others => (others => '0'));
	elsif rising_edge(clk) then
		if (ce = '1') and (coeff_en = '1') then
			coefficient(TAP-1) <= to_sfixed(coeff, COEFF_INT, -COEFF_FRA);
			for j in TAP-1 downto 1 loop
				coefficient(j-1) <= coefficient(j);
			end loop;
		end if;
	end if;
end process;

-- transposed FIR filter
fir_gen: for i in 1 to TAP-1 generate
begin
	fir_inst: entity work.fir_unit_fixed 
	port map
	(	clk			=> clk,
		rst			=> rst,
		ce				=> ce,
		tap_in		=> tap_buff(i-1),
		coeff			=> coefficient(TAP-1-i),
		data_in		=> data_in_buff,
		data_out		=> tap_buff(i));
end generate fir_gen;

process(clk, rst)
begin
	if rst = '1' then
		tap_reg <= (others => '0');
		tap_buff(0) <= (others => '0');
		data_out_buff <= (others => '0');
	elsif rising_edge(clk) then
		if ce = '1' then
			tap_reg <= data_in_buff * coefficient(TAP-1);
			tap_buff(0) <= tap_reg;
			
			-- output
			data_out_buff <= resize(tap_buff(TAP-1), data_out_buff'high, data_out_buff'low);
		end if;
	end if;
end process;

end Behavioral;

