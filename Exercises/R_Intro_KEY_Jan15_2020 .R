# KEY "Introduction to R - Spring 2020"
# Rob Wells, PhD
# 1/20/2020

# ------- Get Organized --------- #  
#Create a folder on your Desktop: name it DataSpring2020
#Store this file and the Census data in this folder: OPEN FILE IN A WEB BROWSER
https://learn.uark.edu/bbcswebdav/courses/MASTER-1203-THEUA-JOUR-405V-SEC007/USArk_Counties_Poverty_ACS_16_5YR_DP03_Jan_24.xlsx

#----------------------------------------------------#
#YOU ONLY DO THIS ONCE BELOW:
###Set Working Directory. My directory "~/Dropbox/Classes/Data-Analysis-Class-Jour-405v-5003" is an example
#install.packages("here")
#library(here)
#This aligned this file with that directory and saves a huge hassle
#----------------------------------------------------#

#  Orientation about R Studio  
#  There are four main windows:  

# Script writing, R Markdown, Table Viewer: Upper Left  
# Environment - data loaded in R: Upper Right  
# Console - write commands in R: Lower Left  
# File Manager and Html table viewer: Bottom Right  

#Create a script to put all your code -- top left window. 
#File > New File > R Script  

#Download Census data into that folder

#Install software to grab data
#tidyverse installs 8 separate software packages to perform
#data import, tidying, manipulation, visualisation, and programming

#YOU ONLY DO THIS ONCE PER COMPUTER
#install.packages("tidyverse")

#I like the rio package for its easy importing features and janitor for data cleaning
##rio handles more than two dozen formats including tab-separated data (with the extension .tsv), 
#install.packages("rio") 
#install.packages("janitor")

#LOAD SOFTWARE
#
#After you install a package on your hard drive, you can call it back up by summoning a library
#Libraries are bits of software you will have to load each time into R to make things run. 
library(tidyverse)
library(rio)
library(janitor)
#
#Check to see  what's installed by clicking on "Packages" tab in File Manager, lower right pane

#

#Check out Census data: COPY THIS URL INTO A WEB BROWSER
#https://learn.uark.edu/bbcswebdav/courses/MASTER-1203-THEUA-JOUR-405V-SEC007/USArk_Counties_Poverty_ACS_16_5YR_DP03_Jan_24.xlsx

#
#Four Corners Test!
# Number Columns
# Number Rows
# Text, Numeric Data

#Import Data - Cleaned Version!
ArkCensus <- rio::import("USArk_Counties_Poverty_ACS_16_5YR_DP03_Jan_24.xlsx", which = "Poverty")
#
#Wells version
#ArkCensus <- rio::import("./Data/USArk_Counties_Poverty_ACS_16_5YR_DP03_Jan_24.xlsx", which = "Poverty")
#Alternate
#ArkCensus2 <- rio::import("https://github.com/profrobwells/HomelessSP2020/blob/master/Data/USArk_Counties_Poverty_ACS_16_5YR_DP03_Jan_24.xlsx?raw=true", which = "Poverty")

#Look at the table
View(ArkCensus)

#What happened?
#R grabbed the spreadsheet from the URL
#We told R to grab the first sheet, RealMediaSalaries2

# How many rows?  
nrow(ArkCensus)

# How many columns?
ncol(ArkCensus)

# Let's look at the first six rows
head(ArkCensus)

#Check data types
glimpse(ArkCensus)

#Names of your columns
colnames(ArkCensus)

#OR
names(ArkCensus)

#Summary: Here is a quick way to view the range of your data  
summary(ArkCensus$Median_Househ_Income)

#summary(ArkCensus$Median_Househ_Income)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#25724   34031   36377   37798   40011   59016 

#Questions:
#1: Run summary on Income_to25k
#2: Run summary on Pct_Income_to_25k

#Build a simple summary table by County
RichPoor <- ArkCensus %>% 
  select(Geography, Median_Househ_Income) %>% 
  group_by(Geography) %>% 
  arrange(desc(Median_Househ_Income))

#Filter
#
#What is the Median Household Income for United States
ArkCensus %>% 
  select(Geography, Median_Househ_Income) %>% 
  filter(Geography =="United States")
#
#Shortcut Commands
#Tab - Autocomplete
#In Console Window (lower left) 
#--Control (or Command) + UP arrow - last lines run
#Control (or Command) + Enter - Runs current or selected lines of code in the top left box of RStudio
#Shift + Control (or Command) +P - Reruns previous region code
#
#
#Question:
#3: What is the Median Household Income for Washington County, Arkansas

#--------------------
#HOMEWORK QUESTIONS#
#--------------------
#4: Median Household Income for Benton County, Arkansas
ArkCensus %>% 
  select(Geography, Median_Househ_Income) %>% 
  filter(Geography =="Benton County, Arkansas")

#5: Median Household Income for Pulaski County, Arkansas
ArkCensus %>% 
  select(Geography, Median_Househ_Income) %>% 
  filter(Geography =="Pulaski County, Arkansas")

#6: Median Household Income for Arkansas
ArkCensus %>% 
  select(Geography, Median_Househ_Income) %>% 
  filter(Geography =="Arkansas")
#
#
#With the Statewide Median Income, 
#Build a table with all counties above that median income

#Create a table with this 
AboveIncome <- ArkCensus %>% 
  select(Geography, Median_Househ_Income) %>% 
  filter(Median_Househ_Income > 42336) %>% 
  arrange(desc(Median_Househ_Income))
#
#  dplyr 
#select Choose which columns to include.
#filter Filter the data.
#arrange Sort the data, by size for continuous variables, by date, or alphabetically.
#group_by Group the data by a categorical variable.
#
#Question:
#7: Create a table of counties with the lowest quartile in income
ArkCensus %>% 
  select(Geography, Median_Househ_Income) %>% 
  filter(Median_Househ_Income <= 34031) %>% 
  arrange(desc(Median_Househ_Income))

#8: Find all Counties with 20% more earning $25,000 or less
#
ArkCensus %>% 
  select(Geography, Pct_Income_to_25k) %>% 
  filter(Pct_Income_to_25k >= 20) %>% 
  arrange(desc(Pct_Income_to_25k))
#Summary of the low income distribution
summary(ArkCensus$Pct_Income_to_25k)
#
#Which county has the lowest percentage of population in this low income bracket?
ArkCensus %>% 
  select(Geography, Pct_Income_to_25k) %>% 
  filter(Pct_Income_to_25k==8.80) %>% 
  arrange(desc(Pct_Income_to_25k))
#
#Question:
#9: #Which county has the highest percentage of population in this low income bracket?
ArkCensus %>% 
  select(Geography, Pct_Income_to_25k) %>% 
  filter(Pct_Income_to_25k==22.30) %>% 
  arrange(desc(Pct_Income_to_25k))


#Basic chart
ggplot(AboveIncome, aes(x = Geography, y = Median_Househ_Income)) + 
  geom_bar(stat = "identity") +
  coord_flip() +    #this makes it a horizontal bar chart instead of vertical
  labs(title = "Communities with high median income", 
       subtitle = "2016",
       caption = "Graphic by Wells",
       y="Place",
       x="Median Income")
#Plots Window
#Zoom
#Export

#Basic chart, adding color
#fill=Median_Househ_Income
ggplot(AboveIncome, aes(x = Geography, y = Median_Househ_Income, fill=Median_Househ_Income)) + 
  geom_bar(stat = "identity", show.legend = FALSE) +
  coord_flip() +    #this makes it a horizontal bar chart instead of vertical
  labs(title = "Communities with high median income", 
       subtitle = "2016",
       caption = "Graphic by Wells",
       y="Place",
       x="Median Income")
#Plots Window
#Zoom
#Export

#Basic chart, sorting
#sorting = aes(x = reorder(Geography, Median_Househ_Income), y = Median_Househ_Income, fill=Median_Househ_Income)) + 
#
ggplot(AboveIncome, aes(x = reorder(Geography, Median_Househ_Income), y = Median_Househ_Income, fill=Median_Househ_Income)) + 
  geom_bar(stat = "identity", show.legend = FALSE) +
  coord_flip() +    #this makes it a horizontal bar chart instead of vertical
  labs(title = "Communities with high median income", 
       subtitle = "2016",
       caption = "Graphic by Wells",
       y="Place",
       x="Median Income")
#Plots Window
#Zoom
#Export

#Basic chart, add labels
#labels = geom_text(aes(label = Median_Househ_Income), hjust = -.1, size = 2.2) +

ggplot(AboveIncome, aes(x = reorder(Geography, Median_Househ_Income), y = Median_Househ_Income, fill=Median_Househ_Income)) + 
  geom_bar(stat = "identity", show.legend = FALSE) +
  geom_text(aes(label = Median_Househ_Income), hjust = -.1, size = 2.2) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  coord_flip() +    #this makes it a horizontal bar chart instead of vertical
  labs(title = "Communities with high median income", 
       subtitle = "2016",
       caption = "Graphic by Wells",
       y="Place",
       x="Median Income")
#Plots Window
#Zoom
#Export
#
#Question
#10: Build a chart with top 10 counties with lowest median incomes
#Create a table with this 
LowestIncome <- ArkCensus %>% 
  select(Geography, Median_Househ_Income) %>% 
  filter(Median_Househ_Income <=	31233) %>% 
  arrange(Median_Househ_Income)
#
df <- ArkCensus %>%
  top_n(10, -Median_Househ_Income) %>%
  arrange(Median_Househ_Income)

#Split out county name
LowestIncome <- separate(LowestIncome, Geography, c('county', 'x', 'state'), sep=' ', remove=TRUE)
#
#Formatting
library(scales)
#
ggplot(LowestIncome, aes(x = reorder(county, Median_Househ_Income), y = Median_Househ_Income, fill=Median_Househ_Income)) + 
  geom_bar(stat = "identity", width = 0.5, show.legend = FALSE) +
  geom_text(aes(label = Median_Househ_Income), hjust = -.1, size = 2.8) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_y_continuous(limit = c(0, 35000), labels = dollar) +
  coord_flip() +    #this makes it a horizontal bar chart instead of vertical
  labs(title = "Communities with lowest median income", 
       subtitle = "2016",
       caption = "Graphic by Wells",
       y="Place",
       x="Median Income")
#--30--