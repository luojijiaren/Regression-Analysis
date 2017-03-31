setwd('~/GitHub/Regression-Analysis')
data=read.table('CH06PR18.txt')
attach(data)
Y=V1
X1=V2
X2=V3
X3=V4
X4=V5
anova(lm(Y~X4))
anova(lm(Y~X1+X4))
anova(lm(Y~X1+X2+X4))
anova(lm(Y~X1+X2+X3+X4))

Y1=Y+0.1*X1-0.4*X2
anova(lm(Y1~X3+X4))

anova(lm(Y~X1))
data_scale1=scale(data,center=T,scale=T)
data_scale=data_scale1/sqrt(81-1)

Y_st=data_scale[1:81,1]
X1_st=data_scale[1:81,2]
X2_st=data_scale[1:81,3]
X3_st=data_scale[1:81,4]
X4_st=data_scale[1:81,5]
cof_st=lm(Y_st~X1_st+X2_st+X3_st+X4_st)$coefficient


