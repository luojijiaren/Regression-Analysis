
data mileage;
  input y x;
  label y='milespergallon'
        x='speed';
cards;
   22.0   35.0
   20.0   35.0
   28.0   40.0
   31.0   40.0
   37.0   45.0
   38.0   45.0
   41.0   50.0
   39.0   50.0
   34.0   55.0
   37.0   55.0
   27.0   60.0
   30.0   60.0
;
run;

data temp;
set mileage;
xsq=x*x;
run;

proc print data=temp;
run;


proc reg data=temp;
  model y = x xsq;
  output out=temp r=residual p=yhat;
run;

title" ";
proc sgplot data=temp;
series x=x y=yhat / lineattrs=(color='red');
scatter x=x y=y;
run;

/*
*need sas 9.4;
%macro analyze(data=,out=);
   options nonotes;
   proc reg data=&data noprint
            outest=&out(drop=y _RMSE_);
      model y=x xsq;
      %bystmt;
   run;
   options notes;
%mend;
%boot(data=temp,residual=residual,equation=y=yhat+residual,random=123,samples=1000)
%bootci(bca);
%bootci(pctl);  */


proc surveyselect data= temp out=outboot(rename=(Replicate=SampleID))
seed=123
mothod=urs
samprate=1
outhits
rep=1000;
run;


proc print data=outboot;
run;
