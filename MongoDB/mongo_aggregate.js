db.makemodel.aggregate([
 { $match: {"Vehicle_Type": {$in : [2,3,4,5,23,97]}}},
 { $limit : 100 },
 { $lookup:
  {
    from: "vehicletype",
    localField: "Vehicle_Type",
    foreignField: "code",
    as: "type"
  }},
  {"$unwind": "$type"},
  {
  $lookup:
  {
    from: "accidents",
    localField: "Accident_Index",
    foreignField: "Accident_Index",
    as: "severity"
  }
  },
  {"$unwind": "$severity"},
  {$sort: {"severity.Accident_Severity": 1}},
  {$group: {_id: "$type.label", average: {$avg: "$severity.Accident_Severity"}, count: {$sum: 1}, sev: {$push: "$severity.Accident_Severity"}}},
  {$project: {
    "_id": "$_id",
    "average": "$average",
    "sev": "$sev",
    "halfcount": {
      $let: {
        vars: {
          divcount: {$sum: 1}
        },
        in: {$divide: ["$count", 2]}
      }
    }
  }},
  {$project: {
     "_id": "$_id",
    "average": "$average",
    "sev": "$sev",
    "halfcount": "$halfcount",
    "median": {
      $let: {
        vars: {
          med: {$toInt: "$halfcount"}
        },
        in: {$arrayElemAt: ["$sev", "$$med"]}
      }
    }

  }},
  {$project: {
     "_id": "$_id",
    "average": "$average",
    "median": "$median"

  }}
])