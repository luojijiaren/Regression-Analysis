setwd('~/GitHub/Regression-Analysis')
data=read.table('CH06PR18.txt')
attach(data)
Y=V1
X0=rep(1,length(V1))
X1=V2
X2=V3
X3=V4
X4=V5
X=cbind(X0,X1,X2,X3,X4)
stem(X1)
stem(X2)
stem(X3)
stem(X4)

library(car)
spm(~Y+X1+X2+X3+X4,main='scatter plot matrix')

lm.fit=lm(Y~X1+X2+X3+X4)
summary(lm.fit)
res=resid(lm.fit)
boxplot(res)

par(mfrow=c(2,2))
plot(lm.fit)
yhat=predict(lm.fit)
plot(yhat,res)
par(mfrow=c(2,2))
plot(X1,res)
plot(X2,res)
plot(X3,res)
plot(X4,res)
plot(X1*X2,res)
plot(X2*X3,res)
plot(X3*X4,res)
plot(X4*X1,res)




y1=yhat[yhat<median(yhat)]
y2=yhat[yhat>=median(yhat)]
e1=res[which(yhat<median(yhat))]
e2=res[which(yhat>=median(yhat))]
e1m=median(e1)
e2m=median(e2)
d1=abs(e1-e1m)
d2=abs(e2-e2m)
d1m=mean(d1)
d2m=mean(d2)
s=(sum((d1-d1m)^2)+sum((d2-d2m)^2))/(81-2)
t=(d1m-d2m)/(sqrt(s)*sqrt(1/40+1/41))  
t
qt(0.975,79)

bk=b[2:5]
sk=sqrt(as.vector(diag(sb)))[2:5]
B=qt(1-0.05/8,76)
rbind(bk-B*sk,bk+B*sk)

anova(lm.fit)
SSE=98.231
SSR=14.819+72.802+8.381+42.325
SSTO=SSE+SSR
MSE=SSE/76
MSR=SSR/4
R^2=SSR/SSTO
F*=MSR/MSE
qf(0.95,4,76)

Xmul=solve(t(X)%*%X)
sb=MSE*Xmul
b=lm.fit$coefficient

data2=read.table('CH06PR20.txt')
x0=rep(1,length(data2$V2))
X_hat=as.matrix(cbind(x0,data2))
y_hat2=X_hat%*%b

syhatm=X_hat%*%sb%*%t(X_hat)
syhat=diag(syhatm)
s=sqrt(as.vector(syhat))
s
wsq=5*qf(0.95,5,76)
w=sqrt(wsq)
B2=qt(1-0.05/10,76)
cbind(y_hat2-B2*s,y_hat2+B2*s)



data3=read.table('CH06PR21.txt')
x0f=rep(1,length(data3$V1))
X_hat3=as.matrix(cbind(x0f,data3))
y_hat3=X_hat3%*%b
sypred=diag(X_hat3%*%sb%*%t(X_hat3))+MSE
s=sqrt(as.vector(sypred))
t3=qt(1-0.05/2,81-5)
cbind(y_hat3-t3*s,y_hat3+t3*s)










