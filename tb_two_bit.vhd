--test bench for 1bit dynamic branch predictor
--Nicholas Velcicih (A20347373)

use std.textio.all;

entity tb_two_bit is 
    --port();
end tb_two_bit;

architecture only of tb_two_bit is

    component two_bit
        port(prediction : buffer bit;
            branch : in bit;
            clk : in bit;
            miss : out bit);
    end component;

    signal clk : bit := '0';
    signal branch : bit := '0';
    signal miss : bit := '0';
    signal stop : bit := '0';
    
    begin
        dut : two_bit
            port map(
                branch=>branch,
                clk=>clk,
                miss=>miss
            );
        clock : process
            begin
                wait for 50 ns;
                if stop = '0' then
                  clk <= not clk;
                else
                  clk <= not clk;
                  wait for 50 ns;
                  clk <= not clk;
                  wait for 50 ns;
                  wait;
              end if;
            end process clock;
          
        miss_count : process (miss) is
        variable M : integer := 0;
          begin
          
            if miss = '1' then
                --report "miss";
                M := M+1;
                report "Total Miss Count:" & integer'image(M);
            end if;
          end process miss_count;
          
        
        read_file : process(clk)
                variable read_line : line;
                variable read_string: string (1 to 4);
                file read_file : text is in "test.txt";
            begin
                if not endfile(read_file) and clk = '1' then
                    readline (read_file, read_line);
                    read (read_line, read_string);
                    report read_string;
                    --report read_string;
                    if read_string(4)='T' then
                      --report "Taken";
                      branch <= '1';
                    else
                        --report "Not Taken";
                        branch <= '0';
                  end if;
                    
                    
                end if;
                
                if endfile(read_file) then
                  stop <= '1';
              end if;

        end process read_file;
        
        
    end only;
