data=read.table('loans.txt',header=TRUE)
attach(data)
plot(x)
plot(x,y)
lm.fit=lm(y~x)
summary(lm.fit)
anova(lm.fit)
cx=factor(x)
anova(lm(y~cx))
(17595-9617)*28/(8*9617)
 qf(0.99,8,28)

par(mfrow=c(2,2))
plot(lm.fit)

res=resid(lm.fit)

boxcox(x,y,lamda=seq(-2,2,by=1))

gmean=exp(mean(log(y)))
sse=c()
lambda=c()
i=1
for (lam in seq(-2,2,1)) {
if(lam!=0) {
ty=(x^lam-1)/(lam*gmean^(lam-1))
} else {
ty=log(y)*gmean
}
test=anova(lm(ty~x))
sse[i]=test['Residuals','Sum Sq']
lambda[i]=lam
i=i+1
}
rbind(lambda,sse)

Y1=y
lm.fit2=lm(Y1~x)
summary(lm.fit2)

x2=x^0.2
lm.fit3=lm(y~x2)
summary(lm.fit3)



