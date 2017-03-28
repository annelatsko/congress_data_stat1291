#Annie Latsko
#OG datafile: congress-terms.csv

import csv
import sys


#notes: 
#	25-64 OG data goes from		 		1960 to 2014
#	65+ OG data goes from			 	1960 to 2015
#	US population OG data goes from 	1960 to 2015
#	GDP OG data goes from 				1929 to 2016
# 	congress-terms.csv goes from 		1947 to 2013
#	unemployment OG data goes from 		1947 to 2016
#	population change OG data goes from 2010 to 1937 (??backwards??)
#	gdp change OG data goes from 		1930 to 2015

 
#change these to get the years that you want, note the info above
#implemented so that these are inclusive
MIN_YEAR = 1960	
MAX_YEAR = 2010

og_65_plus = "dirty_data/OG_percent_of_population_65_older.csv"
cleaned_65_plus = "clean_data/percentage_65_plus.csv"

og_25_to_64 = "dirty_data/OG_population_25_to_64.csv"
cleaned_25_to_64 = "clean_data/percentage_25_64.csv"

og_us_population = "dirty_data/OG_us_population.csv"
cleaned_us_population = "clean_data/us_population.csv"

og_gdp = "dirty_data/OG_gdp_in_billions.csv"
cleaned_gdp = "clean_data/gdp.csv"

og_unemployment = "dirty_data/OG_unemployment_data.csv"
cleaned_unemployment = "clean_data/unemployment.csv"

og_gdp_change = "dirty_data/OG_gdp_change.csv"
cleaned_gdp_change = "clean_data/gdp_change.csv"

og_pop_change = "dirty_data/OG_us_population_change_by_year.csv"
cleaned_pop_change = "clean_data/us_population_change.csv"

og_congress = "dirty_data/OG_congress-terms.csv"
cleaned_congress = "clean_data/congress-terms.csv"

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
1. turn "data in billions" into just "straight billions" (commented out b/c this made stuff weird)
2. restrain dates to MAX_YEAR and MIN_YEAR
'''
def clean_gdp(dirty,clean):
	cleaned_data = []
	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[0] + ',' + header[1] + '\n'
		cleaned_data.append(h)
		for row in reader:
			year = row[0]
			if int(year) <= MAX_YEAR and int(year) >= MIN_YEAR:	
				gdp = row[1]
				####comment out below if you don't want to change this to billions
				#gdp = float(gdp) * 1000000000
				cleaned = year + ',' + str(gdp) + '\n'
				cleaned_data.append(cleaned)
	f.close()

	write_back_to_file(clean, cleaned_data)

'''
goal:
1. constrain dates to MAX_YEAR and MIN_YEAR
'''
def clean_unemployment(dirty,clean):
	cleaned_data = []
	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[0] + ',' + header[1] + '\n'
		cleaned_data.append(h)
		for row in reader:
			year = row[0]
			if int(year) <= MAX_YEAR and int(year) >= MIN_YEAR:	
				unemployment = row[1]
				cleaned = year + ',' + unemployment + '\n'
				cleaned_data.append(cleaned)
	f.close()

	write_back_to_file(clean, cleaned_data)


'''
goal:
1. constrain dates to MAX_YEAR and MIN_YEAR
'''

def clean_gdp_change(dirty,clean):
	cleaned_data = []
	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[0] + ',' + header[1] + '\n'
		cleaned_data.append(h)
		for row in reader:
			year = row[0]
			if int(year) <= MAX_YEAR and int(year) >= MIN_YEAR:	
				gdp_change = row[1]
				cleaned = year + ',' + gdp_change + '\n'
				cleaned_data.append(cleaned)
	f.close()

	write_back_to_file(clean, cleaned_data)

'''
goals:
1. get rid of quoted "amount change" (comment labeled line out if you want to keep this)
2. flip dates so that they're going from lowest to highest
3. constrain dates
'''
def clean_pop_change(dirty,clean):
	cleaned_data = []
	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[0] + ',' + header[1] + '\n'
		###comment out above line and uncomment below line if you want to include actual amount the population changed
		#h = header[0] + ',' + header[1] + ',' + header[2] + '\n'
		for row in reader:
			year = row[0]
			if int(year) <= MAX_YEAR and int(year) >= MIN_YEAR:	
				pop_change = row[1]
				cleaned = year + ',' + pop_change + '\n'
				###comment out above line and uncomment below line if you want to include actual amount the population changed
				#cleaned = year + ',' + pop_change + ',' + row[2] + '\n'
				cleaned_data.insert(0, cleaned)			#inserts at end of the list, which flips dates around
				#cleaned_data.append(cleaned)
				cleaned_data.insert(0, h)	#this happens later than usual b/c we need to put it at index 0 of list
	f.close()

	write_back_to_file(clean, cleaned_data)


'''
format: 0congress,1chamber,2bioguide,3firstname,4middlename,5lastname,6suffix,7birthday,8state,9party,10incumbent,11termstart,12age
goals:
1. change termstart to just year
3. keep: 1,8,9,10,11,12
4. constrain years
'''
def clean_congress(dirty,clean):
	cleaned_data = []
	with open(dirty, 'rb') as f:
		reader = csv.reader(f)
		header = next(reader)
		h = header[1] + ',' + header[8] + ',' + header[9] + ',' + header[10] + ',' + header[11] + ',' + header[12] + ',' + header[2] +'\n'
		cleaned_data.append(h)
		for row in reader:	
			year = clean_year(row[11])
			if int(year) <= MAX_YEAR and int(year) >= MIN_YEAR:	
				if row[9] == "ID":
					row[9] = "I";
				cleaned = row[1] + ',' + row[8] + ',' + row[9] + ',' + row[10] + ',' + year + ',' + row[12] + ',' + row[2] + '\n'
				cleaned_data.append(cleaned)
	f.close()

	write_back_to_file(clean, cleaned_data)


if __name__ == "__main__":
	clean_65_plus(og_65_plus,cleaned_65_plus)
	us_population_dict = clean_us_population(og_us_population,cleaned_us_population)
	clean_25_64(og_25_to_64,cleaned_25_to_64,us_population_dict)
	clean_gdp(og_gdp,cleaned_gdp)
	clean_unemployment(og_unemployment, cleaned_unemployment)
	clean_gdp_change(og_gdp_change,cleaned_gdp_change)
	clean_pop_change(og_pop_change,cleaned_pop_change)
	clean_congress(og_congress,cleaned_congress)
