data=read.table('CH03PR15.txt')
attach(data)
lm.fit=lm(V1~V2)
summary(lm.fit)
anova(lm.fit)
plot(V2,sqrt(V1))
boxcox(V2,V1,lamda=seq(-2,2,by=1))

gmean=exp(mean(log(V1)))
sse=c()
lambda=c()
i=1
for (lam in seq(-2,2,1)) {
if(lam!=0) {
ty=(V1^lam-1)/(lam*gmean^(lam-1))
} else {
ty=log(V1)*gmean
}
test=anova(lm(ty~V2))
sse[i]=test['Residuals','Sum Sq']
lambda[i]=lam
i=i+1
}
rbind(lambda,sse)

Y1=log10(V1)
lm.fit2=lm(Y1~V2)
summary(lm.fit2)
plot(V2,Y1)
abline(lm.fit2,col='red')

par(mfrow=c(2,2))
plot(lm.fit2)


