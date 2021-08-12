--test bench for 1bit dynamic branch predictor
--Nicholas Velcicih (A20347373)

use std.textio.all;

entity tb_one_bit is 
    port(branch : buffer bit;
          miss : buffer bit);
end tb_one_bit;

architecture only of tb_one_bit is

    component one_bit
        port(prediction : buffer bit;
            branch : in bit;
            miss_buff : buffer bit;
            miss : out bit);
    end component;

   
    
    begin
       
        dut: one_bit
            port map(branch=>branch,
                        miss=>miss);
        
        miss_count : process (miss) is
        variable M : integer := 0;
        begin
          
            if miss = '1' then
                --report "miss";
                M := M+1;
                report "Total Miss Count:" & integer'image(M);
            end if;
          end process miss_count;
          
        read_file : process
                variable read_line : line;
                variable read_string: string (1 to 4);
                file read_file : text is in "test.txt";
            begin
                while not endfile(read_file) loop
                    readline (read_file, read_line);
                    read (read_line, read_string);
                    --report read_string;
                    if read_string(4)='T' then
                      --report "Taken";
                      branch <= '1';
                    else
                        --report "Not Taken";
                        branch <= '0';
                  end if;
                  
                  wait for 50 ns;
                end loop;

        end process read_file;
        
        
    end only;
