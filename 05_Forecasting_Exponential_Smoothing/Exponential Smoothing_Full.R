                                                      #Time series Analysis



# Forcast is a statistical method to predict an attribute using historical patterns in the data. 
#What has happed in the past can only be refected in the enar future. What has not 
#happend cannot be forcasted. And if I kanw what has happed in the past, then I know what 
#will be in the present. If I know what is there in the prent, then I will be able to forcast future. All business rely on
#forcast and reap major benefits from accurate forcasted values. Forcasts can be made for several years in advance
#(eg. capital investment, starategic planning) or for the next few minutes (for telecommunication routing). Every 
#business and organization applies different methods of forcasting in different situations. Therefore it is 
#imparative to identify what to forcast and which method of forcasting should be utilized in different scenarios 
#so that the risk of forcasating is minimized.
#
#                                                      ####DATA TYPE####
#CROSS SECTIONAL DATA: data is collected at single point of time on one or more variables. here data is not sequencial
#and usually data points are independent of one another. Regression, Random Forest, Neural Network method have been 
#applied widely on these data
#
#TIME SERIES DATA: Univariate or multivariate data is observed across time ina sequencial manner at pre-determined
#and equally spaced time intervals(yeraly, monthly, quaterly,daily etc).Oredring among data points is important
#and cannot be destroyed
#
#COMBINATION OF THESE: This is a complex study design where information on same variables are collected over various
#points of time. many survey sampling make use of panel data.
#
#
#                                               ######DEFINITION OF TIME SERIES######
#A collection of observations that has been observed at regular time intervals for a certain variable over a given
#duration is called time series
#The regular time interval can be DAILY(stock price), WEEKLY(product manufactured),MONTHLY(un employmrent rate)
#QUARTERLY(slaes of product),ANNUAL (GDP), 5 YEARS, 10 YEARS etc.
#
#Time series can be applied in various field such as economic forcasting, sales forcasting, budgetary analysis
#stock market analysis, yield projection, inventory studies, work load projections, utility studies, process and
#quality control and many more
#
#                                           #########CHARACTERISTICS OF TIME SERIS DATA#######
#ALL OBSERVATIONS ARE DEPENDENT: each observation is expected to depend on the past observations
#
#MISSING DATA MUST BE IMPUTED: Because all data pointa are sequencial in time series, if any data point is missing
#it must be imputed before the actual analysis process commences;otherwise proper ordering is not preserved.
#
#TWO DIFFERENT TYPE OF INTERVALS CANANOT BE MIXED: Time seris dta is observed on the same variable over the given 
#period of time with fixed anad regualr time intervals. though data can be collected at various intervals, the 
#interval must remain the same throghout the entire range. yearly cannot be combined with monthly
#
#OBJECTIVE: Time series forcasting is applied to extract information from historical series and used to predict 
#future behaviour of the same series based on past pattern.
#
#APPROACHES USED FOR TIME SERIES FORCASTING:
#
# 1. DECOMPOSITION: The method is based on extraction of individual components of time series
# 2. REGRESSION: The method is based on regression on past observations.
#These two approaches are completely different.
#Start with Decomposition: If your goal is to understand the underlying patterns of a time series, begin with decomposition.
#Move to Regression: If you have additional explanatory variables or want to model complex interactions, transition to regression.
#
#.......................................DECOMPOSITION METHOD.........................................
#
#There are various forces that may affect the observations in a time series. The components are:
#
#I. TREND: When a series increases/ decreases or remain neutral over the entire length of time is call the trend 
#of the series. For example, sales of a product for last 5 years.
#II. SEASONAL COMPONENT: Intra unit duration stable fluctuations repeatable over the emtire time series.
#For example, Sales of AC increses in summers.
#III. IRREGULAR COMPONENT: Random/ unforeseen/ unpredictable fluctiation/ movement. For example, Sales of musk during
#pandamic, Sales of Air tickets during pandamic.
# TREND and SEASONALITY are part of syatematic components of time series
#..........................................TWO TYPES OF MODELS...................................................
#
#ADDITIVE MODEL: Y_t =T_t +S_t +I_t , when the resultant series is a sum of the components. Historical daily temparature.
# MULTIPLICATIVE MODEL: Y_t =T_t * S_t * I_t , when the resultant series is the product of the components.
#Daily electricity consuption
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#

#require packages:

install.packages("fpp2")
install.packages("forecast")
install.packages("tseries")
install.packages("data.table")
install.packages("hydroGOF")


#install.packages("ggplot2")

#Definition of Time series
attach(Tractor_Sales)
t=as.data.frame(Tractor_Sales)
t
plot(t[,2])
plot(t[,2],type = "l")

#time series plot
ts=ts(t[,2],frequency = 12,start =c(2003,1))
ts
plot(ts,xlab="year",ylab="sales",main="tractor sales")

# Observations
#1. there appears to be a trend. over the years on average it is going up. trend component exist
#2. there appears to be an seasonality
#3. data value are stored in correct order and no data is missing
#4. inra year stable fluctuations are indicative of seasonal component.as treand increases,
#   fluctuations are also increasing. this is indicative of multiplicative seasonality 


#seasonal plot
library(fpp2)
ggseasonplot(ts,year.labels = T,year.labels.left = T, ylab="sales")
#observations
#1. as the years go by sales increases
#2. there is a common similar seasonality pattern go from left to right, but is not identical
#   which means there is a treand, there is a seasonality, but also something else that is 
#peculiar to a given year and a given season. the bump is more pronounced as year go by as the error
# is multiplicative. as sales increas bump increases.

#polar representation
ggseasonplot(ts,polar=T)
# if it is circular it indicating no seasonality. the centre is not in the middle.
#circles shifted in the same way, the seasonality pattern is same accross the year

ts
monthplot(ts, ylab="sales", xlab="months")
monthplot(ts[1:24],ylab="sales", xlab="months")

#observation
#vertical lines represents monthly sales and horizontal lines represents average sales
#of the given month. average sales are higher in july august. icresing lines that
#represents sales have seasonal fluctuations along with a treand. thus we can confirm
# also somthing wrong happend in the year of 2008.

# trend is trying to find effect accross the row, and seasonality accross the column. 
# and the stuff which is not expalied by the row and column, that will be the part which is 
#unpredictable, an irregualr stuff, like 2008.

#IDENTIFICATION OF COMPONENTS (trend , seasonality, irregular)

td=decompose(ts,type = "multiplicative")
td
#observation
#1. all jan the seasonal compnent is same through out all the year. it means in Jan you are
#going to sell 18% ;ess of your annual trend, in july 23% more. as seasonality is fixed for
#all the year, july highest, Nov lowest. it indicating seasonality is independent of trend. and the random part is
#the remaining part after extracting trend and seasonality. in 2004 jan sales is 4 % less than that it
#should have be, that is what our trend and seasonality forcasted , in 2005 jan 1% higher than what 
#my trend and sesonality forcasted. this component is not related to year or month. this is unpredictable.
#it is a pecularity of that month and that year

plot(td)
#observation
#1. original series, unit 200 to 600
#2. trend after removing the seasonality. it is incresing,  unit 200 to 600, it is linear
#3. seasonality, unit 0.8 to 1.25.it isa dimensionless quantity, just multiplies. shape identical year to yes
#4. unpredictable unsytematic error, irregular component, maximum 10 % profit for good year and 10% loss for bad
#   so if the forecast suggests 500, it may be maximum 500 otr minimum 450. 
#   overproducing and undrprocuting depends on financial and other diffrent factors.
#   it is random.it should not have any trend and sesonality. this part tells you whether the trend and seasonality
#are significant or not. this part should be effectively zero.
tdd=decompose(td$random)
plot(tdd)
#additive decomposition
tsl=stl((ts),s.window = "p")
plot(tsl)#observation
#observation:
#this particular function allows only additive models. there is no multiplicative option for this.becaise 
#there is no multiplicative option, we use logaritmic scaling. this is logarithm of slaes.

#multiplicative decomposition
tsl=stl(log10(ts),s.window = "p")
plot(tsl)

#observation:
# since this particular function allows only additive models. there is no multiplicative option for this.because 
#there is no multiplicative option, we use logaritmic scaling. this is logarithm of slaes.
#The error bar is associated with the number. anything between the error bar is indistinguishable. if something
# beyond this error bar implies that this component is statistically significant. Here trend and seasonality
#statistically significant. where as all error are within the error. so error becomes insignificant.
#which idicate we can ignore the error part here. smaller the greater the significance.



#Data Split

#Before a forcast method is proposed, the method need to validate. for this purpose data need to split into
#two sets. ie. training and testing. Traing data helps in identifying and fitting right models and test 
# data used to validate it. in case of time series data, the test data is the most recent past of the series
#so that the odering in the data preserved. forcasting is a continuous process which can manages to pick up
#trends. Here we are not assuming that the is no change in the process, we are assuming something remain constant.
# and the constant could be anything, for eample, rate of change. our target is not make constant everything, 
#our hunt is for something which is constant. So what is the same is the key question. for example, salary
#is not same, but yearly increment is same. so change in salary is the same, that can be used again ang again.
# that we are trying to find a change that will happen again.

# For tractor sales series, the first 10 yearas of data is used for the training purpose and last two years for test

#spilting the data
t1=window(ts, start=c(2003,1), end=c(2012,12), freq=12)
t2=window(ts, start=c(2013,1), end=c(2014,12), freq=12)
t1
t2
#Now we will work with t1 and then use that to forecast two years ahed. After that we will compare the forcast
#with the actual number of 2013 and 2014. We comapare either mean absolute parcentage error or root mean square.
#which will tell you how far you are from your actuals.

#ploting the data
library(forecast)
autoplot(t1, col=4, ylab = "Sales", main = "Blue: Train data set (t1)  AND Red:Test data set (t2)")+autolayer(t2)
# Now the question is can the blue predict the red. black is not constant, it is changing it is growing
#there is nothing that the future is like the past, here trend, seasonality all exist. certainly what happed 
#in 2008 is going to happen in 2010. But we are saved by the fact that whatever happed in the last two years
#is also diffrent what happed before.In other words, it is changing , but it is changing in the way that 
#changed before. It is not changing in a new way. If the july adjustment is same as previous july in the 
#percentage lift, then it is ok, raw sales data can not be same. only the percentage lift over the year
#for the month of july is same.This is the most important assumptions in time series.

#Forecast

#Method1

#RANDOM WALK WITH DRIFT (soomething is moving randomly and inside it there is a trend and sesonality)
#This method forcats next period value as per the amount of change over time (call the drift) is evaluated
#average change seen in the past data. this method can applied along with the decomposition. Here we are going
#to predict not sales but the LOG sales.

f1log=stl(log10(t1),s.window = "p") # for stl function we need to run on log scale, it includes the seasonality
f1log
f1=forecast(f1log, method="rwdrift",h=24) # forcast act on decomosed parts not on time series
f1
f1=data.frame(f1)
f1[,1]
plot(f1)

# observations
#1. forcast is not not constant it picked up trend and seasonality. it extrapolated the trend and 
#  multiply seasonality and ignore the random part. forcast also calculated the standard error 
#   which is the grey part.dark grey 95% and light grey 99%, that we do not know what will be exact forevast
#  but we are 95% confident that it will be in the dark grey zone. actual line we dont know.
#The trend is incresing faster than historically ie.  little more than the historical trend suggents 

#Accuracy measurement by Root mean sum of error (RMSE) and mean absolute percentage error(MAPE)
actual=10^(cbind(log10(t2)))
predicted=10^(f1[,1])
actual
predicted
ac=cbind(actual, predicted)
ts.plot(ac, col=c("blue","red")) # blue is actual test data, red is forcast

# observations
#we pick up the pattern with slight  systematic under prediction. which means at acuality there is something
#which lifting my sales a little bit above the historical trend, something that not expalined by the trend
#of the past.
accuracy(actual, predicted) 
#observation
#MAPE: 7.4 :  we are 7.4 % away from the truth, 7.4% under predicted.
#RMSE(S.E.): 53.56: If we want to be 68% confident we should consider the number aof 
# tractor sales (+-) 53 number odf tractor from the predicted value. for 95% (+-) 2 x 53.
#practal decision depends on different things, more bigger and better interval is more and more lees useful.
#our decision depends on how optimestic or how pessimistic we are. deffrent people do diffrent things.
#do we wat to be corrected and useless or do you want to be incorrect and usefull? It like the incorrect
# prediction with lower number of independent variables or correct prediction with higher number od independent
#variables in rhe regression. like adjusted R-square: it adjust too many parameters extra parameters giving 
# us more fitted values but not enough one more parameter should do. in other words it is adding more
# variance but not reducing bias enough.higher number of variables increses the variance. adjusted R-square
#is a bias variace trade off type of compromise.

...............................................................................................................

#WE TOOK THE DATA, CONVERTED INTO A TIME SERIES, WE DECOMPOSE THE TIME SERIES, USING THE DECOMPOSITION
#WE FORCAST IT, THAT FORCASE WILL BE COMPARED WITH ACTUALS IN A TEST TRAINING WAY AND CHECKING THE GOODNESS OF IT
................................................................................................................




#OTHER TECHNIQUE
t1
t2

                                        #Exponentional Smoothing Methods#
#This is an extension moving(rolling) average method where more recent observations get Higher weight


#Simple Soothing Method

#One parameter exponential is applicable to time series which do not contain trend and sesonality.
#Yp{t+1}= a * y{t} +(1-a)yp{t}  0<a<1 a smmothing parameter. in reality such series is hard to find.
# this is a one step ahed forcast where all the forcast values are identical
# Forcast of tomorrow will be a combination of what is today and forcast of today 
# OR Yp{t+1}= yp{t} +a(y{t}-yp{t})
# Forcast tomorrow is forcast today modified by how wrong I was today. i.e. today's forcast and a correction
# a=1 implies tomorrw's forcast is today's value; a=0, implies tomorrw's forcast is today's forcast
# If we extend it then [a * y{t} +(1-a)yp{t}= a * y{t} +(1-a)(a * y{t-1} +(1-a)yp{t-1}] and so on. 
# Any data comes out with certain amount of noice, the noice has be either eliminated or reduced.
#here a is helping us to reduce the noice. Like use of headphones during youtube study.
#puting a=1/2 we can see the exponential nature. ie. exponential weighted moving average or exponential smoothing.
# but the problem is over long period of time it does not consider the seasonality. So pleople make modifications
# such as as double exponential and triple exponential soothing.


#Prediction by Simple exponential smoothing
t1s=ses(t1, h=24)
summary(t1s)
plot(t1s)
# observations
#Forcast are same. no trend no seasonality. flat line. It does forcast but it forcast only one time point ahed only.
#but we are trying to forcast 24 time point ahed.therefore beyond one point this is not helpful

#Prediction by Double exponential smoothing
t1h=holt(t1, h=24)
summary(t1h)
plot(t1h)
# observations
#Forcast is icresing but incresing in a same amount every time. There is no sense of seasonality in this.
#This is better than the previous. If thing that there is not seasonality you can stopped here.

#Prediction by Tripple exponential smoothing
t1w=hw(t1, h=24, seasonal = "multiplicative") # or additive 
summary(t1w)
plot(t1w)


#observation
#1. forcast is not not constant it picked up trend and seasonality. it extrapolated the trend and 
#  multiply seasonality and ignore the random part. forcast also calculated the standard error 
#   which is the grey part.dark grey 80% and light grey 95%, that we do not know what will be exact forecast
#  but we are 80% confident that it will be in the dark grey zone. actual line we dont know. The trend is incresing
#faster than historically ie.  little more than the historical trend suggents 

# observations
# It is little bit complex it consider the seasonality. From here times seris analysis starts.
# **** beta close to zero mean it is close to the previous value that is my trend is not changing much.
# it means my seris is contantly incresing. if it is not my trend would changed every time. so
#here the the adjustment due the change int he level is very small that is very close to a straight line.
# so our slope is not changing so much. the angle of the line is remain almost same.
# if it is not a stright line model can adjust it and refit it.
#
#**** if a lpha is close to zero it indicates our lavel is not changing ie. close to parallel to x-axis.
#   but here our series is not flat. my series is incresing. so alpha is stay away from zero so that be able to 
#increse. but my trend does not need to increse so beta is close to zero so that the trend can remain the same.
#
#**** gamma is high means there is a seasonal fluctuations and it is trying to adopt the seasnal fluctuation 
#as it is going further. As the years go by it keeps adjusting the numbers. gamma close to zero then seasonality
#would not be adjusted, means very high fluction exist like Jan-March 2020 nifty 50.
#
#**** s stands for moth wise seasonality. Jan, Feb... It idicate model is going to apply 0.9493 % coorection
#on the trend component on Jan and so on. and if it is negative model will bring down the trend level.
#
#**** AIC is compariable to adjusted R-square. Lower value of AIC is good.


##Model Accuracy
t1w=data.frame(t1w)
acw=cbind(t2, t1w[,1])
ts.plot(acw, col=c("blue","red")) # blue is actual test data, red is forcast
accuracy(t2,t1w[,1]) 
#observation
#MAPE: 7.7 :  we are 7.7 % away from the truth, 7.7% under predicted. 
#RMSE(S.E.): 44.21: If we want to be 68% confident we should consider the number of 
# tractor sales (+-) 44 number of tractor from the predicted value. for 95% (+-) 2 x 44.
#practal decision depends on different things, more bigger and better interval is more and more lees useful.
#from analytical perpecdtive RMSE is variance and MAPE is biasness. complicated model contains
#low bias and high variance nad simple model just opposite. better forcast is uncertain forecast.
#RMSE and MAPE helps to compare between the models

#..............................................................................................................










