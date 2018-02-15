### Analysis of diamonds dataset from ggplot2 package and bigdiamonds dataset

Diamonds dataset coming with the ggplot2 package contains over 50,000 rows and XX columns. Through taking some samples out from 50,000 rows, we found out that carat, x, y, z place an important role in determining the final price of a diamond. 
![Heatmap1](Heatmap1.png?raw=true "FirstHeatmap")

Bigdiamonds dataset with almost 600,000 rows of data (10 times bigger than the previous diamonds dataset). It is slightly different structured from the diamonds dataset we just talked about above.

We built linear model for price prediction with these two data set. In both dataset, the R-squred reached 1.
