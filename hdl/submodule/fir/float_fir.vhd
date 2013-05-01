----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:18:10 04/26/2013 
-- Design Name: 
-- Module Name:    float_fir - Behavioral 
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

entity float_fir is
    Port (	clk 				: in  STD_LOGIC;
				rst 				: in  STD_LOGIC;
				ce 				: in  STD_LOGIC;
				
				coeff_en			: in	STD_LOGIC;
				coeff				: in	STD_LOGIC_VECTOR (WIDTH_COEFF_FLOAT-1 downto 0);
				
				data_in 			: in  STD_LOGIC_VECTOR (WIDTH_DATA_FLOAT-1 downto 0);
				data_out 		: out  STD_LOGIC_VECTOR (WIDTH_DATA_FLOAT-1 downto 0));
end float_fir;

architecture Behavioral of float_fir is

begin


end Behavioral;

