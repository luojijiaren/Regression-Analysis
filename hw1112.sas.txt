
data freshman;
  input y x;
  label y='Weight'
        x='Height';
cards;
  185    74
  195    65
  216    72
  156    68
  179    69
  184    75
  157    68
  171    69
  176    70
  128    64
  173    70
  191    70
  190    71
  162    71
  151    69
  134    66
  194    72
  177    69
  145    68
  137    67
;
run;

proc reg data=freshman;
  model y = x;
  output out=temp p=yols r=residual h=h;
run;


proc sgscatter data=freshman;
  compare x=x y=y/reg
;
run;

*m method and mm methodto estimate weight;
proc robustreg data=freshman method=m ;
   model y = x;
 output out=robustreg_out  p=ym weight=weight_m;
run;

proc robustreg data=freshman method=mm seed=100;
   model y = x;
 output out=robustreg_out2 p=ymm weight=weight_mm;
run;

*merge the two outcome;
data weightc;
merge temp robustreg_out robustreg_out2;
run;
proc print data=weightc;
run;

*merge multiple plots;
proc sgplot data=weightc;
series x=x y=yols / lineattrs=(color='red')
         legendlabel="ols";
series x=x y=ym/ lineattrs=(color='green' pattern=shortdash)
         legendlabel="m";
series x=x y=ymm/ lineattrs=(color='yellow' pattern=dot)
         legendlabel="mm";
scatter x=x y=y;
run;






/*
*m method and mm methodto estimate weight;
proc robustreg data=freshman method=m;
 model y=x/diagnostics leverage;
 output out=robustreg_out  weight=weight_m;
run;

proc robustreg data=freshman method=mm;
 model y=x;
 output out=robustreg_out2  weight=weight_mm;
run;

*merge the two outcom;
data weightc;
merge robustreg_out robustreg_out2;
run;
proc print data=weightc;
run;



*m method and mm method to estimate parameter;
data robustreg_out;
 merge robustreg_out temp;
 hwt=sqrt(1-h)*weight;
run;
proc reg data = robustreg_out;
  model y=x;
  weight hwt;
run;


data robustreg_out2;
 merge robustreg_out2 temp;
 hwt2=sqrt(1-h)*weight2;
run;
proc reg data = robustreg_out2;
  model y=x;
  weight hwt2;
run;
quit;




* Another approach using OLS: gives a better sense of quality of fit;

data temp0;
  set temp;
  absr = abs(residual);
run;





proc reg data = temp0 ;
  model absr = x;
  output out = temp1 p = s ;
run;
quit;

data temp1;
  set temp1;
  w = 1/(s**2);
run;

proc print data=temp1;
run;

data temp2;
 set temp1;
 int=sqrt(w);
 xw=x*int;
 yw=y*int;
run;


proc reg data=temp2;
  model yw = xw;
  output out=temp3 r=residual2;
run;
*/
