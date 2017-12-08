import csv
import numpy as np
region = [3,4,4,3,4,4,1,3,3,3,4,4,2,2,2,2,3,3,1,3,1,2,2,3,2,4,2,4,1,1,4,1,3,2,2,3,4,1,1,3,2,3,3,4,1,3,4,3,2,4] 
data = []
with open('lymedata.csv') as f:
	for line in f.readlines():
		data.append(line.replace("\n","").split(","))

print(data)

transposed_data = [list(i) for i in zip(data)]


print(transposed_data)
