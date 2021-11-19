#!/usr/bin/python
import sys
import re
import csv

csvfilename = 'gaussian_stat.csv'
inputdata = ['16', '32', '64', '128', '256', 'matrix4', 'matrix208', 'matrix1024']

csvcolumn = ["kernel", "InputData", "MemLocation","A","B","M","label","TimePerc","Time","calls", "AVG","MIN","MAX"]
kernels = ["Fan1", "Fan2"]

with open(csvfilename, 'wb') as output_file:
  writer = csv.writer(output_file)
  writer.writerow(csvcolumn)
  
for k in kernels:
   for d in inputdata:
     for w in range(0, 2):
       if w == 0:
         memloc = "Global"
       elif w == 1:
         memloc = "Host"
       
       for x in range(0, 6):
         if x == 0:
           advA = "none"
         elif x == 1:
           advA = "cudaMemAdviseSetReadMostly"
         elif x == 2:
           advA = "cudaMemAdviseSetPreferredLocationGPU"
         elif x == 3:
           advA = "cudaMemAdviseSetAccessedByGPU"
         elif x == 4:
           advA = "cudaMemAdviseSetPreferredLocationGPU"
         elif x == 5:
           advA = "cudaMemAdviseSetPreferredLocationCPU"

         for y in range(0, 6):
           if y == 0:
             advB = "none"
           elif y == 1:
             advB = "cudaMemAdviseSetReadMostly"
           elif y == 2:
             advB = "cudaMemAdviseSetPreferredLocationGPU"
           elif y == 3:
             advB = "cudaMemAdviseSetAccessedByGPU"
           elif y == 4:
             advB = "cudaMemAdviseSetPreferredLocationGPU"
           elif y == 5:
             advB = "cudaMemAdviseSetPreferredLocationCPU"

           for z in range(0, 6):
             if z == 0:
               advM = "none"
             elif z == 1:
               advM = "cudaMemAdviseSetReadMostly"
             elif z == 2:
               advM = "cudaMemAdviseSetPreferredLocationGPU"
             elif z == 3:
               advM = "cudaMemAdviseSetAccessedByGPU"
             elif z == 4:
               advM = "cudaMemAdviseSetPreferredLocationGPU"
             elif z == 5:
               advM = "cudaMemAdviseSetPreferredLocationCPU"

             label = str(w)+str(x)+str(y)+str(z)
             filename = 'output_'+label+'_'+d+'.log'
             print "processing " + filename + " " 
             with open(filename, 'r') as f:
               lines = f.readlines()
               for line in lines:
                 if re.search('%s'%k, line):
                   line2 = re.search('(.+)%s'%k, line).group(1)
                   print line2
                   rr = re.findall("[-+]?[.]?[\d]+(?:,\d\d\d)*[\.]?\d*(?:[eE][+\-]?\d+)?",line2)
                   #rr = re.findall("([+-]?(?:0|[1-9]\d*)(?:\.\d*)?(?:[eE][+\-]?\d+))",line)
                   rr.insert(0, label)
                   rr.insert(0, advM)
                   rr.insert(0, advB)
                   rr.insert(0, advA)
                   rr.insert(0, memloc)
                   rr.insert(0, d)
                   rr.insert(0, k)
                   print rr
                   with open(csvfilename, 'a') as output_file:
                     writer = csv.writer(output_file)
                     writer.writerow(rr)
                   break
