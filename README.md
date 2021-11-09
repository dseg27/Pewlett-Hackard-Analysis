# Pewlett-Hackard-Analysis

## PURPOSE

The purpose of this analysis was to create additional SQL queries to answer the following questions:
1) How many staff from each department should the company expect to be retiring soon? 
2) Will there be enough staff to support a part-time mentorship program for the influx of soon-to-be retirees? 

In order to answer these questions, PostgreSQL was used to make additional queries to the database in order to combine tables and filter by the data needed to answer these questions. 

## ANALYSIS 
The first query resulted in the following table, which shows the number of employees from each department that the company can expect to retire soon. 


![image](https://user-images.githubusercontent.com/90593897/140985166-61dba4c6-20f0-4bde-9180-d3de642c6afd.png)


It can be noted that:

	1) The departments with the largest number of soon-to-be retirees are the Senior Engineering department, and other Senior Staff. These departments alone make up for ~64% of all soon-to-be retirees.
  
	2) There are only 2 managers that are retiring soon, so this position will take the least amount of candidates into consideration when looking to fill the vacancy. 


The second query resulted in the next table, which contains a list of current staff who are eligible for the mentorship program to work with the soon-to-be retirees.
![image](https://user-images.githubusercontent.com/90593897/140984278-3b3cab98-ced8-4bec-976c-d6cc296c9002.png)

	3) There are a total of 1,549 mentors eligible for the mentorship program that the company is considering
  
![image](https://user-images.githubusercontent.com/90593897/140986065-954692cb-1f8a-4192-8880-bf553033f7fe.png)

	4) When the mentorship eligibility table is grouped by title, we see that fortunately, the largest number of eligible mentors are currently in the senior staff and engineering roles, so they can help support the large influx of retirees from these departments.

  
## SUMMARY
Per the new query that was run on the first table that listed the retirees, we can see that the total number of retirees the company should expect to retire soon is 90,398.


 ![image](https://user-images.githubusercontent.com/90593897/140983231-aff8503c-da39-45b8-b83f-e7bfaa44b0e8.png)

With a total of 1,549 eligible mentors, there are likely enough staff to support a mentorship program. 
If every retiree participates, there would be a ratio of roughly 1 mentor: 60 retirees. 
Assuming not every retiree will participate, this ratio could be sustainable if a mentorship program was run virtually, as one mentor could easily host a video conference with 60 people. 

The only department that does not have an eligible mentor is the Management department. The company may need to designate someone in this department who was not born in 1965 to recruit and mentor for this team. 
