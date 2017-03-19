#Annie Latsko
#creates a dataset with just the new members of congress that are entering that year
#this is in a separate file b/c you guys might be good at R and be able to do this in R pretty easily; i'm bad at it.

import csv
import sys


output_file = "new_members.csv"
input_file = "full_data.csv"

index_of_incumbent = 3

def isolate(in_file, out_file):
	new_members = []
	with open(in_file,'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		header = ",".join(header)
		header += '\n'
		new_members.append(header)
		for row in reader:
			if row[index_of_incumbent] == "No":
				row = ",".join(row)
				row += '\n'
				new_members.append(row)
	f.close()
	g = open(out_file, 'w')
	for c in new_members:
		g.write(c)
	g.close()


if __name__ == "__main__":
	isolate(input_file, output_file)