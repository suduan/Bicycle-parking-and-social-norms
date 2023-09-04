use "E:\学术\观察实验\观察实验回归\计量回归\2023 5月\ParkNorm.dta" 

gen elebicycle=1
replace elebicycle=0 if shared==1
replace elebicycle=0 if private==1

***Table 2: Distribution
tab1 gender age location period treatment bicycle

***Table 3: Descriptive Statistics
summarize age gender temporary hurry  others othergoods  bicycle  location week day daytime

***Figure 6***
cibar both, over(treatment) graphopts(ylabel(0.5(0.1)1) title("Proper Parking") name(properparking, replace))
cibar area, over(treatment) graphopts(ylabel(0.5(0.1)1) title("Proper Parking") name(area, replace))
cibar manner, over(treatment) graphopts(ylabel(0.5(0.1)1) title("Proper Parking") name(manner, replace))

***Figure 7***
preserve
keep if during==1
cibar both, over(treatment) graphopts(ylabel(0.5(0.1)1) title("Proper Parking") name(properparkingduring, replace))
cibar area, over(treatment) graphopts(ylabel(0.5(0.1)1) title("Proper Parking") name(areaduring, replace))
cibar manner, over(treatment) graphopts(ylabel(0.5(0.1)1) title("Proper Parking") name(mannerduring, replace))
restore

***Table 4: T Test***
preserve
keep if during==1
ttest both, by(treatment), if treatment==0 | treatment==1
ttest both, by(treatment), if treatment==0 | treatment==2
ttest both, by(treatment), if treatment==0 | treatment==3
ttest both, by(treatment), if treatment==0 | treatment==4
ttest both, by(treatment), if treatment==1 | treatment==2
ttest both, by(treatment), if treatment==1 | treatment==3
ttest both, by(treatment), if treatment==1 | treatment==4
ttest both, by(treatment), if treatment==2 | treatment==3
ttest both, by(treatment), if treatment==2 | treatment==4
ttest both, by(treatment), if treatment==3 | treatment==4

ttest area, by(treatment), if treatment==0 | treatment==1
ttest area, by(treatment), if treatment==0 | treatment==2
ttest area, by(treatment), if treatment==0 | treatment==3
ttest area, by(treatment), if treatment==0 | treatment==4
ttest area, by(treatment), if treatment==1 | treatment==2
ttest area, by(treatment), if treatment==1 | treatment==3
ttest area, by(treatment), if treatment==1 | treatment==4
ttest area, by(treatment), if treatment==2 | treatment==3
ttest area, by(treatment), if treatment==2 | treatment==4
ttest area, by(treatment), if treatment==3 | treatment==4

ttest manner, by(treatment), if treatment==0 | treatment==1
ttest manner, by(treatment), if treatment==0 | treatment==2
ttest manner, by(treatment), if treatment==0 | treatment==3
ttest manner, by(treatment), if treatment==0 | treatment==4
ttest manner, by(treatment), if treatment==1 | treatment==2
ttest manner, by(treatment), if treatment==1 | treatment==3
ttest manner, by(treatment), if treatment==1 | treatment==4
ttest manner, by(treatment), if treatment==2 | treatment==3
ttest manner, by(treatment), if treatment==2 | treatment==4
ttest manner, by(treatment), if treatment==3 | treatment==4
restore

***Table 5A：Only Pre***
preserve
keep if during==0
keep if post==0
logistic both gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location, coef vce(robust) 
outreg2 using pre_only.doc,replace dec(3) keep(gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
logistic area gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location, coef vce(robust)
outreg2 using pre_only.doc,append dec(3) keep(gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
logistic manner gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location, coef vce(robust)
outreg2 using pre_only.doc,append dec(3) keep(gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
restore

***Table 5B: Main results***
logistic both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post, coef vce(robust) 
margins ,dydx(*)
outreg2 using main.doc,replace dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post, coef vce(robust)
margins ,dydx(*)
outreg2 using main.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location  during post, coef vce(robust)
margins ,dydx(*)
outreg2 using main.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)

probit both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post, vce(robust)
outreg2 using probit.doc,replace dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
probit area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post, vce(robust)
outreg2 using probit.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
probit manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post, vce(robust)
outreg2 using probit.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)

***Table 6:Social norms*Rate***
gen ptrate=postext*rate
gen ntrate=negtext*rate
gen pprate=pospicture*rate
gen nprate=negpicture*rate
 
logistic both postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location during post, coef vce(robust) 
outreg2 using interact.doc,replace dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location  during post)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location during post, coef vce(robust)
outreg2 using interact.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location  during post)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location  during post, coef vce(robust)
outreg2 using interact.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location  during post)

logistic both postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location during post ptrate ntrate pprate nprate, coef vce(robust)
outreg2 using interact.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location during post ptrate ntrate pprate nprate)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry rate others othergoods shared elebicycle week i.day i.daytime i.location during post ptrate ntrate pprate nprate, coef vce(robust)
outreg2 using interact.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location during post ptrate ntrate pprate nprate)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry rate others othergoods shared elebicycle week i.day i.daytime i.location during post ptrate ntrate pprate nprate, coef vce(robust)
outreg2 using interact.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location during post ptrate ntrate pprate nprate)

logistic both postext negtext pospicture negpicture gender i.age temporary hurry rate others  shared elebicycle week i.day i.daytime i.location during post ptothers ntothers ppothers npothers, coef vce(robust)
outreg2 using interact.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location during post ptothers ntothers ppothers npothers)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location during post ptothers ntothers ppothers npothers, coef vce(robust)
outreg2 using interact.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location during post ptothers ntothers ppothers npothers)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location during post ptothers ntothers ppothers npothers, coef vce(robust)
outreg2 using interact.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry rate others shared elebicycle week i.day i.daytime i.location during post ptothers ntothers ppothers npothers)


***Table A.3: Cluster Treatment***
logistic both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post, coef robust cluster (treatment)
outreg2 using doc6.doc,replace dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post, coef robust cluster (treatment)
outreg2 using doc6.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post, coef robust cluster (treatment)
outreg2 using doc6.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)

***Table A.4: Control Weather***
logistic both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy, coef vce(robust) 
outreg2 using doc2.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy, coef vce(robust)
outreg2 using doc12.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy, coef vce(robust)
outreg2 using doc2.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy)

logistic both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy windy AQI avg_tem, coef vce(robust) 
outreg2 using doc2.doc,replace dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy windy AQI avg_tem)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy windy AQI avg_tem, coef vce(robust)
outreg2 using doc2.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy windy AQI avg_tem)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy windy AQI avg_tem, coef vce(robust)
outreg2 using doc2.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post rainy windy AQI avg_tem)

***Gap of Posted social norms and Seen Social Norms***
gen gap=rate-0.73
gen gpt=gap*postext
gen gnt=gap*negtext
gen gpp=gap*pospicture
gen gnp=gap*negpicture

logistic both postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry gap shared elebicycle week i.day i.daytime i.location during post, coef vce(robust), if gap>=0
outreg2 using gap.doc,replace dec(3) keep(postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry rate gap shared elebicycle week i.day i.daytime i.location during post)
logistic area postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry gap shared elebicycle week i.day i.daytime i.location during post, coef vce(robust), if gap>=0
outreg2 using gap.doc,append dec(3) keep(postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry rate gap shared elebicycle week i.day i.daytime i.location during post)
logistic manner postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry gap shared elebicycle week i.day i.daytime i.location  during post, coef vce(robust), if gap>=0
outreg2 using gap.doc,append dec(3) keep(postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry rate gap shared elebicycle week i.day i.daytime i.location during post)


logistic both postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry gap shared elebicycle week i.day i.daytime i.location during post, coef vce(robust), if 0>gap
outreg2 using gap.doc,append dec(3) keep(postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry rate gap shared elebicycle week i.day i.daytime i.location during post)
logistic area postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry gap shared elebicycle week i.day i.daytime i.location during post, coef vce(robust), if 0>gap 
outreg2 using gap.doc,append dec(3) keep(postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry rate gap shared elebicycle week i.day i.daytime i.location during post)
logistic manner postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry gap shared elebicycle week i.day i.daytime i.location  during post, coef vce(robust), if 0>gap
outreg2 using gap.doc,append dec(3) keep(postext negtext pospicture negpicture gpt gnt gpp gnp gender i.age temporary hurry rate gap shared elebicycle week i.day i.daytime i.location during post)

 

***Table A.5: By Bicycle Type***
logistic both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if shared==1 
outreg2 using doc5.doc,replace dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if shared==1 
outreg2 using doc5.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if shared==1 
outreg2 using doc5.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)

logistic both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if private==1 
outreg2 using doc5.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if private==1 
outreg2 using doc5.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if private==1 
outreg2 using doc5.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)

logistic both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if shared==0 & private==0 
outreg2 using doc5.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if shared==0 & private==0 
outreg2 using doc5.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if shared==0 & private==0 
outreg2 using doc5.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)

logistic both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if shared==0 
outreg2 using doc5.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if shared==0 
outreg2 using doc5.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy, coef vce(robust),if shared==0 
outreg2 using doc5.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods week i.day i.daytime i.location during post rainy)



***Only Pre and During***
logistic both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during rainy, coef vce(robust),if post==0
outreg2 using doc3.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during rainy)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during rainy, coef vce(robust),if post==0
outreg2 using doc3.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during rainy)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during rainy, coef vce(robust),if post==0
outreg2 using doc3.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during rainy)

***Only During***
logistic both gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location post rainy, coef vce(robust),if during==0
outreg2 using doc3.doc,append dec(3) keep(gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location post rainy)
logistic area gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location post rainy, coef vce(robust),if during==0
outreg2 using doc3.doc,append dec(3) keep(gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location post rainy)
logistic manner gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location post rainy, coef vce(robust),if during==0
outreg2 using doc3.doc,append dec(3) keep(gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location post rainy)


***Peak Hours***
gen workday=0
replace workday=1 if day==1 |day==2 |day==3 |day==4 |day==5 
gen peakhour=0
replace peakhour=1 if 750<=parktime & parktime<=820 & workday==1
replace peakhour=1 if 1000<=parktime & parktime<=1030 & workday==1
replace peakhour=1 if 1400<=parktime & parktime<=1430 & workday==1
replace peakhour=1 if 1610<=parktime & parktime<=1640 & workday==1

logistic both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.location during post, coef vce(robust), if peakhour==1
outreg2 using peak.doc,replace dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day  i.location during post, coef vce(robust), if peakhour==1
outreg2 using peak.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.location  during post, coef vce(robust), if peakhour==1
outreg2 using peak.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)

logistic both postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.location during post, coef vce(robust), if peakhour==0
outreg2 using peak.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
logistic area postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day  i.location during post, coef vce(robust), if peakhour==0
outreg2 using peak.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)
logistic manner postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.location  during post, coef vce(robust), if peakhour==0
outreg2 using peak.doc,append dec(3) keep(postext negtext pospicture negpicture gender i.age temporary hurry others othergoods shared elebicycle week i.day i.daytime i.location during post)


