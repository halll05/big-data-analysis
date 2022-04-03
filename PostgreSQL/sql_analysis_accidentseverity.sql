--Find the average accident severity from motorcycles
select AVG(accident.accident_severity) as "Average Severity", percentile_disc(0.5) within group (order by accident.accident_severity) as "Median Severity",
vehicletype.code_label as "Vehicle Type" from accident
inner join makemodel as m on accident.accident_index = m.accident_index
inner join vehicletype on cast(m.vehicle_type as int) = vehicletype.code
where vehicletype.code = 2 or vehicletype.code = 3 or vehicletype.code = 4 or vehicletype.code = 5 or vehicletype.code = 23
or vehicletype.code = 97
group by "Vehicle Type";