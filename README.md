# Diamond Price Prediction

Use linear regression method to predict diamond price, test with two datasets, one from the ggplot2 package(diamonds, data collected from diamondsc.info in 2008), one from diamondsc.info (bigdiamonds)
(Please wait a few seconds for figures to show up)

# General Background/Research Purpose

Studies show that most of the Americans spend one to three months salary on an engagement ring. Getting an engagement ring for wedding is a big cost for new couples. I want to look into two diamond datasets and explore what factors play determinate role in pricing and what factors are not so crucial.

![ggpairs_Bigdia](doc/ggparis_Bigdia.png?raw=true "ggparis_Bigdia")

Fig.1 Pairs plots which were generated via ggpairs with 10,000 rows from bigdiamonds dataset.

# Brief Background Information about the datasets

The first dataset, diamonds, coming with the ggplot2 package, contains over 50,000 rows and 10 columns. 

The second dataset, bigdiamonds dataset with almost 600,000 rows (10 times bigger than the previous dataset). It contains two new columns: cert and measurement, and is slightly different structured from the diamonds dataset.

Goal: build price prediction model for both datasets

# Data Analysis Method

I prepared two r files in this repository, one is 'diamonds.R', the other one is 'bigdiamonds.R'.

I started doing exploratory data analysis with the smaller diamonds data set, which comes with ggplot2 package. The result is save in 'diamonds.R', which has seven sections in total. In section 1, I started with loading required libraries and the diamonds dataset. In section 2 and 3, I briefly explored the relationship between carat and price. I randomly selected 5,000 rows from this dataset and adopt ggpairs to do quick visual analysis on the relationship between different variables in section 4. With pairs plots, I found out that carat, x, y, z shows strong correlation with the price variable. I created a new size factor (xyz=cube root of (x*y*z)) which better represent the size of a diamond than carat (weight of diamonds). In section 6, I further studied different factorial variablies (cut, color, clarity) and their impact towards pricing. Under similar conditions, better clarity and color tempts to go higher in price. After gathering all these information, in section 7, I successfully built a linear model with lm() via using only three variables from the dataset: xyz(size factor), color and clarity.

![ColorClarityCutPrice](doc/ColorClarityCutPrice.png?raw=true "ColorClarityCutPrice")

Fig. 2 Size factor (xyz) against price with cut, clarity, color factors added into the plot. It is really hard to see if better cut relates to higher price. However, it is clear that better clarity and color do cause higher in price.
Cut: quality of the cut (Fair, Good, Very Good, Premium, Ideal) Although there are five levels in cut, most of the diamonds are Ideal, Premium or Very Good
Color: from D (best) to J (worst)
Clarity: IF (best), VVS2, VVS1, Vs2, VS1, SI2, SI1, I1 (worst)

![PriceHist](doc/PriceHist.png?raw=true "PriceHist")

Fig. 3 Price histogram created with bigdiamonds dataset. It is not simple Gaussian distribution. And this is normal with some of the price related data. Since we are looking at poor, middle，and rich groups. Different groups have different budget when purchasing diamonds.

Taking all the previous experience working with the diamonds dataset, I went ahead and attempted to build a similar price prediction model with the bigdiamonds dataset. This is save in 'bigdiamonds.R', which has 6 sections in total. Firstly, in section 1 and 2, I looked at strutucral difference between this and diamonds dataset and formatted this bigdiamonds to preferred dataframe (price distribution histogram in Fig. 3). I quickly realized that since this dataset is too big, it is almost impossible to plot all the data in one plot and we will need to handle overplotting issue. In section 4, I randomly selected 10, 000 rows from the dataset, named it 'bigdia_samp' and adopt ggpairs to do quick analysis on the relationship between different variables (ggpairs figure attached above, Fig. 1). In section 5, I looked at three variablies (cut, color, clarity) in details (plots in Fig. 4). In section 6, I built a linear model with lm() first with the small subset and then extended to bigdiamonds dataset. I built price prediction model via using only four variables from the dataset: xyz(size factor), color, clarity and cert.

![ColorClarityPrice](doc/ColorClarityPrice.png?raw=true "ColorClarityPrice")

Fig. 4 Size factor (xyz) against price with clarity, color factors added into the plot. Silimar as before, we cannot directly tell if better cut will bring up diamond price. While under similar conditions, better color and clarity do result higher price.

# Conclusions

In this study, we looked at two datasets related to diamond price with different variables. We started with the smaller dataset, draw ggpairs plots, looked at interesting factors and trends which determine diamond price. We created a size factor (cube root of x*y*z) to present size factor. This newly created size factor more accurate represent the size of a diamond, compared with the carat variable in the original dataset. Via linear regression, we built model which accurately predict diamond price via only three variables: size factor, color and clarity. Later, we moved to a much larger dataset. We made a smaller subset of this large dataset for less time-consuming plotting and modeling. We used what we have found from the previous smaller diamonds dataset and then built a similar price prediction model with this large dataset via size factor, color, clarity and cert. In both cases, our R-squared reached 1.

# References

This is part of an in-course project (Udacity-Data Analysis with R): https://classroom.udacity.com/courses/ud651
The code for scraping bigdiamond can be downloaded from: https://github.com/SolomonMg/diamonds-data
