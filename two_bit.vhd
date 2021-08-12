--2bit dynamic branch predictor
--Nicholas Velcich (A20347373)

entity two_bit is
    port(
        prediction : buffer bit;
        branch : in bit;
        clk : in bit;
        miss : out bit);
end two_bit;

architecture only of two_bit is
    
    function increment(val : bit_vector) return bit_vector is
        alias input : bit_vector(1 downto 0) is val;
        variable result : bit_vector(input'range) := input;
        variable carry : bit := '1';
        begin
            for i in input'low to input'high loop
                result(i) := input(i) xor carry;
                carry := input(i) and carry;
                exit when carry = '0';
            end loop;
            return result;
        end increment;

        function decrement(val : bit_vector) return bit_vector is
            alias input : bit_vector(1 downto 0) is val;
            variable result : bit_vector(input'range) := input;
            variable carry : bit := '0';
            constant sub :  bit_vector(input'range) := "11";
            begin
                for i in input'low to input'high loop
                    result(i) := (input(i) xor sub(i)) xor carry;
                    carry := (input(i) and sub(i)) or (carry and result(i));
                end loop;
                return result;
            end decrement;

    begin
        process (clk) is
            variable counter : bit_vector(1 downto 0) := "00";
            variable miss_buff: bit := '0';
            begin
                if clk'event and clk = '1' then
                  
                    miss_buff:=branch xor prediction;
                    --report "miss_buff branch prediction:" &bit'image(miss_buff) &bit'image(branch) &bit'image(prediction);
                    --report "counter:" &bit'image(counter(1)) &bit'image(counter(0));
                    if branch = '1' and counter /= "11"  then
                        counter := increment(counter);
                        prediction <= counter(1);
                    end if;
                    
                    if branch = '0' and counter /= "00" then
                        counter := decrement(counter);
                        prediction <= counter(1);
                    end if;

                    if miss_buff = '1' then
                        miss<='1', '0' after 2 ns;
                    
                    end if;
                end if;
            end process;
    end only;