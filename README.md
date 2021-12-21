# Application User Data Analyzing 
A user data sorting algorithm built in R to intake CSV of user actions report for ANONYMOUS advertising software company. Designed to output a refined version of the report to access specific behavioral insights.

## The Goal
The initiative here was to automate the process of User Behavior collection for an advertisement tracking application. The application provides raw data based on user input and the function of this program is to create a refined list that contains summarized data insights (aggregates, averages).

## Requirements for my program
Update the column headings for ingestion to match what comes out of source (see the attached CSV)
Have the output file match the previous headings I supplied - I can send that CSV to you if you need it
Add a column showing Difference of individual cells in Column I & J (Label = Abandoned Initiatives)
Add a column showing the Sum of individual cells in Column Y & Z (Label = Explored Plans)

### Build an output that shows:
Average of Column F (Label = Average Time on Platform)
Average of Column G (Label = Average Days Active)
Sum of column I (Label = Total Initiatives Created)
Sum of column J (Label = Total Initiatives Launched)
Sum of NEW Column “Abandoned Initiatives” (Label = Total Abandoned Initiatives)
Average of the “Abandoned Initiatives” column, but only for individuals >0
Sum of Column K (Label = Total Initiatives Explored)
Sum of Column L (Label = Total Allocations Run)
Sum of Column K (Label = Total Initiatives Explored)
Sum of Column L (Label = Total Allocations Run )
Sum of Column M (Label = Total Allocations Explored)
Sum of Column N (Label = Total Allocations Submitted to Mediaocean)
Sum of Column O (Label = Total Audiences Started)
Sum of Column P (Label = Total Audiences Created)
Sum of Column Q (Label = Total Audiences Explored)
Sum of Column R (Label = Total Segments Started)
Sum of Column S (Label = Total Segments Created)
Sum of Column T (Label = Total Segments Explored)
Sum of Column U (Label = Total Plans Started)
Sum of Column V (Label = Total Plans Run)
Sum of Column W (Label = Total Linear Buys Run)
Sum of Column X (Label = Total Aggregate Buys Run)
Sum of NEW Column “Explored Plans” (Label = Total Explored Plans)
Average of Column AA for individuals with responses >0 (Label = Average Time on Measure)
Average of Column AB for individuals with responses >0 (Label = Average Days on Measure)
Average of Column AC for individuals with responses >0 (Label = Average Time on Plan)
Average of Column AD for individuals with responses >0 (Label = Average Days on Plan)
Average of Column AE for individuals with responses >0 (Label = Average Time on Audience)
Average of Column AF for individuals with responses >0 (Label = Average Days on Audience)
Average of Column AG for individuals with responses >0 (Label = Average Time on Allocation)
Average of Column AH for individuals with responses >0 (Label = Average Days on Allocation)

### Similar to the existing RawtoActive and RawtoUnique programs, I’d like to create similar programs that focus on the unique attributes of our platforms different apps:
Measure RawtoActive - This would be anyone who featured a result >0 in columns I-K
Plan RawtoActive - This would be anyone who features a result >0 in columns U-Z
Allocate RawtoActive - This would be anyone who features a result >0 in columns L-N
Audience RawtoActive - This would be anyone who features a result >0 in columns O-T
