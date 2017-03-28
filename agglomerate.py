#Annie Latsko
#knits all of the data together into one big data set
import csv
import sys

#where the agglomerated data will go
output_file = "full_data.csv"

#where the agglomerated data is coming from
#note that us_pop is not included b/c it doesn't tell us much
gdp = "clean_data/gdp.csv"
gdp_change = "clean_data/gdp_change.csv"
working_percentage = "clean_data/percentage_25_64.csv"
percentage_65_plus = "clean_data/percentage_65_plus.csv"
unemployment = "clean_data/unemployment.csv"
us_pop_change = "clean_data/us_population_change.csv"
congress = "clean_data/congress-terms.csv"

def add_to_header(m, row):	#appends the part of the header row that's not "Year" to the header for congress-terms
	main_header = m[0]
	main_header += ','
	main_header += row[1]
	return main_header


def agglomerate(input_files, output_file):
	main = input_files.pop(0)		#this will always be clean_data/congress-terms.csv
	m = []							#this is the list where congress-terms is stored; we will be adding to this.
	year_index = 0
	i = 0				
	with open(main, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		for index in header:
			if index == "termstart":
				year_index = i
			i+=1
		h = header[0] + ',' + header[1] + ',' + header[2] + ',' + header[3] + ',' + header[4] + ',' + header[5] + ',' + header[6]
		m.append(h)
		for row in reader:
			r_list = []
			for r in row:
				r_list.append(r)
			m.append(r_list)
	f.close()

	for fn in input_files:
		with open(fn,'rb') as f:
			add_to_me = []
			reader = csv.reader(f)
			header = next(reader)
			m[0] = add_to_header(m,header)
			add_to_me.append(m[0])
			for row in reader:
				year = row[0]
				data = row[1]
				for index,entry in enumerate(m):	#this lets me get the index to refer to later
					if entry[year_index] == year:
						entry.append(data)
						m[index] = entry
		f.close()

	final_m = []
	header = m.pop(0)
	header += '\n'
	final_m.append(header)
	for entry in m:
		entry = ','.join(entry)
		entry += '\n'
		final_m.append(entry)

	g = open(output_file, 'w')
	for c in final_m:
		g.write(c)
	g.close()

if __name__ == "__main__":
	files = [congress,gdp,gdp_change,working_percentage,percentage_65_plus,unemployment,us_pop_change]
	agglomerate(files,output_file)
