--1bit dynamic branch predictor
--Nicholas Velcich (A20347373)

entity one_bit is
    port(prediction : buffer bit;
        branch : in bit;
        miss_buff : buffer bit;
        miss : out bit);
end one_bit;

architecture only of one_bit is
    
    begin
      
           process (branch) is
            begin
                    --report "branch xor prediction =" & bit'image(branch xor prediction);
                    --report "branch pre loop =" & bit'image(branch);
                    --report "prediction pre loop =" & bit'image(prediction);
                    --miss_buff<=branch xnor prediction;
                    --if miss_buff = '1' then
                        --report "branch in loop =" & bit'image(branch);
                        prediction<=branch;
                        miss<='1', '0' after 2 ns;
                    --end if;
                
            end process;
            
    end only;