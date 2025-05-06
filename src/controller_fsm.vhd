----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:42:49 PM
-- Design Name: 
-- Module Name: controller_fsm - FSM
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller_fsm is
    Port ( i_reset : in STD_LOGIC;
           i_adv : in STD_LOGIC;
           o_cycle : out STD_LOGIC_VECTOR (3 downto 0));
end controller_fsm;

architecture FSM of controller_fsm is

type sm_state is (s_state0, s_state1, s_state2,s_state3);
    
    signal f_Q, f_Q_next: sm_state;

begin

    f_Q_next <= s_state0 when ((f_Q = s_state0)and(i_adv = '0')) or
                              ((f_Q = s_state3)and(i_adv = '1')) else
                              
                s_state1 when ((f_Q = s_state1)and(i_adv = '0')) or
                              ((f_Q = s_state0)and(i_adv = '1')) else  
                              
                s_state2 when ((f_Q = s_state2)and(i_adv = '0')) or
                              ((f_Q = s_state1)and(i_adv = '1')) else 
                               
                s_state3 when ((f_Q = s_state3)and(i_adv = '0')) or
                              ((f_Q = s_state2)and(i_adv = '1')) else  
                              
                              s_state0;   
                              
       with f_Q select
        o_cycle <= "0001" when s_state0,
                   "0010" when s_state1,
                   "0100" when s_state2,
                   "1000" when s_state3;
                   
                   
       
       register_proc : process (i_adv, i_reset)
begin
     if (i_adv = '1' and i_reset = '0')then
        f_Q <= f_Q_next;   
     elsif (i_adv = '0' and i_reset = '1')then
        f_Q <= s_state0;        
     end if;    
end process register_proc;     
                          
    
end FSM;
