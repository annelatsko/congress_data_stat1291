#Annie Latsko
#OG datafile: congress-terms.csv

import csv
import sys

og_65_plus = "dirty_data/OG_percent_of_population_65_older.csv"
cleaned_65_plus = "clean_data/percentage_65_plus.csv"

og_25_to_64 = "dirty_data/OG_population_25_to_64.csv"
cleaned_25_to_64 = "clean_data/percentage_25_64.csv"

og_us_population = "dirty_data/OG_us_population.csv"
cleaned_us_population = "clean_data/us_population.csv"
'''
goals:
1. get rid of weird date format
2. trim down percentage to 2 sig digits
'''
def clean_65_plus(dirty, clean):
	cleaned_data = []
	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[0] + ',' + header[1] + '\n'
		cleaned_data.append(h)
		for row in reader:
			year = row[0]
			year = year.split('-')
			year = year[0]
			percentage = row[1]
			percentage = str(round(float(percentage), 2))
			cleaned = year + ',' + percentage + '\n'
			cleaned_data.append(cleaned)	
	#print cleaned_data
	f.close()

	g = open(clean, 'w')
	for c in cleaned_data:
		g.write(c)
	g.close()

def clean_us_population(dirty,clean):
	cleaned_data = []
	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[0] + ',' + header[1] + '\n'
		cleaned_data.append(h)
		for row in reader:
			year = row[0]
			year = year.split('-')
			year = year[0]
			total = row[1]
			cleaned = year + ',' + total + '\n'
			cleaned_data.append(cleaned)	
	#print cleaned_data
	f.close()

	g = open(clean, 'w')
	for c in cleaned_data:
		g.write(c)
	g.close()

'''
goals:
1. get rid of weird date format
2. divide population between 25 and 64 by the total population
3. restrain significant digits 
'''
def clean_25_64(dirty, clean, total_population_file):
	cleaned_data = []
	total_population = {}

	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[0] + ',' + header[1] + '\n'
		cleaned_data.append(h)
		for row in reader:
			year = row[0]
			year = year.split('-')
			year = year[0]
			population = row[1]
			percentage = str(round(float(percentage), 2))
			cleaned = year + ',' + percentage + '\n'
			cleaned_data.append(cleaned)
	print cleaned_data
	f.close()

	g = open(clean, 'w')
	for c in cleaned_data:
		g.write(c)
	g.close()

clean_65_plus(og_65_plus,cleaned_65_plus)
clean_us_population(og_us_population,cleaned_us_population)
clean_25_64(og_25_to_64,cleaned_25_to_64)