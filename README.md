# Diamond Price Prediction

(Please wait a few seconds for figures to show up)
Using two datasets, one from the ggplot2 package(diamonds, data collected from diamondsc.info in 2008), one from diamondsc.info (bigdiamonds) to explore variables which determine diamond price

# General Background/Research Purpose

Besides carat weight, there are other factors/variances that determine the final price of a diamond. Studies show that most of Americans spend one to three months salary on an engagement ring. Getting a diamond for wedding is a big cost for new couples. We want to look into two diamond datasets and explore what factors plays an important role in price and what factors are not so important.

![ggpairs_Bigdia](doc/ggparis_Bigdia.png?raw=true "ggparis_Bigdia")

Fig.1 Ggpairs with 10,000 rows from bigdiamonds dataset.

We built linear model for price prediction with these two data sets. In both dataset, the R-squred reached 1.

# Brief Background Information about the datasets

Two data sets: one is one is from the ggplot2 package(diamonds), one is from diamondsc.info (bigdiamonds) to explore variables which determine the price of a diamond.

The first dataset, diamonds, coming with the ggplot2 package, contains over 50,000 rows and 10 columns. 

The second dataset, bigdiamonds dataset with almost 600,000 rows of data (10 times bigger than the previous diamonds dataset). It is slightly different structured from the diamonds dataset we just talked about above.

Goal: build price prediction model for both datasets


# Data Analysis Method
I prepared two r files in this repository.

I started with looking into smaller diamonds data set, which comes with ggplot2 package. This is save in '', which has seven sections in total. In section 1, I started with loading required libraries and dataset. In section 2 and 3, I briefly explored the relationship between carat and price. I randomly selected 5000 rows from the dataset and adopt ggpairs to do quick analysis on the relationship between different variables in section 4 (ggpairs figure attached above, Fig. 1). I found out that carat, x, y, z shows strong correlation with price variable. In section 5 and 6, I further studied different factorial variablies (cut, color, clarity) effect towards price. After gathering all these information, in section 7, I successfully built a linear model with lm().

![PriceHist](doc/PriceHist.png?raw=true "PriceHist")

Fig. X Price histogram created with bigdiamonds dataset. It is not simple Gaussian distribution. And this is normal with some of the price related data. Since we are looking at poor, middle，and rich group. Different groups have different budget when purchasing diamonds.

Taking all the previous experience working with diamonds dataset, I went ahead and attempted to build a similar price prediction model with bigdiamonds dataset. This is save in 'bigdiamonds.r', which has 6 sections in total. Firstly, in section 1 and 2, I looked at strutucral difference between this and diamonds dataset and formatted this bigdiamonds to preferred dataframe. I quickly realized that since this dataset is too big, it is almost impossible to plot all the data in one plot and we will need to handle overplotting issue. In section 4, I randomly selected 10, 000 rows from the dataset, named it 'bigdia_samp' and adopt ggpairs to do quick analysis on the relationship between different variables. In section 5, I looked at three variablies (cut, color, clarity). In section 6, I built a linear model with lm() first with the small subset and then extended to bigdiamonds dataset.

![ColorClarityPrice](doc/ColorClarityPrice.png?raw=true "ColorClarityPrice")

Fig. X Size factor (xyz) vs price, with color and clarity factor added to the plot. 
Color: from D (best) to J (worst)
Clarity: IF (best), VVS2, VVS1, Vs2, VS1, SI2, SI1, I1 (worst)

# Conclusions

In this study, we looked at two dataset related to diamond price with different variables. We started with the smaller dataset, draw ggpairs plots, looked at interesting factors and trends which determine diamond price. We created a size factor (cube root of x*y*z) to present size factor. This more acurate represent the size of a diamond, compared with the carat variable in the dataframe. We built linear model which accurately predict diamond price. Later, we moved to a much larger dataset. We randomly made a smaller subset of this large dataset for less time consuming plotting. We used what we have found from the previous smaller diamonds dataframe and then built a similar price prediction model with this large dataset. In both cases, our R-squared reached 1.

# References

This is part of a in-course project (Data Analysis with R) on Udacity: https://classroom.udacity.com/courses/ud651

The code for scraping bigdiamond can be downloaded from: https://github.com/SolomonMg/diamonds-data
