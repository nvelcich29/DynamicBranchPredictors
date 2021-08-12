#zero out registers
AND t0, t0, zero	#first loop iterator
AND t1, t1, zero	#second loop iterator
AND t2, t2, zero	#variable 'c'
AND t3, t3, zero	#used as boolean variable for
			#checking loop conditions
LOOP1:			#outer for loop begin
AND t1, t1, zero	#zero out second loop iterator
LOOP2:			#inner for loop begin
ADDI t1, t1, 1 		#increment second loop iterator
ADDI t2, t2, 1 		#increment 'c'
SLTI t3, t1, 4 		#sets t3 to 1 if t1<4 else 0
BNE t3, zero, LOOP2	#branch to LOOP2 if t1<4

ADDI t0, t0, 1 		#increment first loop iterator
SLTI t3, t0, 1000 	#sets t3 to 1 if t0<1000 else 0
BNE t3, zero, LOOP1	#branch to LOOP1 if t0<1000