data=read.table('CH03PR15.txt')
attach(data)
lm.fit=lm(V1~V2)
summary(lm.fit)
predict(lm.fit,data.frame(V2=(c(20,30,40))),interval='prediction')


yhat=predict(lm.fit)
x=c()
y=c()
low=c()
up=c()
v=c(20,30,40)
for (i in c(1,2,3)) {
x[i]=v[i]
mse=sum((yhat-V1)^2)/14
s_sq=mse*(1+(x[i]-mean(V2))^2/sum((V2-mean(V2))^2))
s=sqrt(s_sq)
B=qt(1-0.1/4,14)
yh=predict(lm.fit,data.frame(V2=x[i]))
y[i]=yh
low[i]=yh-B*s
up[i]=yh+B*s
}
cbind(x,y,low,up)
