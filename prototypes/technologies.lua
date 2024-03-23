table.insert(data.raw["technology"]["circuit-network"].effects, {
    type = "unlock-recipe",
    recipe = Constants.combinator_name
})

table.insert(data.raw["technology"]["steel-processing"].effects, {
    type = "unlock-recipe",
    recipe = Constants.export_chest_name
})

table.insert(data.raw["technology"]["steel-processing"].effects, {
    type = "unlock-recipe",
    recipe = Constants.import_chest_name
})

table.insert(data.raw["technology"]["electric-energy-distribution-1"].effects, {
    type = "unlock-recipe",
    recipe = Constants.export_accumulator_name
})

table.insert(data.raw["technology"]["electric-energy-distribution-1"].effects, {
    type = "unlock-recipe",
    recipe = Constants.import_accumulator_name
})
