----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:28:28 04/23/2013 
-- Design Name: 
-- Module Name:    fir_unit_fixed - Behavioral 
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

use IEEE.fixed_float_types.all;
use IEEE.fixed_pkg.all;
use IEEE.float_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--library IEEE_PROPOSED;
--use IEEE_PROPOSED.fixed_float_types.all;
--use IEEE_PROPOSED.fixed_pkg.all;
--use IEEE_PROPOSED.float_pkg.all;

library work;
use work.fir_pkg.all;

entity fir_unit_fixed is
    Port ( clk				: in  STD_LOGIC;
           rst				: in  STD_LOGIC;
           ce				: in  STD_LOGIC;
           tap_in			: in	sfixed(DATA_INT + COEFF_INT + 1 downto -(DATA_FRA + COEFF_FRA));
			  coeff			: in	sfixed(COEFF_INT downto -COEFF_FRA);
			  data_in		: in  sfixed(DATA_INT downto -DATA_FRA);
           data_out		: out	sfixed(DATA_INT + COEFF_INT + 1 downto -(DATA_FRA + COEFF_FRA)));
end fir_unit_fixed;

architecture Behavioral of fir_unit_fixed is

signal multi_res, multi_buff : sfixed(DATA_INT + COEFF_INT + 1 downto -(DATA_FRA + COEFF_FRA));
				
signal data_out_reg : sfixed(DATA_INT + COEFF_INT + 1 downto -(DATA_FRA + COEFF_FRA));

begin

process(clk, rst)
begin
	if rst = '1' then
		multi_buff <= (others => '0');
		data_out <= (others => '0');
	elsif rising_edge(clk) then
		if ce = '1' then
			multi_buff <= multi_res;
			data_out <= data_out_reg;
		end if;
	end if;
end process;

multi_res <= data_in * coeff;
data_out_reg <= resize(multi_buff + tap_in, data_out_reg'high, data_out_reg'low);
			
end Behavioral;
