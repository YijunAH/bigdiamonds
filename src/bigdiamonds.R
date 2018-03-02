Price Prediction with Bigdiamonds Dataset

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
library('bitops')
library('RCurl')

load("/Users/yijunguo/Downloads/BigDiamonds.Rda")

bigdiamonds<-diamondsbig

### 2. Cleaning and Formating the bigdiamonds datasets

View(bigdiamonds)
# two new columns comparing with the diamond dataset: cert and measurement
# cert: according to Blue Nile, a diamond certificate, also called a diamond grading report, is a report created by a team of gemologists. Two common laboratories for doing such analysis and generate certificates are: Gemological Institute of America (GIA) and the American Gem Society Laboratories (AGSL)
# measurement: x, y, z information, stored as charater

dim(bigdiamonds)
# 598024 rows and 12 columns

str(bigdiamonds)
# cut: 3 levels, different from the diamond dataset which has 5 levels
# color: 9 levels, different from the diamond dataset which has 7 levels
# clarity: 10 levels, different from the diamond dataset which has 8 levels
# cut, color and clarity columns: slight different structure
# cert: 9 levels
# a  bunch of NA in price

summary(bigdiamonds)
# table and depth: Min is 0 which should not be the case due to the nature of the data
# cert: most of them are done at GIA
# price have 713 NA's
# x, y, z have 1000-2000 NA values

summary(diamondsbig$price)
# median is 3503, while mean is 8753

bigdiamonds<-subset(bigdiamonds, !is.na(bigdiamonds$price))
# since we want to do price prediction, we first remove those rows where price==NA

# ggplot(aes(x=price), data= diamondsbig) + stat_ecdf(geom = "step")
# ggplot(aes(x=price, color=cut), data= diamondsbig) + stat_ecdf()
# ggplot(aes(x=price, color=color), data= diamondsbig) + stat_ecdf()
# ggplot(aes(x=price, color=clarity), data= diamondsbig) + stat_ecdf()

# bigdiaZ_NA<-subset(bigdiamonds, is.na(bigdiamonds$z))

bigdiamonds<-subset(bigdiamonds, !is.na(bigdiamonds$x))
bigdiamonds<-subset(bigdiamonds, !is.na(bigdiamonds$y))
bigdiamonds<-subset(bigdiamonds, !is.na(bigdiamonds$z))
# removed 3000 rows with missing x, y , z

# summary(bigdiamonds)

bigdiamonds$measurements<-NULL

bigdiamonds$pricelog<-log10(bigdiamonds$price)

bigdiamonds$xyz<-(bigdiamonds$x*bigdiamonds$y*bigdiamonds$z)^(1/3)
# cor.test(bigdiamonds$carat, bigdiamonds$pricelog)
# cor.test(bigdiamonds$xyz, bigdiamonds$pricelog)
# silimar as the diamonds dataset: xyz is another way of accessing the size of a diamond, gather than using carat

# dim(bigdiamonds)

### 3. Carat, xyz, Cert, Table, Depth and Price Value

# head(sort(table(bigdiamonds$price), decreasing = T), 10)

# head(sort(table(bigdiamonds$carat), decreasing = T), 10)

# head(sort(table(bigdiamonds$xyz), decreasing = T), 10)

# unique(bigdiamonds$cert)
# 9 levels of cert
# table(bigdiamonds$cert)
# most of them cert==GIA

# range(bigdiamonds$table)
# width of top of diamond relative to widest point
# range(bigdiamonds$depth)
# depth: total depth percentage = z / mean(x, y) = 2 * z / (x + y)

ggplot(aes(x= price), data= bigdiamonds)+geom_histogram(bins=20)+scale_x_log10()
ggplot(aes(x= price), data= bigdiamonds)+geom_histogram(bins=50)+scale_x_log10()
ggplot(aes(x= price), data= bigdiamonds) + geom_histogram(bins=100, fill='Blue') + 
  scale_x_log10() + ggtitle('Price Histogram (price in log10 scale)') + 
  theme_minimal()
ggsave('PriceHist.png')
# complicated distribution diagram
# this is common with price-related data: poor and rich, groups with different budget range

# ggplot(aes(x= carat, y= price, color=clarity), data= bigdiamonds) + geom_point(alpha=0.05)+scale_y_log10()+ggtitle('Diamonds Carat Vs Clarity Vs Price over 590,000 Samples')

# ggsave('CaratClarityPrice.png', width= 8, height= 6)
# CaratClarityPrice Plot

ggplot(aes(x= xyz, y= price), data= bigdiamonds) + geom_point(alpha=0.05) + 
  scale_y_log10()

system.time(ggplot(aes(x= xyz, y= price), data= bigdiamonds)+geom_point()+scale_y_log10())

# takes a long time for ploting due to such big datasets
# overplotting
# solution: sample 10000 from the original bigdiamonds dataset to do some quick analysis


### 4. Building the linear model with a smaller subset

set.seed(5000)

bigdia_samp <- bigdiamonds[sample(1:length(bigdiamonds$price), 10000), ]

# sample 10,000 diamonds from the data set
# ggpairs(bigdia_samp)
# ggsave('ggparis_Bigdia.png', width= 12, height= 12)

ggplot(aes(x= carat, y= price), data= bigdia_samp)+geom_point()+scale_y_log10()

ggplot(aes(x= xyz, y= price), data= bigdia_samp)+geom_point()+scale_y_log10()

ggplot(aes(x=table), data=bigdia_samp)+geom_histogram(binwidth=1)+xlim(c(50,70))

ggplot(aes(x=depth), data=bigdia_samp)+geom_histogram(binwidth=1)+ xlim(c(50,70))

ggplot(aes(x=xyz), data=bigdia_samp)+geom_histogram(binwidth=0.4)

ggplot(aes(x=carat, y=price), data=bigdia_samp) + scale_x_continuous(lim=c(0.2,quantile(bigdia_samp$carat,0.99)))+ geom_point(alpha=0.1) + scale_y_log10(lim=c(500,quantile(bigdia_samp$price,0.99)))+ ggtitle('Carat Vs Price')
# not linear and we do see darker vertical line on the graph e.g. 1.0, 2.0 ect

ggplot(aes(x=xyz, y=price), data=bigdia_samp) + scale_x_continuous(lim=c(3,quantile(bigdia_samp$xyz,0.99)))+ geom_point(alpha=0.2) + scale_y_log10(lim=c(200,quantile(bigdia_samp$price,0.99)))+ ggtitle('xyz^(1/3) (size) Vs Price')

# ggsave('xyzVsPrice.png', width=8, height=6)
# linear
# we saw similar vertical line as before

### 5. Three factor variables: clarity, color and cut

p1<-ggplot(aes(x=xyz, y=price, color=clarity), data = bigdia_samp) + 
  scale_x_continuous(lim=c(3,quantile(bigdia_samp$xyz,0.99))) + 
  geom_point() + scale_y_log10(lim=c(200,quantile(bigdia_samp$price,0.99))) + 
  ggtitle('xyz(size factor)+Clarity Vs Price') + 
  scale_color_brewer(palette = "Greens", type = 'div',  
                     guide = guide_legend(reverse = T, title = 'clarity'))

# ggsave('xyzClarityVsPrice.png', width=8, height=6)
# clarity: a measurement of how clear the diamond is (I1 (worst), SI1, SI2, VS1, VS2, VVS1, VVS2, IF (best))
# at the same size(xyz) factor, better clarity have higher price

p2<-ggplot(aes(x=xyz, y=price, color=color), data = bigdia_samp) + 
  scale_x_continuous(lim=c(3,quantile(bigdia_samp$xyz,0.99)))+ 
  geom_point() + scale_y_log10(lim=c(200,quantile(bigdia_samp$price,0.99)))+ 
  ggtitle('xyz(size factor)+Color Vs Price') + 
  scale_color_brewer(palette = "Blues", type = 'div', 
                     guide = guide_legend(reverse = T, title = 'color'))

# ggsave('xyzColorVsPrice.png', width=8, height=6)
ColorClarityPrice<-grid.arrange(p1, p2, ncol=2)
ggsave('ColorClarityPrice.png', ColorClarityPrice, width = 18, height = 8)

# color: diamond colour, from J (worst) to D (best)
# at the same size(xyz) factor, better color have higher price

ggplot(aes(x=xyz, y=price, color=cut), data = bigdia_samp) + 
  scale_x_continuous(lim=c(3,quantile(bigdia_samp$xyz,0.99))) + 
  geom_point(alpha=0.2) + 
  scale_y_log10(lim=c(200,quantile(bigdia_samp$price,0.99))) + 
  ggtitle('XYZ+Cut Vs Price') + scale_color_brewer(palette = "Set1", type = 'div', 
                                                   guide = guide_legend(reverse = T, title = 'cut'))
# attempted several methods to draw this graph, but do not see a clear trend

table(bigdia_samp$cut)
# only three levels: Good (10 %), V. Good (30 %) and Ideal (60 %)


### 6. Building a linear model with the bigdia_samp

fit1 <- lm(log(price) ~ xyz, data = bigdia_samp)
fit2 <- update(fit1, ~ . + color)
fit3 <- update(fit2, ~ . + clarity)
fit4 <- update(fit3, ~ . + carat)
fit5 <- update(fit4, ~ . + cert)
mtable(fit1, fit2, fit3, fit4, fit5)


### Building a linear model with the bigdiamonds dataset
bigfit1 <- lm(log(price) ~ xyz, data = bigdiamonds)
bigfit2 <- update(fit1, ~ . + color)
bigfit3 <- update(fit2, ~ . + clarity)
bigfit4 <- update(fit3, ~ . + carat)
bigfit5 <- update(fit4, ~ . + cert)
mtable(bigfit1, bigfit2, bigfit3, bigfit4, bigfit5)
