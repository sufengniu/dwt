----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Sufeng Niu
-- 
-- Create Date:    01:19:58 04/11/2013 
-- Design Name: 
-- Module Name:    fir - Behavioral 
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

entity fir is
    Port ( clk						: in  STD_LOGIC;
           rst						: in  STD_LOGIC;
           ce						: in  STD_LOGIC;
			  coeff_en				: in	STD_LOGIC;
			  coeff					: in	STD_LOGIC_VECTOR (COEFF_WIDTH downto 0);
           data_in				: in  STD_LOGIC_VECTOR (DATA_WIDTH downto 0);
           data_out				: out  STD_LOGIC_VECTOR (DATA_WIDTH downto 0));
end fir;

architecture Behavioral of fir is

begin

FIXED_GEN: if (data_form = "fixed") generate
begin
	FIXED_FIR: entity work.fixed_fir
	port map(	clk			=> clk,
					rst			=> rst,
					ce				=> ce,
					coeff_en		=> coeff_en,
					coeff			=> coeff(WIDTH_COEFF_FIXED downto 0),
					data_in		=> data_in(WIDTH_DATA_FIXED downto 0),
					data_out		=> data_out(WIDTH_DATA_FIXED downto 0));
end generate FIXED_GEN;

FLOAT_GEN: if (data_form = "float") generate
begin
	FLOAT_FIR: entity work.float_fir
	port map(	clk			=> clk,
					rst			=> rst,
					ce				=> ce,
					coeff_en		=> coeff_en,
					coeff			=> coeff,
					data_in		=> data_in,
					data_out		=> data_out);
end generate FLOAT_GEN;

end Behavioral;

