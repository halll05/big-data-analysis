--Mongo Commands to load the data

mongoimport --collection accidents --file Accidents.csv --type csv --headerline

mongoimport --collection makemodel --file Make_Model.csv --type csv --headerline

mongoimport --collection vehicletype --file vehicle_type.csv --type csv --headerline