data=read.table('CH03PR15.txt')
attach(data)

x1=rep(1,length(V2))
X=cbind(x1,V2)

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

