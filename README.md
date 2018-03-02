# Diamond Price Prediction

Use linear regression method to predict diamond price, test with two datasets, one from the ggplot2 package(diamonds, data collected from diamondsc.info in 2008), one from diamondsc.info (bigdiamonds)
(Please wait a few seconds for figures to show up)

# General Background/Research Purpose

Studies show that most of the Americans spend one to three months salary on an engagement ring. Getting an engagement ring for wedding is a big cost for new couples. I want to look into two diamond datasets and explore what factors play determinate role in pricing and what factors are not so crucial.

![ggpairs_Bigdia](doc/ggparis_Bigdia.png?raw=true "ggparis_Bigdia")

Fig.1 Pairs plots which were generalized via ggpairs with 10,000 rows from bigdiamonds dataset.

# Brief Background Information about the datasets

The first dataset, diamonds, coming with the ggplot2 package, contains over 50,000 rows and 10 columns. 

The second dataset, bigdiamonds dataset with almost 600,000 rows (10 times bigger than the previous diamonds dataset). It is slightly different structured from the diamonds dataset.

Goal: build price prediction model for both datasets

# Data Analysis Method

I prepared two r files in this repository, 'diamonds.R' and 'bigdiamonds.R'.

I started with the smaller diamonds data set, which comes with ggplot2 package. This is save in 'diamonds.R', which has seven sections in total. In section 1, I started with loading required libraries and dataset. In section 2 and 3, I briefly explored the relationship between carat and price. I randomly selected 5,000 rows from this dataset and adopt ggpairs to do quick visual analysis on the relationship between different variables in section 4 . I found out that carat, x, y, z shows strong correlation with the price variable. In section 5 and 6, I further studied different factorial variablies (cut, color, clarity) and their impact towards pricing. Under similar conditions, better clarity and color always tempt to go higher in price. After gathering all these information, in section 7, I successfully built a linear model with lm().

![ColorClarityCutPrice](doc/ColorClarityCutPrice.png?raw=true "ColorClarityCutPrice")

Fig. 2 Size factor (xyz) against price with cut, clarity, color factors added into the plot. It is really hard to see if better cut cause higher price. From the graph, it is clear that better clarity and color do cause higher in price.
Cut: quality of the cut (Fair, Good, Very Good, Premium, Ideal)
Color: from D (best) to J (worst)
Clarity: IF (best), VVS2, VVS1, Vs2, VS1, SI2, SI1, I1 (worst)

![PriceHist](doc/PriceHist.png?raw=true "PriceHist")

Fig. 3 Price histogram created with bigdiamonds dataset. It is not simple Gaussian distribution. And this is normal with some of the price related data. Since we are looking at poor, middle，and rich group. Different groups have different budget when purchasing diamonds.

Taking all the previous experience working with the diamonds dataset, I went ahead and attempted to build a similar price prediction model with the bigdiamonds dataset. This is save in 'bigdiamonds.R', which has 6 sections in total. Firstly, in section 1 and 2, I looked at strutucral difference between this and diamonds dataset and formatted this bigdiamonds to preferred dataframe. I quickly realized that since this dataset is too big, it is almost impossible to plot all the data in one plot and we will need to handle overplotting issue. In section 4, I randomly selected 10, 000 rows from the dataset, named it 'bigdia_samp' and adopt ggpairs to do quick analysis on the relationship between different variables (ggpairs figure attached above, Fig. 1). In section 5, I looked at three variablies (cut, color, clarity) in details. In section 6, I built a linear model with lm() first with the small subset and then extended to bigdiamonds dataset.

![ColorClarityPrice](doc/ColorClarityPrice.png?raw=true "ColorClarityPrice")

Fig. 4 Size factor (xyz) against price with cut, clarity, color factors added into the plot.

# Conclusions

In this study, we looked at two datasets related to diamond price with different variables. We started with the smaller dataset, draw ggpairs plots, looked at interesting factors and trends which determine diamond price. We created a size factor (cube root of x*y*z) to present size factor. This more accurate represent the size of a diamond, compared with the carat variable in the dataframe. Via linear regression, we built model which accurately predict diamond price. Later, we moved to a much larger dataset. We made a smaller subset of this large dataset for less time-consuming plotting and modeling. We used what we have found from the previous smaller diamonds dataframe and then built a similar price prediction model with this large dataset. In both cases, our R-squared reached 1.

# References

This is part of a in-course project (Data Analysis with R) on Udacity: https://classroom.udacity.com/courses/ud651
The code for scraping bigdiamond can be downloaded from: https://github.com/SolomonMg/diamonds-data
