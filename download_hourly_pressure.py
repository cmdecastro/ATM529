# -*- coding: utf-8 -*-
"""
Created on Tue Oct 31 13:43:21 2023

@author: Crizzia
"""

"""
Created on Thu Jun  8 02:28:15 2017
Updated on Thu Aug  2018
@author: ahmedlasheen

This method is the fastest one to download the data, another script is calling this 
script for all year at the same time, so all years are being downloaded simultaneously. 
see the shell script that has the same name as this script
"""
print(' importing libraries ....')
import sys
import cdsapi

year        = str(sys.argv[1])
month       = str(sys.argv[2])
diri_input  = str(sys.argv[3])
parm_name   = str(sys.argv[4])

print(year)
print(month)
print(diri_input)
print(parm_name)

c = cdsapi.Client()
c.retrieve('reanalysis-era5-pressure-levels',
           {
        'product_type':'reanalysis',
        'variable':parm_name,
        'year':year,
        'month':month,
        'pressure_level':['1000', '975', '950', '925', '900', '875', '850', '825', '800',  '775',
              '750', '700', '650', '600', '550', '500', '450', '400', '350',  '300',
              '250', '225', '200', '175', '150', '125', '100'],
        
        'day':['01','02','03','04','05',
           '06','07','08','09','10',
           '11','12','13','14','15',
           '16','17','18','19','20',
           '21','22','23','24','25',
           '26','27','28','29','30','31'],
        
        'time':[
        '00:00','01:00','02:00',
        '03:00','04:00','05:00',
        '06:00','07:00','08:00',
        '09:00','10:00','11:00',
        '12:00','13:00','14:00',
        '15:00','16:00','17:00',
        '18:00','19:00','20:00',
        '21:00','22:00','23:00'],
        'format':'netcdf',
        'grid': [1,1], # latitude and longitude grid: east-west and north-south.
        'area': [8,-180,-8,180] # north, west, south, and east
        },
        diri_input+parm_name+"_"+year+"_"+month+".nc")