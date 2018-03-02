Price Prediction with Diamonds Dataset

date: 03/01/2018
author: Yijun Guo (yumao77@gmail.com)

### 1. Loading libraries and acquire some basic information related to the dataset

setwd('~/Documents/DataScience/R/UdacityR/')

library(ggplot2)
library(GGally)
library(scales)
library(memisc)
library(lattice)
library(MASS)
library(car)
library(reshape2)
library(dplyr)
library(gridExtra)

# sessionInfo()

data("diamonds")

?diamonds

View(diamonds)

dim(diamonds)
# 10 columns and over 50K rows

str(diamonds)
# carat, depth, table, x, y, z as num
# price as int
# cut, color, clarity as factor

summary(diamonds)
# cut: 5 levels (Fair, Good, Very Good, Premium, Ideal)
# color: 7 levels (diamond colour, from J (worst) to D (best))
# clarity: 8 levels (a measurement of how clear the diamond is (I1 (worst), SI1, SI2, VS1, VS2, VVS1, VVS2, IF (best)))
# price: in US dollars
# x, y, z: in mm


### 2. Top Carat and Price Value

head(sort(table(diamonds$carat), decreasing = T))
# top 6: less or equal to 1 carat
head(sort(table(diamonds$carat), decreasing = T), 20)
# top 10: the same as above. Less or equal to 1 carat


head(sort(table(diamonds$price), decreasing = T))
# top 6: less than 1000
head(sort(table(diamonds$price), decreasing = T), 10)
# top 10: less than 1000

### 3. Histogram and Scatterplot Review

ggplot(aes(x=price), data=diamonds) + 
  geom_histogram(bins=50)+scale_x_log10() + 
  ggtitle('Price Histogram with log10 Scale')
# bimodel distribution
# common distribution pattern: poor and rich groups

ggplot(aes(x=carat,y=price),data=diamonds) + 
  scale_x_continuous(lim=c(0.2,quantile(diamonds$carat,0.99))) + 
  scale_y_sqrt(lim=c(200,quantile(diamonds$price,0.99))) + 
  geom_jitter(alpha=0.1) + stat_smooth(method='lm')
# carat Vs price plot

ggplot(aes(x=carat,y=price,color=clarity),data=diamonds) + 
  scale_x_continuous(lim=c(0.2,quantile(diamonds$carat,0.99))) + 
  scale_y_sqrt(lim=c(200,quantile(diamonds$price,0.99))) + 
  geom_jitter(alpha=0.1) + stat_smooth(method='lm')
# similar plots as the above one. Added clarity into the plot


### 4. ggpairs with 5000 random selected samples

# set.seed(5000)

# diamond_samp <- diamonds[sample(1:length(diamonds$price), 5000), ]
# sample 5,000 diamonds from the data set

# ggpairs(diamond_samp)
# ggsave('ggpairs_diamond.png',width=12, height= 12)
# price shows strong depence on carat, x, y, z


### 5. Creating a size factor xyz

# Besides carat, are there other ways/measurement to get an idea about the size of a diamond?

diamonds$pricelog<-log10(diamonds$price)
diamonds$xyz<-(diamonds$x*diamonds$y*diamonds$z)^(1/3)
cor.test(diamonds$carat, diamonds$pricelog)
cor.test(diamonds$xyz, diamonds$pricelog)

# This newly created column: xyz is highly correlated with price variable
# xyz (cube root of x*y*z) is a more complete way of evaluating diamond size than carat (which is just the weight of the diamond)

ggplot(aes(x=xyz, y=price), data = diamonds) + geom_point() + scale_y_log10()
# outliers at the left side of the plot are due to the fact that there are 0 in x, y, z

ggplot(aes(x=xyz, y=price), data = diamonds) + 
  scale_x_continuous(lim=c(3,quantile(diamonds$xyz,0.99))) + 
  geom_point(alpha=0.1) + 
  scale_y_log10(lim=c(500,quantile(diamonds$price,0.99))) + 
  ggtitle('Price (log10) by Cube-Root of xyz(size)')
# over-plotting
# changing alpha value does not help to solve this issue


### 6. We know size matters! But what else? Cut, Clarity and Color Variable

p1<-ggplot(aes(x=xyz, y=price, color=cut), data = diamonds) + 
  scale_x_continuous(lim=c(3,quantile(diamonds$xyz,0.99))) + 
  geom_point(alpha=0.1) + scale_y_log10(lim=c(500,quantile(diamonds$price,0.99))) + 
  ggtitle('xyz(size factor)+Cut Vs Price') + 
  scale_color_brewer(palette = "Reds", type = 'div', 
                     guide = guide_legend(title = 'cut', 
                                          reverse = T, 
                                          override.aes = list(alpha = 1, size = 2)))
 
table(diamonds$cut)
# very hard to see if there is any pattern
# although there are five levels in cut, most of the diamonds are Ideal, Premium or Very Good

p2<-ggplot(aes(x=xyz, y=price, color=clarity), data = diamonds) + 
  scale_x_continuous(lim=c(3,quantile(diamonds$xyz,0.99)))+ geom_point() + 
  scale_y_log10(lim=c(500,quantile(diamonds$price,0.99)))+ 
  ggtitle('xyz(size factor)+Clarity Vs Price') + 
  scale_color_brewer(palette = "Greens", 
                     type = 'div', guide = guide_legend(title = 'clarity', 
                     reverse = T, override.aes = list(alpha = 1, size = 2)))
# Under similar conditions, better clarity tends to go higher in price

p3<-ggplot(aes(x=xyz, y=price, color=color), data = diamonds) + 
  scale_x_continuous(lim=c(3,quantile(diamonds$xyz,0.99)))+ geom_point() + 
  scale_y_log10(lim=c(500,quantile(diamonds$price,0.99))) + 
  ggtitle('xyz(size factor)+Color Vs Price') + 
  scale_color_brewer(palette = "Blues", type = 'div', 
                     guide = guide_legend(reverse = T, title = 'color'))
# Under similar conditions, better color tends to go higher in price

# ColorClarityCutPrice<-grid.arrange(p1, p2, p3, ncol=3)
# ggsave('ColorClarityCutPrice.png', ColorClarityCutPrice, width = 24, height = 8)


### 7. Build a Linear Model with lm()

fit1 <- lm(log(price) ~ xyz, data = diamonds)
fit2 <- update(fit1, ~ . + color)
fit3 <- update(fit2, ~ . + clarity)
mtable(fit1, fit2, fit3)
# Build model with simply three variables: created size factor (xyz), color, cut
# R-squared reached 1