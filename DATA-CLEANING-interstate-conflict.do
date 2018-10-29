*** Interstate conflict data
*	Data: Militarized Interstate Disuptes (v4.2)
*	Source: Correlates of War Project (http://www.correlatesofwar.org/data-sets/MIDs)
*	Downloaded: October 29, 2018 by Nicholas Poggioli (poggi005@umn.edu)
*	Code by: Nicholas Poggioli (poggi005@umn.edu)
***

*********************
*	Country-level	*
*********************

***	Import raw data
import delimited D:\Dropbox\Peace&FDI\data\interstate-conflict-data\MIDB_4.2.csv, clear stringcols(_all)

***	Replace -9 missing indicator with missing
foreach variable in dispnum4 stday endday revtype1 revtype2 fatality fatalpre hiact {
	replace `variable'="" if `variable'=="-9"
}

***	Destring numerics
foreach variable in stday stmon styear endday endmon endyear fatalpre sidea revstate orig {
	destring(`variable'), replace
}

***	Label variables
label var dispnum3 "Dispute number (version 3)"
label var dispnum4 "Dispute number (Version 4)"
label var stabb "State abbreviation of participant"
label var ccode "Country code / state number of participant"
label var stday "Start day of participation in dispute"
label var stmon "Start month of participation in dispute"
label var styear "Start year of participation in dispute "
label var endday "End day of participation in dispute"
label var endmon "End month of participation in dispute"
label var endyear "End year of participation in dispute"
label var sidea "Country is Side A in dispute-level data"
label var revstate "Revisionist state?"
label var revtype1 "Revision type #1"
label var revtype2 "Revision type #2"
label var fatality "Fatality level"
label var fatalpre "Precise fatalities, if known"
label var hiact "Highest action by state in dispute"
label var hostlev "Hostility level reached by state in dispute"
label var orig "Originator of dispute"
label var version "Version number of dataset"

label define yesno 1 "yes" 0 "no"
label values sidea revstate orig yesno
replace sidea=. if sidea==2		/*	No codebook explanation for value of 2: assume missing	*/

label define revlab 	0 "not applicable"  ///
						1 "territory"  ///
						2 "policy"  ///
						3 "regime/government" ///
						4 "other"
destring(revtype1), replace
destring(revtype2), replace
label values revtype1 revtype2 revlab

label define fatallab 	0 "none" ///
						1 "1-25 deaths" ///
						2 "26-100 deaths" ///
						3 "101-250 deaths" ///
						4 "251-500 deaths"  ///
						5 "501-999 deaths"  ///
						6 ">999 deaths"
destring(fatality), replace
label values fatality fatallab

label define hiactlab	0 "No militarized action" ///
						1 "Threat to use force" ///
						2 "Threat to blockade" ///
						3 "Threat to occupy territory" ///
						4 "Threat to declare war" ///
						5 "Threat to use CBR weapons" ///
						6 "Threat to join war" ///
						7 "Show of force" ///
						8 "Alert" ///
						9 "Nuclear alert" ///
						10 "Mobilization" ///
						11 "Fortify border" ///
						12 "Border violation" ///
						13 "Blockade" ///
						14 "Occupation of territory" ///
						15 "Seizure" ///
						16 "Attack" ///
						17 "Clash" ///
						18 "Declaration of war" ///
						19 "Use of CBR weapons" ///
						20 "Begin interstate war" ///
						21 "Join interstate war"
destring(hiact), replace
label values hiact hiactlab
replace hiact=. if hiact==22 	/*	No codebook explanation for 22: assume missing	*/

label define hostlevlab	1 "No militarized action" ///
						2 "Threat to use force" ///
						3 "Display of force" ///
						4 "Use of force" ///
						5 "War"
destring(hostlev), replace
label values hostlev hostlevlab
replace hostlev=. if hostlev==0	/*	No codebook explanation for 0: assume missing	*/

***	Save
compress
save D:\Dropbox\Peace&FDI\data\interstate-conflict-data\interstate-conflict-data-country-level-clean.dta, replace




*********************
*	Dispute-level	*
*********************

***	Import raw data
import delimited D:\Dropbox\Peace&FDI\data\interstate-conflict-data\MIDA_4.2.csv, clear stringcols(_all)

***	Replace -9 missing indicator with missing
foreach variable in stday endday outcome settle fatality fatalpre hiact {
	replace `variable'="" if `variable'=="-9"
}

***	Destring numerics
foreach variable in stday stmon styear endday endmon endyear outcome settle fatalpre {
	destring(`variable'), replace
}

*** Label variables
label var dispnum3 "Dispute number (version 3)"
label var dispnum4 "Dispute number (Version 4)"
label var stday "Start day of dispute"
label var stmon "Start month of dispute"
label var styear "Start year of dispute "
label var endday "End day of dispute"
label var endmon "End month of dispute"
label var endyear "End year of dispute"
label var outcome "Outcome of dispute"
label var settle "Settlement of dispute"
label var fatality "Fatality level of dispute"
label var fatalpre "Precise fatalities, if known"
label var maxdur "Maximum duration of dispute"
label var mindur "Minimium duration of dispute"
label var hiact "Highest action in dispute [bracket number refers to hostlev variable]"
label var hostlev "Hostility level of dispute"
label var recip "Feciprocated dispute?"
label var numa "Number of states on side A"
label var numb "Number of states on side B"
label var link1 "Links to other disputes/wars 1"
label var link2 "Links to other disputes/wars 2"
label var link3 "Links to other disputes/wars 3"
label var ongo2010 "Ongoing after 2010?"
label var version "Version number of dataset"

label define outcomelab	1 "Victory for side A"  ///
						2 "Victory for side B"  ///
						3 "Yield by side A" ///
						4 "Yield by side B"  ///
						5 "Stalemate"  ///
						6 "Compromise"  ///
						7 "Released"  ///
						8 "Unclear"  ///
						9 "Joins ongoing war"
label values outcome outcomelab

label define yesno 1 "yes" 0 "no"
destring(recip), replace
label values recip yesno

label define settlelab 1 "Negotiated" 2 "Imposed" 3 "None" 4 "Unclear"
label values settle settlelab

label define fatallab 	0 "none"  ///
						1 "1-25 deaths"  ///
						2 "26-100 deaths"  ///
						3 "101-250 deaths" ///
						4 "251-500 deaths"  ///
						5 "501-999 deaths"  ///
						6 ">999 deaths"
destring(fatality), replace
label values fatality fatallab

label define hiactlab	0 "No militarized action [1]" ///
						1 "Threat to use force [2]" ///
						2 "Threat to blockade [2]" ///
						3 "Threat to occupy territory [2]" ///
						4 "Threat to declare war [2]" ///
						5 "Threat to use CBR weapons [2]" ///
						6 "Threat to join war" ///
						7 "Show of force [3]" ///
						8 "Alert [3]" ///
						9 "Nuclear alert [3]" ///
						10 "Mobilization [3]" ///
						11 "Fortify border [3]" ///
						12 "Border violation [3]" ///
						13 "Blockade [4]" ///
						14 "Occupation of territory [4]" ///
						15 "Seizure [4]" ///
						16 "Attack [4]" ///
						17 "Clash [4]" ///
						18 "Declaration of war [4]" ///
						19 "Use of CBR weapons [4]" ///
						20 "Begin interstate war [5]" ///
						21 "Join interstate war [5]"
destring(hiact), replace
label values hiact hiactlab
replace hiact=. if hiact==22 	/*	No codebook explanation for 22: assume missing	*/

label define hostlevlab	1 "No militarized action" ///
						2 "Threat to use force" ///
						3 "Display of force" ///
						4 "Use of force" ///
						5 "War"
destring(hostlev), replace
label values hostlev hostlevlab

label define ongolab 	0 "Concluded before 6/30/2010" 1 "Continuing as of 6/30/2010"
destring(ongo2010), replace
label values ongo2010 ongolab

***	Save
compress
save D:\Dropbox\Peace&FDI\data\interstate-conflict-data\interstate-conflict-data-dispute-level-clean.dta, replace































































*END
