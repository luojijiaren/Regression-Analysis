data=read.table('CH06PR18.txt')
attach(data)
Y=V1
X1=V2
X2=V3
X3=V4
X4=V5
stem(X1)
stem(X2)
stem(X3)
stem(X4)

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






x1=rep(1,length(V2))
X=cbind(x1,V2,V3,V4,V5)
Y=V1


Xmul=solve(t(X)%*%X)
b=Xmul%*%t(X)%*%V1
yhat=X%*%b
round(yhat,3)
H=X%*%Xmul%*%t(X)
round(H,3)

e=V1-yhat
SSE=t(e)%*%e
MSE=SSE/13
MSE
sb_sq=0.225*Xmul
sb_sq
Xh=rbind(1,30)
spred_sq=0.225*(1+t(Xh)%*%Xmul%*%Xh)
spred_sq

