# Diamond Price Prediction

(Please wait a few seconds for figures to show up)
Using two datasets, one from the ggplot2 package(diamonds) 2008 (diamondsc.info), one from diamondsc.info (bigdiamonds) to explore variables which determine diamond price

# General Background/Research Purpose

Besides carat weight, there are other factors/variances that determine the final price of a diamond. Studies show that most of Americans spend one to three months salary on an engagement ring. Getting a diamond for wedding is a big cost for new couples. We want to look into two diamond datasets and explore what factors plays an important role in price and what factors are not so important.

![ggparis_Bigdia](doc/ggparis_Bigdia.png?raw=true "ggparis_Bigdia")

Fig.1 

We built linear model for price prediction with these two data sets. In both dataset, the R-squred reached 1.

# Brief Background Information about the datasets

Two data sets: one is one is from the ggplot2 package(diamonds), one is from diamondsc.info (bigdiamonds) to explore variables which determine the price of a diamond

The first dataset, diamonds, coming with the ggplot2 package, contains over 50,000 rows and XX columns. 
The second dataset, bigdiamonds dataset with almost 600,000 rows of data (10 times bigger than the previous diamonds dataset). It is slightly different structured from the diamonds dataset we just talked about above.
Goal: build price prediction model for both datasets

![FloorMapandMac](doc/CalibPointandMac.png?raw=true "FloorMapandMac")

Fig. 2 Floor map with calibration points (red point, 166 points in total, spaced 1 meter apart in the hallways of one floor) and mac position (black point, 6 routers in total).

# Data Analysis Method
Through taking some samples out from 50,000 rows, we found out that carat, x, y, z place an important role in determining the final price of a diamond. 
I have two RMD files in this repository. The one named "XXXX" is the one with all my comments and graphs. The one named "XXX" is a 'cleaned' version of the previous one. It only has all the required lines to run the final position prediction estimation, without any comments or graphs.

In '', I divided this study into 12 parts/sections. Part 1 and 2 focused on data cleaning and formating. We started with playing with the offline dataset and formated it from txt into a clean and organized dataframe. From part 3 to part 8, we looked at different variables, orientation, mac address, X and Y position, distance to mac and their effect towards signal strength.

![SignalStrengthvsDist](doc/SignalStrengthvsDist.png?raw=true "SignalStrengthvsDist")

Fig. 3 Signal strength plotted against distance to mac. Signal strength decreases as the distance to mac increase

Part 9 to part 10, we moved on to the online dataset (test dataset). We modified it into a dataframe format similar as offline dataframe. Online dataset contains information measured at 60 radom locations. Our goal was to built a prediction model using the signal strength in the offline dataset to predict corresponding X and Y position in the online dataset. 

In part 11, through k-Nearest-Neighbour method, we built prediction model based on offline dataset and tested the model with the online dataset. We calculated the error in this model and further explored the number of nearby calibration points and the number of nearby angles we need to include in the training model in order to minimize our estimation error.

![NeighbourPrediction](doc/NeighbourPrediction.png?raw=true "NeighbourPrediction")

Fig. 4 Error against the number of nearby calibration points used in the training model.

![AnglePrediction](doc/AnglePrediction.png?raw=true "AnglePrediction")

Fig. 5 Error against the number of nearby angles used in the training model.

In part 12, we visualized final result by plotting the prediction X and Y location against actual X and Y location in the online dataset via ggplot2. This result is shown below in Fig. 6

![FloorMapPredictedActualLocs](doc/FloorMapPredictedActualLocs.png?raw=true "FloorMapPredictedActualLocs")

Fig. 6 Floor map with actual position (solid black), estimated position (solid red) and calibration points (hollow grey circle)

# Conclusions

In this study, we formatted offline and online dataset into clean, manageable dataframes. We looked at different variables which affect signal strength and plotted these findings via ggplot2. Using k-Nearest-Neighbour method, we built prediction model based on offline and tested the model with the online. We found out we can minimize calculation error by employ 5 nearest calibration points and 3 angles into the training model.
In this study, 

# References

This is part of a in-course project (Data Analysis with R) on Udacity: https://classroom.udacity.com/courses/ud651
The code for scrape bigdiamond can be downloaded from: https://github.com/SolomonMg/diamonds-data
