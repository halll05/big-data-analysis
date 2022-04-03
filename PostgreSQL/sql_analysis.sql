select str(accident_index), accident_severity from accident
order by accident_severity
offset 70000;

select * from accident_interm
offset 80000;

select * from accident where accident.row_number() = 70028;

--Use this one for the median
select percentile_disc(0.5) within group (order by accident.accident_severity) from accident;

delete from accident_interm;
select * from accident
select * from accident_interm
offset 70000;

--Confirm data quality
select * from accident
offset 70000;

--Copy data from accident intermediary table to accident table
insert into accident(accident_index, accident_severity)
select accident_index, accident_severity
from accident_interm;

----Copy data from makemodel intermediary table to makemodel table
insert into makemodel(accident_index, vehicle_type)
select accident_index, vehicle_type
from makemodel_interm;

delete from makemodel;

select * from makemodel_interm
where accident_index LIKE '2015331500204';

select * from makemodel
order by vehicle_type;

select * from vehicletype;

select count(*) from accident

--Find the median accident severity from motorcycles
select percentile_disc(0.5) within group (order by accident.accident_severity) from accident
inner join makemodel as m on accident.accident_index = m.accident_index
inner join vehicletype on cast(m.vehicle_type as int) = vehicletype.code
where vehicletype.code = 2 or vehicletype.code = 3 or vehicletype.code = 4 or vehicletype.code = 5 or vehicletype.code = 23
or vehicletype.code = 97;

select * from vehicletype;




--Find the average accident severity from motorcycles
select AVG(accident.accident_severity) as "Average Severity", percentile_disc(0.5) within group (order by accident.accident_severity) as "Median Severity",
vehicletype.code_label as "Vehicle Type" from accident
inner join makemodel as m on accident.accident_index = m.accident_index
inner join vehicletype on cast(m.vehicle_type as int) = vehicletype.code
where vehicletype.code = 2 or vehicletype.code = 3 or vehicletype.code = 4 or vehicletype.code = 5 or vehicletype.code = 23
or vehicletype.code = 97
group by "Vehicle Type";

