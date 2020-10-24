-- fsm.vhd: Finite State Machine
-- Author(s): 
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
-- cases:   TEST_KEYnumber_CODE_expected
-- example: TEST_K0102_C_2
-- meaning: TEST for code: 1 and 2, expect number: 2
architecture behavioral of fsm is
   type t_state is (TEST_CODE_START,
	TEST_K0102_C_2, TEST_K0102_C_24, TEST_K0102_C_243,
	TEST_K0102_C_2435, TEST_K0102_C_24354, TEST_K0102_C_243542, -- branch - key 1 and 2
	TEST_K01_C_2435422, TEST_K01_C_24354224, TEST_K01_C_243542242, TEST_K01_C_2435422426, -- branch - key 1
	TEST_K02_C_2435426, TEST_K02_C_24354268, TEST_K02_C_243542682, TEST_K02_C_2435426820, -- branch - key 2
	TEST_CODE_ERROR, PRINT_ERROR, PRINT_SUCCESS, FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= TEST_CODE_START;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
	-- - - - - - - - - - - - - - - - - - - - - - -
	--				BRANCH - KEY 1 and 2				  --
	-- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_CODE_START =>
      next_state <= TEST_CODE_START;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(2) = '1') then
			next_state <= TEST_K0102_C_2;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_K0102_C_2 =>
      next_state <= TEST_K0102_C_2;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(4) = '1') then
			next_state <= TEST_K0102_C_24;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K0102_C_24 =>
      next_state <= TEST_K0102_C_24;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(3) = '1') then
			next_state <= TEST_K0102_C_243;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K0102_C_243 =>
      next_state <= TEST_K0102_C_243;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(5) = '1') then
			next_state <= TEST_K0102_C_2435;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K0102_C_2435 =>
      next_state <= TEST_K0102_C_2435;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(4) = '1') then
			next_state <= TEST_K0102_C_24354;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K0102_C_24354 =>
      next_state <= TEST_K0102_C_24354;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(2) = '1') then
			next_state <= TEST_K0102_C_243542;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K0102_C_243542 =>
      next_state <= TEST_K0102_C_243542;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(2) = '1') then
			next_state <= TEST_K01_C_2435422;
		elsif (KEY(6) = '1') then
			next_state <= TEST_K02_C_2435426;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	--		   END OF BRANCH - KEY 1 and 2		  --
	-- - - - - - - - - - - - - - - - - - - - - - -
   -- - - - - - - - - - - - - - - - - - - - - - -
	--					 BRANCH - KEY 1				  --
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K01_C_2435422 =>
      next_state <= TEST_K01_C_2435422;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(4) = '1') then
			next_state <= TEST_K01_C_24354224;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K01_C_24354224 =>
      next_state <= TEST_K01_C_24354224;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(2) = '1') then
			next_state <= TEST_K01_C_243542242;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K01_C_243542242 =>
      next_state <= TEST_K01_C_243542242;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(6) = '1') then
			next_state <= TEST_K01_C_2435422426;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K01_C_2435422426 =>
      next_state <= TEST_K01_C_2435422426;
      if (KEY(15) = '1') then
         next_state <= PRINT_SUCCESS; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
	--			   END OF BRANCH - KEY 1			  --
	-- - - - - - - - - - - - - - - - - - - - - - -
   -- - - - - - - - - - - - - - - - - - - - - - -
	--					 BRANCH - KEY 2				  --
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K02_C_2435426 =>
      next_state <= TEST_K02_C_2435426;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(8) = '1') then
			next_state <= TEST_K02_C_24354268;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K02_C_24354268 =>
      next_state <= TEST_K02_C_24354268;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(2) = '1') then
			next_state <= TEST_K02_C_243542682;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K02_C_243542682 =>
      next_state <= TEST_K02_C_243542682;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
		elsif (KEY(0) = '1') then
			next_state <= TEST_K02_C_2435426820;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_K02_C_2435426820 =>
      next_state <= TEST_K02_C_2435426820;
      if (KEY(15) = '1') then
         next_state <= PRINT_SUCCESS; 
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= TEST_CODE_ERROR;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	--			   END OF BRANCH - KEY 2			  --
	-- - - - - - - - - - - - - - - - - - - - - - -
	when TEST_CODE_ERROR =>
      next_state <= TEST_CODE_ERROR;
      if (KEY(15) = '1') then
         next_state <= PRINT_ERROR; 
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_ERROR =>
      next_state <= PRINT_ERROR;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when PRINT_SUCCESS =>
      next_state <= PRINT_SUCCESS;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= TEST_CODE_START; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= TEST_CODE_START;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_CODE_START | TEST_K0102_C_2 | TEST_K0102_C_24 | TEST_K0102_C_243 | 
	TEST_K0102_C_2435 | TEST_K0102_C_24354 | TEST_K0102_C_243542 | TEST_K01_C_2435422 | 
	TEST_K01_C_24354224 | TEST_K01_C_243542242 | TEST_K01_C_2435422426 | TEST_K02_C_2435426 | 
	TEST_K02_C_24354268 | TEST_K02_C_243542682 | TEST_K02_C_2435426820 | TEST_CODE_ERROR =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_ERROR =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
		FSM_MX_MEM     <= '0';
	-- - - - - - - - - - - - - - - - - - - - - - -
	when PRINT_SUCCESS =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
		FSM_MX_MEM     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
   end case;
end process output_logic;

end architecture behavioral;

