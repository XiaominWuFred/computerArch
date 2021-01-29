#Xiaomin 
import sys

file_name = 'C:/Users/wxm/Desktop/input.txt'
file_input = open(file_name, "r")
output =""
for line in file_input:
    line=line.strip('\n')
    tempList = line.split(",")
    result = ""
    
    if tempList[0] == "li":
        result = result + "1"
        temp = str(bin(int(tempList[1])))[2:]
        temp = temp.zfill(2)
        result = result + str(temp)
        temp = str(bin(int(tempList[2])))[2:]
        temp = temp.zfill(16)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
   # output = output + result + '\n'
  #      print (output)
        #print (result)
    if tempList[0] == "MA":
        result = result + "0100"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[4][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
   # output =output + result + '\n'
    #    print (output)
       # print (result)
    if tempList[0] == "MS":
        result = result + "0101"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[4][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
   # output =output + result + '\n'
   #     print (output)
      #  print (result)
    if tempList[0] == "l":
        result = result + "0110"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[4][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
   # output =output + result + '\n'
     #   print (output)
      #  print (result)
    if tempList[0] == "h":
        result = result + "0111"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[4][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
   # output =output + result + '\n'
     #   print (output)
      #  print (result)
    if tempList[0] == "bcw":
        result = result + "000000001"
        result = result + "00000"
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
    if tempList[0] == "nop":
        result = result + "000000000000000000000000"
        
   # output =output + result + '\n'
    #    print (output)
     #   print (result)
    if tempList[0] == "and":
        result = result + "000000010"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
  #  output =output + result + '\n'
     #   print (output)
     #   print (result)
    if tempList[0] == "or":
        result = result + "000000011"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
   # output =output + result + '\n'
    #    print (output)
     #   print (result)
    if tempList[0] == "popcnth":
        result = result + "000000100"
        result = result + "00000"
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
  #  output =output + result + '\n'
     #   print (output)
      #  print (result)
    if tempList[0] == "clz":
        result = result + "000000101"
        result = result + "00000"
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
 #   output =output + result + '\n'
    #    print (output)
      #  print (result)
    if tempList[0] == "rot":
        result = result + "000000110"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
  #  output =output + result + '\n'
     #   print (output)
     #   print (result)
    if tempList[0] == "shlhi":
        result = result + "000000111"
        temp = str(bin(int(tempList[1][0:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
  #  output =output + result + '\n'
   #     print (output)
      #  print (result)
    if tempList[0] == "a":
        result = result + "000001000"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
  #  output =output + result + '\n'
     #   print (output)
     #   print (result)
    if tempList[0] == "sfw":
        result = result + "000001001"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
  #  output =output + result + '\n'
     #   print (output)
    #    print (result)
    if tempList[0] == "ah":
        result = result + "000001010"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
  #  output =output + result + '\n'
     #   print (output)
    #    print (result)
    if tempList[0] == "sfh":
        result = result + "000001011"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
   #  output =output + result + '\n'
     #   print (output)
    #    print (result)   
    if tempList[0] == "ahs":
        result = result + "000001100"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        
    #    print (output)
      #  print (result)
  #  output =output + result + '\n'
    if tempList[0] == "sfhs":
        result = result + "000001101"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
   # output =output + result + '\n'
    #    print (output)
      #  print (result)
    if tempList[0] == "mpyu":
        result = result + "000001110"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
   # output =output + result + '\n'
   #     print (output)
      #  print (result)
    if tempList[0] == "absdb":
        result = result + "000001111"
        temp = str(bin(int(tempList[1][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[2][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
        temp = str(bin(int(tempList[3][1:])))[2:]
        temp = temp.zfill(5)
        result = result + str(temp)
    
    output =output + result + '\n'
        
     #   print (result)
        
def save(filename, contents): 
  fh = open(filename, 'w') 
  fh.write(contents) 
  fh.close() 
save('C:/My_Designs/ese345/ese345/instruction.txt', output)
