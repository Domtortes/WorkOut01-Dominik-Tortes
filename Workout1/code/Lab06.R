# Title: Lab06: More Data Manipulation and Visualization
# Description:
#   This script performs cleaning tasks and transformations on 
#   various columns of the raw data file.
# Input(s): data file 'nba2018-players.csv'
# Output(s): data file 'clean-data.csv'
# Author: Dominik Tortes
# Date: 10-3-2018

# Packages
library(readr) #importing data
library(dplyr) #data wrangling
library(ggplot2) #graphics

#Exporting Data Tables
setwd('/Users/Dom/Desktop/hw-stat133-Domtortes/lab06/data')
read_csv('nba2018-players.csv')

warriors <- nba2018_players %>% filter(team == "GSW") %>% arrange(salary)

write.csv(warriors, '../output/warriors.csv')




