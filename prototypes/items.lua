local connect_combinator_item = table.deepcopy(data.raw["item"]["arithmetic-combinator"])
connect_combinator_item.name = Constants.combinator_name
connect_combinator_item.localised_name = "Connect combinator"
connect_combinator_item.localised_description = "Connect combinator"
connect_combinator_item.icon = "__graftorio3__/graphics/icons/connect-combinator-icon.png"
connect_combinator_item.place_result = Constants.combinator_name
data:extend{connect_combinator_item}

local export_chest_item = table.deepcopy(data.raw["item"]["steel-chest"])
export_chest_item.name = Constants.export_chest_name
export_chest_item.localised_name = "Export chest"
export_chest_item.localised_description = "Export chest"
export_chest_item.icon = "__graftorio3__/graphics/icons/export-chest-icon.png"
export_chest_item.place_result = Constants.export_chest_name
data:extend{export_chest_item}

local import_chest_item = table.deepcopy(data.raw["item"]["steel-chest"])
import_chest_item.name = Constants.import_chest_name
import_chest_item.localised_name = "Import chest"
import_chest_item.localised_description = "Import chest"
import_chest_item.icon = "__graftorio3__/graphics/icons/import-chest-icon.png"
import_chest_item.place_result = Constants.import_chest_name
data:extend{import_chest_item}

local export_pipe_item = table.deepcopy(data.raw["item"]["pipe-to-ground"])
export_pipe_item.name = Constants.export_pipe_name
export_pipe_item.localised_name = "Export pipe"
export_pipe_item.localised_description = "Export pipe"
export_pipe_item.icon = "__graftorio3__/graphics/icons/export-pipe-icon.png"
export_pipe_item.place_result = Constants.export_pipe_name
data:extend{export_pipe_item}

local import_pipe_item = table.deepcopy(data.raw["item"]["pipe-to-ground"])
import_pipe_item.name = Constants.import_pipe_name
import_pipe_item.localised_name = "Import pipe"
import_pipe_item.localised_description = "Import pipe"
import_pipe_item.icon = "__graftorio3__/graphics/icons/import-pipe-icon.png"
import_pipe_item.place_result = Constants.import_pipe_name
data:extend{import_pipe_item}

local export_accumulator_item = table.deepcopy(data.raw["item"]["accumulator"])
export_accumulator_item.name = Constants.export_accumulator_name
export_accumulator_item.localised_name = "Export accumulator"
export_accumulator_item.localised_description = "Export accumulator"
export_accumulator_item.icon = "__graftorio3__/graphics/icons/export-accumulator-icon.png"
export_accumulator_item.place_result = Constants.export_accumulator_name
data:extend{export_accumulator_item}

local import_accumulator_item = table.deepcopy(data.raw["item"]["accumulator"])
import_accumulator_item.name = Constants.import_accumulator_name
import_accumulator_item.localised_name = "Import accumulator"
import_accumulator_item.localised_description = "Import accumulator"
import_accumulator_item.icon = "__graftorio3__/graphics/icons/import-accumulator-icon.png"
import_accumulator_item.place_result = Constants.import_accumulator_name
data:extend{import_accumulator_item}
