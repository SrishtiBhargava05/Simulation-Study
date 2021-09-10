Gender Bias in University Admissions
================
Srishti Bhargava
11/21/2018

“I confirm that the following report and associated code is my own work,
except where clearly indicated.”

## Abstract

This report aims to answer the following question on the basis of the
admissions data from the package Data Science Labs (A. Irizarry, 2018)
in R-Studio (Allaire, 2011).

• On average is the ratio of males who applied and were admitted more
than the number of females?

The admissions dataset was used to simulate new datasets with similar
properties to answer the question. Then, statistical tests were used to
compare the averages. The result from these was compared for different
scenarios such as a difference in the number of samples. It was noted
that if the number of observations was less, then the tests failed to
detect differences regardless of their effect size. While a large number
of observations showed significant differences in the two ratios.

## Introduction

The data used was about “gender bias among graduate school admissions to
UC Berkeley” (A. Irizarry, 2018). Only two variables out of the four
given were used for the analysis. An extra variable ‘ratio’ was added
which converted the percentages into ratios. Upon exploring the selected
data, the Student’s two-sample t-test and the Mann-Whitney U Test was
chosen to answer the research question since we have to find a
difference in the average of two groups.

While the underlying problem is to answer the research question, the
report focuses on using simulations to test the validity of our answer
under different circumstances. For example, would our findings change if
we had more data

New datasets were formulated using the properties of the selected data
set. Each dataset was created to satisfy a certain scenario that is
described in the report. The chosen tests were then applied and the
result interpreted.

On average while calculating the size no difference was found on in the
performance of the two tests. Whereas, while calculating the power the
non-parametric was seen to perform slightly better on than the
parametric test.

## Method

The investigation began by plotting the data and statistically
summarizing the data to determine the tests to run on the data. The data
is close to normally distributed (Figure 1). The mean and standard
deviation of each gender is relatively similar to each other (Table 1).

A function was created to simulate data with similar properties to the
original dataset. This function used the normal distribution to generate
these numbers. It takes the mean, standard deviation and number of
samples of each gender or arbitrarily ‘Group’ to be simulated. The
output is a data of two columns with the observations of ratios or
‘Sample’ as one column and the group as the second column.

Then the simulated data is put in the simulation test function. This
function calculates the original results of the parametric and
non-parametric test and the power or size of the test. It takes in data
simulated from the simulation function, calculates the mean and standard
deviation of each group then uses the simulation function to create a
given number of new datasets with the properties of the originally
simulated dataset. It then runs the defined tests on each dataset and
stores the p-values from each test. It then calculates the number of
p-values that gave a significant result, that is the values that
rejected the null hypothesis. Then this number is divided by the total
number of times the test was conducted to calculate the power or size as
needed.

The reliability of t-test is ascertained as the data was generated
keeping the assumptions in mind. Normality was certain as we simulated
data from normal distributions. The observations are independent from
each other since they were arbitrarily generated and the variance in the
two means meet the thumb rule of the smaller not being more than two
times the bigger and because they are visibly equal to each other.(Table
1)

This is done for different scenarios which are explained in the section
below.

<img src="README_files/figure-gfm/Explore-1.png" style="display: block; margin: auto;" />
<table>
<caption>
Table 1: Summary Table for Admission rates
</caption>
<thead>
<tr>
<th style="text-align:center;">
Gender
</th>
<th style="text-align:center;">
Mean
</th>
<th style="text-align:center;">
Standard Deviation
</th>
<th style="text-align:center;">
Number of Samples
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
men
</td>
<td style="text-align:center;">
0.38167
</td>
<td style="text-align:center;">
0.21683
</td>
<td style="text-align:center;">
6
</td>
</tr>
<tr>
<td style="text-align:center;">
women
</td>
<td style="text-align:center;">
0.41667
</td>
<td style="text-align:center;">
0.28062
</td>
<td style="text-align:center;">
6
</td>
</tr>
</tbody>
</table>

## Results

### Scenario One: Measurement error in the observations

A simulated data set was created from the original dataset by using the
mean and standard deviation of the original dataset and generating
admiited random numbers with the same properties using normal
distributions. It was found that one of the ratios belonging to the
group ‘Men’ was miscalculated (selected arbitrarily). When this error
was corrected, the true mean of the two groups was found to be the same.
Upon conducting a t-test on this data we found a p-value of 1 and thus
successfully failed to reject the null hypothesis that the mean of the
two groups is equal.

The non-parametric Mann Whitney U test was conducted on the simulated
data.The p-value &gt; 0.6, that again suggested that there is no actual
difference in the ratio of the men and women that applied and were
admitted.

Next, multiple data sets were generated with the same properties as our
simulated data to take out the probability of a committing a type 1
error. Since the means of the ratio of the simulated sample of the
generated data is the same, the size was calculated according to a
predefined significance level and the table (Table 2) below summarizes
our finding. No significant difference is observed in the performances
of the parametric and non-parametric test over the difference
significance levels. Since the size is close to the predefined alpha
level, we can conclude that there is a low probability of committing a
type 1 error when the significance level is at 5% and 10%.

In the table below alpha is the significance level.

<table>
<caption>
Table 2: Size for different significance levels
</caption>
<thead>
<tr>
<th style="text-align:center;">
Size - T-test
</th>
<th style="text-align:center;">
Size - Mann Whitney U
</th>
<th style="text-align:center;">
Alpha
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center;">
0.00200
</td>
<td style="text-align:center;">
0.00501
</td>
<td style="text-align:center;">
0.01
</td>
</tr>
<tr>
<td style="text-align:center;">
0.05105
</td>
<td style="text-align:center;">
0.04805
</td>
<td style="text-align:center;">
0.05
</td>
</tr>
<tr>
<td style="text-align:center;">
0.09710
</td>
<td style="text-align:center;">
0.10210
</td>
<td style="text-align:center;">
0.10
</td>
</tr>
</tbody>
</table>

### Scenario Two: Changing the effect size and the number of data points in the sample

To make the calculation of this scenario easier the mean and standard
deviation of the original data was rounded off to two decimal places.
Datasets in which the difference in means of the ratio of both genders
or the effect size was equal to that in the original data set (0.03
which is a 3-point difference in the given data) were generated. The
first dataset had a sample size equal to sample size of the original
data that is, it had 12 observations. Upon running a t-test on the
simulated data we got a high p-value (&gt;0.8) which resulted in us
accepting the null hypothesis and concluding there is no significant
difference between the means of the two groups. It is known that there
is a three-point difference in the means, thus a type 2 error was
committed. The power of this test was extremely low (&gt;0.03)
suggesting unreliable t-test conclusions. The same result followed for
the non-parametric test. There was no significant difference in the
power of the two tests for a small sample size.

The same was done for a sample size of 100 and 1000. For a sample size
of 100 the t-test showed no evidence against that suggests a difference
in the means of the ratio of the two genders. The Mann Whitney U also
failed to show a significant difference. Again, the power of this sample
size was low about 25% for each test. Finally, we simulated 1000
observations under the same conditions. Both, the parametric and the
non-parametric tests gave significant p-values and showed strong
evidence for a difference in the means of the two ratios. The power for
both these were as high as 90% for the parametric and 96% for the
non-parametric as summarized in the table below.

<table>
<caption>
Table 3: T-test: Power
</caption>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:center;">
12
</th>
<th style="text-align:center;">
100
</th>
<th style="text-align:center;">
1000
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
0.3
</td>
<td style="text-align:center;">
0.04505
</td>
<td style="text-align:center;">
0.24925
</td>
<td style="text-align:center;">
0.91091
</td>
</tr>
<tr>
<td style="text-align:left;">
0.5
</td>
<td style="text-align:center;">
0.04304
</td>
<td style="text-align:center;">
0.69670
</td>
<td style="text-align:center;">
0.95295
</td>
</tr>
<tr>
<td style="text-align:left;">
0.8
</td>
<td style="text-align:center;">
0.64665
</td>
<td style="text-align:center;">
0.04204
</td>
<td style="text-align:center;">
0.99900
</td>
</tr>
</tbody>
</table>
<table>
<caption>
Table 4: Mann Whitney U Test: Power
</caption>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:center;">
12
</th>
<th style="text-align:center;">
100
</th>
<th style="text-align:center;">
1000
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
0.3
</td>
<td style="text-align:center;">
0.04905
</td>
<td style="text-align:center;">
0.25626
</td>
<td style="text-align:center;">
0.97197
</td>
</tr>
<tr>
<td style="text-align:left;">
0.5
</td>
<td style="text-align:center;">
0.04705
</td>
<td style="text-align:center;">
0.72773
</td>
<td style="text-align:center;">
0.97397
</td>
</tr>
<tr>
<td style="text-align:left;">
0.8
</td>
<td style="text-align:center;">
0.69069
</td>
<td style="text-align:center;">
0.04505
</td>
<td style="text-align:center;">
0.99900
</td>
</tr>
</tbody>
</table>

Similar tests were conducted for different effect sizes(5 point
difference and 8 point difference). The results are summarised in the
tables below. Again, signifcant results from statstistical tests could
only be achieved with large number of sample sizes. As we increased the
effect size the power increased on an overall level regardless of the
sample size.

<img src="README_files/figure-gfm/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

## Conclusion

Depending on the scenarios and simulated data there were different
answers for the research question, for lower sample sizes there was no
significant difference in the means given constant standard deviation
while for higher sample sizes the same difference was significant. It
was demonstrated that the results of the statistical tests on large
sample sizes were more reliable than the ones on smaller sample sizes.  
A directly proportional relation relationship was observed between the
sample size and power. As sample size increases so does the power goes
up. As shown in the graphs above. On an average the same result held
true for effect size.

Finally, the non-parametric test had higher power in each simulation,
though the difference was not significant, it might suggest that a
non-parametric test gave more reliable results.

## References

• Rafael A. Irizarry (2018). dslabs: Data Science Labs. R package
version 0.5.1. <https://CRAN.R-project.org/package=dslabs>

• Allaire, J. (2009). R Studio. R Studio, Inc.

• Hadley Wickham (2017). R package version 1.2.1.
<https://CRAN.R-project.org/package=tidyverse>

• Black, K. (2015). 11. Calculating The Power Of A Test — R Tutorial.
\[online\] Cyclismo.org. Available at:
<https://www.cyclismo.org/tutorial/R/power.html>

• Alder, G. and Benson, D. (2014). Flowchart Maker & Online Diagram
Software. Draw.io. Available at: <https://www.draw.io/>

• Donavan, C. (2018). MT5763 Lectures.
