# WorkOut01-Dominik-Tortes

#alot went on in this assignment Most time consuming things were the little things like forgetting variables and what not. 
####TITLE: TEAM TABLE
###DESCRIPTION: Efficiency Allocation
###INPUT:?
###OUTPUT:?



library('readr')

library('dplyr')

library('ggplot2')

library('base')

setwd('/Users/Dom/Desktop/hw-stat133-Domtortes/Workout1/data')

data <- read_csv('nba2018.csv')

#============
###Data Prep
#============


#Experience
data$experience <- as.integer(data$experience)
experience <- data$experience
experience[experience == "R"] = 0


#Salary

salary <- (data$salary/1000000)
data$salary = round(salary, digits = 2)


##Position

pos <- c(data$position)
pos1 <- factor(pos)
levels(pos1)[1] <- "Center"
levels(pos1)[2] <- "power_fwd"
levels(pos1)[3] <- 'point_guard'
levels(pos1)[4] <- "small_fwd"
levels(pos1)[5] <- "shoot_guard" 

data$position = pos1

### Adding New Variables

fgA <- c(data$field_goals_atts)
Fg <- c(data$field_goals)
data$missed_fg <- fgA - Fg
missed_fg <- data$missed_fg

Fta <- c(data$points1_atts)
Ft <- c(data$field_goals)
data$missed_ft = Fta - Ft
missed_ft <- data$missed_ft

ofrb <- c(data$off_rebounds)
dfrb <- c(data$def_rebounds)
data$rebounds <- ofrb + dfrb
rebounds <- data$rebounds

pts <- c(data$points)
asts <- c(data$assists)
stls <- c(data$steals)
blks <- c(data$blocks)
trnovr <- c(data$turnovers)
gmpld <- c(data$games_started)

data$efficiency <- (pts + rebounds + asts + stls +blks - missed_fg - missed_ft - trnovr)/ gmpld
efficiency <- data$efficiency

setwd('/Users/Dom/Desktop/hw-stat133-Domtortes/Workout1/code')
EFFSUM <- summary(efficiency)

sink('../output/efficiency-teams.txt')
EFFSUM
sink()

#=============================
#Creating nba 2018-teams.csv
#=============================


nbateams <- data.frame(summarize(group_by(data, team), 
                              experience = sum(experience), 
                              salary = sum(salary), 
                              points3 = sum(points3), 
                              points2 = sum(points2), 
                              points1 = sum(points1), 
                              points = sum(points), 
                              off_rebounds = sum(off_rebounds), 
                              def_rebounds = sum(def_rebounds), 
                              assists = sum(assists), 
                              steals = sum(steals), 
                              blocks = sum(blocks), 
                              turnovers = sum(turnovers), 
                              fouls = sum(fouls), 
                              efficiency = sum(efficiency)))

sink('../data/team-summary.txt')
nbateams
sink()

write_csv(nbateams,'../data/nba2018-teams.csv' )
