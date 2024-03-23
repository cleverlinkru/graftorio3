local connect_combinator_recipe = table.deepcopy(data.raw["recipe"]["arithmetic-combinator"])
connect_combinator_recipe.enabled = false
connect_combinator_recipe.name = Constants.combinator_name
connect_combinator_recipe.result = Constants.combinator_name
data:extend{connect_combinator_recipe}

local export_chest_recipe = table.deepcopy(data.raw["recipe"]["steel-chest"])
export_chest_recipe.enabled = false
export_chest_recipe.name = Constants.export_chest_name
export_chest_recipe.result = Constants.export_chest_name
data:extend{export_chest_recipe}

local import_chest_recipe = table.deepcopy(data.raw["recipe"]["steel-chest"])
import_chest_recipe.enabled = false
import_chest_recipe.name = Constants.import_chest_name
import_chest_recipe.result = Constants.import_chest_name
data:extend{import_chest_recipe}

local export_pipe_recipe = table.deepcopy(data.raw["recipe"]["pipe-to-ground"])
export_pipe_recipe.name = Constants.export_pipe_name
export_pipe_recipe.result = Constants.export_pipe_name
data:extend{export_pipe_recipe}

local import_pipe_recipe = table.deepcopy(data.raw["recipe"]["pipe-to-ground"])
import_pipe_recipe.name = Constants.import_pipe_name
import_pipe_recipe.result = Constants.import_pipe_name
data:extend{import_pipe_recipe}

local export_accumulator_recipe = table.deepcopy(data.raw["recipe"]["accumulator"])
export_accumulator_recipe.name = Constants.export_accumulator_name
export_accumulator_recipe.result = Constants.export_accumulator_name
data:extend{export_accumulator_recipe}

local import_accumulator_recipe = table.deepcopy(data.raw["recipe"]["accumulator"])
import_accumulator_recipe.name = Constants.import_accumulator_name
import_accumulator_recipe.result = Constants.import_accumulator_name
data:extend{import_accumulator_recipe}
