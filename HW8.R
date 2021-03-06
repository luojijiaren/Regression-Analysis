setwd('~/GitHub/Regression-Analysis')
data=read.table('CH06PR18.txt')
attach(data)
Y=V1
X1=V2
X2=V3
X3=V4
X4=V5
x1=scale(X1,center=T,scale=F)
x1_sq=x1^2
lm.fit1=lm(Y~x1+x1_sq+X2+X4)
y_hat=predict(lm.fit1)
plot(y_hat,Y)
abline(lm(y_hat~Y),col='red')
lm.fit2=lm(Y~x1+X2+X4)
anova(lm.fit1)
anova(lm.fit2)

b=lm.fit2$coefficient
MSE=1.281
X0=rep(1,length(V1))
X=cbind(X0,x1,X2,X4)
Xmul=solve(t(X)%*%X)
sb=MSE*Xmul

X_hat=c(1,8-mean(X1),16,250000)
y_hat=X_hat%*%b
sypred=(X_hat)^2%*%diag(sb)
s=sqrt(as.vector(sypred))
t3=qt(1-0.05/2,81-5)
cbind(y_hat-t3*s,y_hat+t3*s)