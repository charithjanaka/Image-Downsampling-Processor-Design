file1 = open('inrx.txt', 'r')
Lines = file1.readlines()

file2 = open('out2rx.txt','w')
file3 = open('out3rx.txt','w')
file4 = open('out4rx.txt','w')
 
count = 0
for line in Lines:
    count += 1
    modified = line[0:line.index('i')]
    file2.write(modified[0:5]+',')
    file3.write(modified[6:modified.index('-')]+',')
    file4.write(modified[modified.index('-')+1::]+',')
