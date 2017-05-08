data regsalary;
  input y degree x3 x4;
cards;

   58.8  3   4.49   0
   34.8  1   2.92   0
  163.7  3  29.54  42
   70.0  3   9.92   0
   55.5  3   0.14   0
   85.0  2  15.96   4
   34.0  1   2.27   0
   29.7  1   1.20   0
   56.1  2   5.33   3
   70.6  3  15.74   0
   74.2  1  22.46   2
   34.1  1   3.16   0
   31.6  1   2.62   0
   65.5  1  15.06   5
   57.2  3   2.92   0
   60.3  3   2.26   0
   41.8  1   9.76   1
   76.5  3  14.71   4
  122.1  3  21.76  10
   85.9  3  15.63   8
   55.9  3   1.17   0
   44.3  2   2.33   0
   79.9  3  17.10  18
   58.5  2   7.45   0
   57.3  3   4.55   0
   61.0  2  14.39   8
   52.2  2   5.78   3
   45.7  2   2.08   0
   44.8  2   1.44   0
   39.1  2   1.00   0
   68.1  2  10.53   5
   48.2  2  19.23   0
   51.0  2   5.18   0
   40.7  1   4.43   0
   51.4  2   3.04   0
   40.9  2   1.02   0
   57.7  1  10.14   5
   95.5  3  26.53   8
   34.9  1   6.49   0
   66.6  2  13.97   7
   30.0  1   4.18   0
   64.9  3  12.88   6
  151.2  2  16.01  28
   72.4  2  11.13   6
   41.8  2   0.71   0
   57.8  3   1.55   0
   72.7  3   3.92   0
   36.1  1   4.37   0
   39.8  2   0.79   0
   29.0  1   0.65   0
   40.4  2   0.69   0
   40.7  2   1.09   0
   41.7  2   1.58   0
   97.2  3  10.89   8
   85.3  2  21.08   0
   42.6  2   7.00   0
   39.1  1   4.09   0
   46.6  2   8.86   0
   53.9  2  11.05   6
   87.4  3   2.37  13
   81.7  3   6.37   0
   42.5  1   8.00   0
   40.0  2   0.44   0
   60.5  3   2.10   0
  104.8  3  19.81  24
;
run;

* get indicator variables;
data dummy;
set regsalary;
IF degree=2 then x1=1; ELSE x1 = 0;
IF degree=3 then x2=1; ELSE x2 = 0;
run;

proc reg data=dummy;
  model y = x1-x4;
  output out=temp r=residual;
run;

*white and bp test for constant error variables;
proc model data = dummy;
 parms beta0 beta1 beta2 beta3 beta4;
 y=beta0+beta1*x1+beta2*x2+beta3*x3+beta4*x4;
 fit y/white breusch=(1 x1 x2 x3 x4);
run;
quit;

data temp;
  set temp;
  absr = abs(residual);
run;

*plot multiple plots together and compare;
proc sgscatter data=temp;
compare y=absr
x=(x3 x4)/reg;
run;



proc reg data = temp ;
  model absr = x3 x4;
  output out = temp1 p = s ;
run;
quit;

data temp1;
  set temp1;
  w = 1/(s**2);
run;

proc print data=temp1;
run;


* Obtain WLS fit;
proc reg data = temp1;
  weight w;
  model y = x1 x2 x3 x4 / clb;
run;
quit;



* Another approach using OLS: gives a better sense of quality of fit;
data temp2;
 set temp1;
 int=sqrt(w);
 xw1=x1*int;
 xw2=x2*int;
 xw3=x3*int;
 xw4=x4*int;
 yw=y*int;
run;


proc reg data=temp2;
  model yw = xw1-xw4;
  output out=temp3 r=residual2;
run;


proc model data = temp2;
 parms beta0 beta1 beta2 beta3 beta4;
 yw=beta0+beta1*xw1+beta2*xw2+betaw3*x3+beta4*xw4;
 fit yw/white breusch=(1 xw1 xw2 xw3 xw4);
run;
quit;