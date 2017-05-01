data ch11_23;
  input y x1 x2 x3 x4;
cards;
78.5      7      26      6      60
74.3      1      29      15      52
104.3      11      56      8      20
87.6      11      31      8      47
95.9      7      52      6      33
109.2      11      55      9      22
102.7      3      71      17      6
72.5      1      31      22      44
93.1      2      54      18      22
115.9      21      47      4      26
83.8      1      40      23      34
113.3      11      66      9      12
109.4      10      68      8      12
;
run;

proc reg data=ch11_23;
  model y = x1-x4;
  output out=temp r=residual;
run;


proc reg data=ch11_23 outvif outstb rsqare
         outest=b ridge = (0.000 0.002 0.004 0.006 0.008 0.02 0.04 0.06 0.08 0.1);
   model y=x1 x2 x3 x4;
run;
title' Parameter Estimates';
proc print data = b noobs;
  where _type_ = 'RIDGESTB';
  var _ridge_ x1 x2 x3 x4 ;
run;
title 'VIFs';
proc print data = b noobs;
  where _type_ = 'RIDGEVIF';
  var _ridge_ x1 x2 x3 x4;
run;

*??;
title 'R^2';
proc print data = b noobs;
  var _ridge_ _RSQ_;
run;
