--test bench for shift register
--Nicholas Velcicih (A20347373)

use std.textio.all;

entity tb_shift_reg_test is 
    --port();
end tb_shift_reg_test;

architecture only of tb_shift_reg_test is

    signal clk : bit := '0';
    signal action : bit := '0';
    signal branch : bit := '0';
    signal stop : bit := '0';
    signal miss : bit := '0';
    
    
 
    component three_two
      port(branch : in bit;
        action : in bit;
        clk : in bit;
        miss_out : out bit);
      end component;
      

    

    begin
        
        predictor : three_two
          port map(
            branch => branch,
            action => action, 
            clk => clk,
            miss_out => miss);
            
        miss_catch : process(miss) is
        variable m : integer := 0;
        begin
          if miss = '1' then
            m := m+1;
            report "number of misses:" &integer'image(m);
          end if;
        end process miss_catch;
        
        read_file : process
            variable read_line : line;
            variable read_string: string (1 to 4);
            file read_file : text is in "test.txt";
            begin
                while not endfile(read_file) loop
                    readline (read_file, read_line);
                    read (read_line, read_string);
                    --report read_string;
                    if read_string(4) = 'T' then
                        action <= '1';
                    else
                        action <='0';
                    end if;
                    if read_string(2) = '2' then
                      branch <= '1';
                    else
                      branch <= '0';
                    end if;
                    
                    wait for 50 ns;
                    clk <= not clk;
                    wait for 50 ns;
                    clk <= not clk;
                   
                    
                    
                    
                    --report "outvec is:" &bit'image(outvec(2)) &bit'image(outvec(1)) &bit'image(outvec(0));
                end loop;
                
                
               
              
                wait;
                
        end process read_file;
        
        
    end only;
