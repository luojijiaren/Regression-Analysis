read.table('CH01PR22.txt')
data=read.table('CH01PR22.txt')
attach(data)
lm.fit=lm(V1~V2)
summary(lm.fit)
res=resid(lm.fit)
boxplot(res)

yhat=predict(lm.fit)
plot(yhat,res)
plot(lm.fit)

model1=loess(V1~V2,span=0.4)
plot(V2,V1)
lines(V2,V1,col='red')

plot(res)
abres=abs(res)
plot(V2,abres)
library(HH)
hovBF(V1~V2)

d1=V2[V2<=24]
d2=V2[V2>24]
d1m=mean(d1)
d2m=mean(d2)
s=(sum((d1-d1m)^2)+sum((d2-d2m)^2))/14
t=(d1m-d2m)/(sqrt(s)*1/2)

