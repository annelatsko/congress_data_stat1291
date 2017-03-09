#Annie Latsko
#OG datafile: congress-terms.csv

import csv
import sys


#notes: 
#	percentage_25_64.csv goes from 		1960 to 2014
#	percentage_65_plus.csv goes from 	1960 to 2015
#	us_population.csv goes from 		1960 to 2015
#	gdp.csv goes from 					1929 to 2016
# 	congress-terms.csv goes from 		1947 to 2013

#change these to get the years that you want, note the info above
#implemented so that these are inclusive
MIN_YEAR = 1960	
MAX_YEAR = 2013


og_65_plus = "dirty_data/OG_percent_of_population_65_older.csv"
cleaned_65_plus = "clean_data/percentage_65_plus.csv"

og_25_to_64 = "dirty_data/OG_population_25_to_64.csv"
cleaned_25_to_64 = "clean_data/percentage_25_64.csv"

og_us_population = "dirty_data/OG_us_population.csv"
cleaned_us_population = "clean_data/us_population.csv"

og_gdp = "dirty_data/OG_gdp_in_billions.csv"
cleaned_gdp = "clean_data/gdp.csv"

'''
fixes date formatting
'''
def clean_year(y):
	year = y.split('-')
	return year[0]

'''
writes info back to file
'''
def write_back_to_file(filename, data):
	g = open(filename, 'w')
	for c in data:
		print c
		g.write(c)
	g.close()

'''
goals:
1. get rid of weird date format
2. trim down percentage to 2 sig digits
3. constrain dates to MIN_YEAR and MAX_YEAR
'''
def clean_65_plus(dirty, clean):
	cleaned_data = []
	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[0] + ',' + header[1] + '\n'
		cleaned_data.append(h)
		for row in reader:
			year = clean_year(row[0])
			if int(year) <= MAX_YEAR and int(year) >= MIN_YEAR:
				percentage = row[1]
				percentage = str(round(float(percentage), 2))
				cleaned = year + ',' + percentage + '\n'
				cleaned_data.append(cleaned)	
	f.close()

	write_back_to_file(clean, cleaned_data)

def clean_us_population(dirty,clean):
	cleaned_data = []
	us_pop = {}
	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[0] + ',' + header[1] + '\n'
		cleaned_data.append(h)
		for row in reader:
			year = clean_year(row[0])
			if int(year) <= MAX_YEAR and int(year) >= MIN_YEAR:
				total = row[1]
				cleaned = year + ',' + total + '\n'
				us_pop[year] = total
				cleaned_data.append(cleaned)	
	f.close()

	write_back_to_file(clean, cleaned_data)
	return us_pop


'''
goals:
1. get rid of weird date format
2. divide population between 25 and 64 by the total population
3. restrain significant digits
4. restrain dates to MIN_YEAR and MAX_YEAR
'''
def clean_25_64(dirty, clean, us_pop):
	cleaned_data = []
	total_population = {}
	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[0] + ',' + header[1] + '\n'
		cleaned_data.append(h)
		for row in reader:
			year = clean_year(row[0])
			if int(year) <= MAX_YEAR and int(year) >= MIN_YEAR:		
				target_population = row[1]
				total_pop_that_year = us_pop.get(year)	
				if total_pop_that_year != None:
					percentage = str(round(float(target_population)/int(total_pop_that_year),2))	
					cleaned = year + ',' + percentage + '\n'
					cleaned_data.append(cleaned)
	f.close()

	write_back_to_file(clean, cleaned_data)
'''
goal:
1. turn "data in billions" into just "straight billions"
2. restrain dates to MAX_YEAR and MIN_YEAR
'''
def clean_gdp(dirty,clean):
	print "thing"
	cleaned_data = []
	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[0] + ',' + header[1] + '\n'
		cleaned_data.append(h)
		for row in reader:
			print row
			year = row[0]
			if int(year) <= MAX_YEAR and int(year) >= MIN_YEAR:	
				gdp = row[1]
				print gdp
				####comment out below if you don't want to change this to billions
				gdp = float(gdp) * 1000000000
				print gdp
				cleaned = year + ',' + str(gdp) + '\n'
				cleaned_data.append(cleaned)
	f.close()

	write_back_to_file(clean, cleaned_data)

	

clean_65_plus(og_65_plus,cleaned_65_plus)
us_population_dict = clean_us_population(og_us_population,cleaned_us_population)
clean_25_64(og_25_to_64,cleaned_25_to_64,us_population_dict)
clean_gdp(og_gdp,cleaned_gdp)