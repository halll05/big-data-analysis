--This document includes data loading, and Question 3.

--Load data
load csv with headers from "file:///Accidents.csv" as row
create (r:Accidents {accID: row.`Accident_Index`, severity: toInteger(row.`Accident_Severity`)});

load csv with headers from "file:///vehicle_type.csv" as row
create (v:vehicle_type {code: toInteger(row.`code`), label: row.`label`});

--Create relationships
:auto using periodic commit 500 load csv with headers from "file:///Make_Model.csv" as row
match(a:Accidents {accID: row.`Accident_Index`}),(v:vehicle_type {code: toInteger(row.`Vehicle_Type`)})
create(a)-[:OCCURS_IN_VEHICLE_TYPE] -> (v);

--Confirm that all records transferred over
match (a:Accidents) return count (a) as count

-See the created relationships
MATCH p=()-[r:OCCURS_IN_VEHICLE_TYPE]->() RETURN p LIMIT 25

-To speed up building of relationships, create indexes
create index uniq_veh for (v:vehicle_type) on (v.code);

create index uniq_acc for (a:Accidents) on (a.aID);

--delete relationships (if necessary)
match ()-[r:OCCURS_IN_VEHICLE_TYPE] ->() delete r

--median and average (Question 3)
match (a:Accidents)-[:OCCURS_IN_VEHICLE_TYPE]->(v) where v.code = 2 or v.code = 3 or v.code = 4 or v.code = 5 or v.code = 23 or v.code = 97
return v.label, percentileDisc(a.severity,0.5), avg(a.severity);
