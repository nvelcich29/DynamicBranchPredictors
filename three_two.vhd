library ieee;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_1164.all;

entity three_two is
  port(branch : in bit;
    action : in bit;
    clk : in bit;
    miss_out : out bit
    );
  end three_two;
  
architecture only of three_two is
  
  
  signal gbh : bit_vector(2 downto 0);
  signal b1_in : bit_vector(7 downto 0);
  signal b1_en : bit_vector(7 downto 0);
  signal b2_in : bit_vector(7 downto 0);
  signal b2_en : bit_vector(7 downto 0);
  signal miss : bit_vector(15 downto 0);
  
  
  component two_bit
        port(prediction : buffer bit;
            branch : in bit;
            clk : in bit;
            miss : out bit);
    end component;
  
  begin
    B1_7 : two_bit
    port map(
      branch => b1_in(7),
      clk => b1_en(7),
      miss => miss(7)
    );
    
    B1_6 : two_bit
    port map(
      branch => b1_in(6),
      clk => b1_en(6),
      miss => miss(6)
    );
    
    B1_5 : two_bit
    port map(
      branch => b1_in(5),
      clk => b1_en(5),
      miss => miss(5)
    );
    
    B1_4 : two_bit
    port map(
      branch => b1_in(4),
      clk => b1_en(4),
      miss => miss(4)
    );
    
    B1_3 : two_bit
    port map(
      branch => b1_in(3),
      clk => b1_en(3),
      miss => miss(3)
    );
    
    B1_2 : two_bit
    port map(
      branch => b1_in(2),
      clk => b1_en(2),
      miss => miss(2)
    );
    
    B1_1 : two_bit
    port map(
      branch => b1_in(1),
      clk => b1_en(1),
      miss => miss(1)
    );
    
    B1_0 : two_bit
    port map(
      branch => b1_in(0),
      clk => b1_en(0),
      miss => miss(0)
    );
    B2_7 : two_bit
    port map(
      branch => b2_in(7),
      clk => b2_en(7),
      miss => miss(15)
    );
    
    B2_6 : two_bit
    port map(
      branch => b2_in(6),
      clk => b2_en(6),
      miss => miss(14)
    );
    
    B2_5 : two_bit
    port map(
      branch => b2_in(5),
      clk => b2_en(5),
      miss => miss(13)
    );
    
    B2_4 : two_bit
    port map(
      branch => b2_in(4),
      clk => b2_en(4),
      miss => miss(12)
    );
    
    B2_3 : two_bit
    port map(
      branch => b2_in(3),
      clk => b2_en(3),
      miss => miss(11)
    );
    
    B2_2 : two_bit
    port map(
      branch => b2_in(2),
      clk => b2_en(2),
      miss => miss(10)
    );
    
    B2_1 : two_bit
    port map(
      branch => b2_in(1),
      clk => b2_en(1),
      miss => miss(9)
    );
    B2_0 : two_bit
      port map(
        branch => b2_in(0),
        clk => clk,
        miss => miss(8)
      );
      
    process(clk) is
      variable integer_result : integer := 0;
      variable itt : integer := 0;
      begin
        
        if clk = '1' then
          
          case gbh is
          when "000" =>
            integer_result := 0;
          when "001" =>
            integer_result := 1;
          when "010" =>
            integer_result := 2;
          when "011" =>
            integer_result := 3;
          when "100" =>
            integer_result := 4;
          when "101" => 
            integer_result := 5;
          when "110" => 
            integer_result := 6;
          when "111" =>
            integer_result := 7;
          end case;
          
          if branch = '0' then
            --report "branch = B1";
            b1_in(integer_result) <= action;
            b1_en(integer_result) <= '1', '0' after 5 ns;
          else
            --report "branch = B2";
            b2_in(integer_result) <= action;
            b2_en(integer_result) <= '1', '0' after 5 ns;
          end if;
          
          --report "action =" &bit'image(action);
          
          
          gbh(2 downto 1) <=gbh(1 downto 0);
          gbh(0) <= action;
          --report "gbh =" &bit'image(gbh(2)) &bit'image(gbh(1)) &bit'image(gbh(0));
          
          itt := itt + 1;
          report "Number of rounds in three two:" &integer'image(itt);
        end if;
      end process;
      
      miss_catch : process(miss) is
        begin
        if miss /= "0000000000000000" then
          miss_out <= '1' , '0' after 5 ns;
        end if;
      end process miss_catch;
    
end only;
