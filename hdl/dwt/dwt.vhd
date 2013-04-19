----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:38:52 04/11/2013 
-- Design Name: 
-- Module Name:    dwt - Behavioral 
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

library work;
use work.dwt_pkg.all;

entity dwt is
    Generic (
	   
				);
    Port ( clk						: in  STD_LOGIC;
           rst						: in  STD_LOGIC;
           ce						: in  STD_LOGIC;
			  
           data_in_rdy			: out  STD_LOGIC;
           data_in				: in  STD_LOGIC_VECTOR( downto 0);
           data_in_valid		: in  STD_LOGIC;
           
			  data_out				: out  STD_LOGIC_VECTOR( downto 0));
end dwt;

architecture Behavioral of dwt is

begin


end Behavioral;

