--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

library IEEE_PROPOSED;
use IEEE_PROPOSED.fixed_float_types.all;
use IEEE_PROPOSED.fixed_pkg.all;
use IEEE_PROPOSED.float_pkg.all;

package fir_pkg is

-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
-- Declare constants

------------------------------------------------	
	-- default data width
	constant DATA_WIDTH									: integer := 32;
	constant COEFF_WIDTH									: integer := 32;
	
	-- fixed point, the WIDTH_DATA_FIXED should be the same OR less then DATA_WIDTH!
	constant DATA_INT										: integer := 2;				-- input width integer part
	constant DATA_FRA										: integer := 13;				-- input width fractional part
	constant WIDTH_DATA_FIXED							: integer := DATA_INT + DATA_FRA + 1;

	constant COEFF_INT									: integer := 2;
	constant COEFF_FRA									: integer := 13;
	constant WIDTH_COEFF_FIXED							: integer := COEFF_INT + COEFF_FRA + 1;

	-- floating point, the WIDTH_DATA_FLOAT should be the same as DATA_WIDTH!
	constant DATA_EXP										: integer := 8;				-- floating point exp^M
	constant DATA_FPF										: integer := 23;				-- floating point fractinoal (FPF)^M
	constant WIDTH_DATA_FLOAT							: integer := DATA_FPF + DATA_EXP + 1;

	constant COEFF_EXP									: integer := 8;
	constant COEFF_FPF									: integer := 23;
	constant WIDTH_COEFF_FLOAT							: integer := COEFF_FPF + COEFF_EXP + 1;	
	
	-- filter order
	constant TAP											: integer := 8;

-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

--	impure function gen_value(Index: TableType) return ResType;

end fir_pkg;

package body fir_pkg is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end fir_pkg;
