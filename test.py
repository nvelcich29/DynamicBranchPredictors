
f = open('test.txt', 'w')

c=0

for i in range(1000):
    
    for j in range(4):
        
        c+=1
        
        #If j is less than 3 then the branch will be taken
        if j<3: 
            f.write("B2 T\n")
        
        #If j is 3 then the branch will be not taken
        else:
            f.write("B2 NT\n")
    
    #If i is less than 999 then the branch will be taken
    if i<999:
        f.write("B1 T\n")
    
    #If i is 999 then the branch will be not taken
    else:
        f.write("B1 NT\n")

f.close()

