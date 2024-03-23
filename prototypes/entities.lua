local COMBINATOR_SPRITE = "__graftorio3__/graphics/entity/connect-combinator/connect-combinator.png"
local COMBINATOR_HR_SPRITE = "__graftorio3__/graphics/entity/connect-combinator/hr-connect-combinator.png"


local entity = table.deepcopy(data.raw["arithmetic-combinator"]["arithmetic-combinator"])
entity.name = Constants.combinator_name
entity.localised_name = "Connect combinator"
entity.localised_description = "Connect combinator"
entity.icon = "__graftorio3__/graphics/icons/connect-combinator-icon.png"

entity.sprites.north.layers[1].filename = COMBINATOR_SPRITE
entity.sprites.east.layers[1].filename = COMBINATOR_SPRITE
entity.sprites.south.layers[1].filename = COMBINATOR_SPRITE
entity.sprites.west.layers[1].filename = COMBINATOR_SPRITE
entity.sprites.north.layers[1].hr_version.filename = COMBINATOR_HR_SPRITE
entity.sprites.east.layers[1].hr_version.filename = COMBINATOR_HR_SPRITE
entity.sprites.south.layers[1].hr_version.filename = COMBINATOR_HR_SPRITE
entity.sprites.west.layers[1].hr_version.filename = COMBINATOR_HR_SPRITE
entity.multiply_symbol_sprites = nil

entity.minable.result = Constants.combinator_name
entity.energy_source = {
  type = "void"
}


local out_entity = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
out_entity.name = Constants.combinator_output_name
out_entity.icon = nil
out_entity.icon_size = nil
out_entity.icon_mipmaps = nil
out_entity.next_upgrade = nil
out_entity.minable = nil
out_entity.selection_box = nil
out_entity.collision_box = nil
out_entity.collision_mask = {}
out_entity.item_slot_count = 500
out_entity.circuit_wire_max_distance = 3
out_entity.flags = { "not-blueprintable", "not-deconstructable", "placeable-off-grid" }

local origin = { 0, 0 }

local origin_wire = {
    red = origin,
    green = origin,
}

local connection_point = {
    wire = origin_wire,
    shadow = origin_wire,
}

out_entity.circuit_wire_connection_points = {
    connection_point,
    connection_point,
    connection_point,
    connection_point,
}

local invisible_sprite = {
    filename = "__core__/graphics/empty.png",
    width = 1,
    height = 1,
}

out_entity.sprites = invisible_sprite
out_entity.activity_led_sprites = invisible_sprite

out_entity.activity_led_light_offsets = {
    origin,
    origin,
    origin,
    origin,
}

out_entity.draw_circuit_wires = false


data:extend{
    entity,
    out_entity,
}


local export_chest_entity = table.deepcopy(data.raw["container"]["steel-chest"])
export_chest_entity.name = Constants.export_chest_name
export_chest_entity.localised_name = "Export chest"
export_chest_entity.localised_description = "Export chest"
export_chest_entity.icon = "__graftorio3__/graphics/icons/export-chest-icon.png"
export_chest_entity.inventory_size = 1
export_chest_entity.picture.layers[1].filename = "__graftorio3__/graphics/entity/export-chest/export-chest.png"
export_chest_entity.picture.layers[1].hr_version.filename = "__graftorio3__/graphics/entity/export-chest/hr-export-chest.png"
export_chest_entity.minable.result = Constants.export_chest_name
data:extend{export_chest_entity}

local import_chest_entity = table.deepcopy(data.raw["container"]["steel-chest"])
import_chest_entity.name = Constants.import_chest_name
import_chest_entity.localised_name = "Import chest"
import_chest_entity.localised_description = "Import chest"
import_chest_entity.icon = "__graftorio3__/graphics/icons/import-chest-icon.png"
import_chest_entity.inventory_size = 1
import_chest_entity.picture.layers[1].filename = "__graftorio3__/graphics/entity/import-chest/import-chest.png"
import_chest_entity.picture.layers[1].hr_version.filename = "__graftorio3__/graphics/entity/import-chest/hr-import-chest.png"
import_chest_entity.minable.result = Constants.import_chest_name
data:extend{import_chest_entity}

local export_pipe_entity = table.deepcopy(data.raw["pipe-to-ground"]["pipe-to-ground"])
export_pipe_entity.name = Constants.export_pipe_name
export_pipe_entity.localised_name = "Export pipe"
export_pipe_entity.localised_description = "Export pipe"
export_pipe_entity.icon = "__graftorio3__/graphics/icons/export-pipe-icon.png"
export_pipe_entity.minable.result = Constants.export_pipe_name
export_pipe_entity.fluid_box.base_area = 250
export_pipe_entity.fluid_box.pipe_connections = { { position = {0, -1} } }
export_pipe_entity.pictures.up.filename = '__graftorio3__/graphics/entity/export-pipe/export-pipe-up.png'
export_pipe_entity.pictures.up.hr_version.filename = '__graftorio3__/graphics/entity/export-pipe/hr-export-pipe-up.png'
export_pipe_entity.pictures.down.filename = '__graftorio3__/graphics/entity/export-pipe/export-pipe-down.png'
export_pipe_entity.pictures.down.hr_version.filename = '__graftorio3__/graphics/entity/export-pipe/hr-export-pipe-down.png'
export_pipe_entity.pictures.left.filename = '__graftorio3__/graphics/entity/export-pipe/export-pipe-left.png'
export_pipe_entity.pictures.left.hr_version.filename = '__graftorio3__/graphics/entity/export-pipe/hr-export-pipe-left.png'
export_pipe_entity.pictures.right.filename = '__graftorio3__/graphics/entity/export-pipe/export-pipe-right.png'
export_pipe_entity.pictures.right.hr_version.filename = '__graftorio3__/graphics/entity/export-pipe/hr-export-pipe-right.png'
data:extend{export_pipe_entity}

local import_pipe_entity = table.deepcopy(data.raw["pipe-to-ground"]["pipe-to-ground"])
import_pipe_entity.name = Constants.import_pipe_name
import_pipe_entity.localised_name = "Import pipe"
import_pipe_entity.localised_description = "Import pipe"
import_pipe_entity.icon = "__graftorio3__/graphics/icons/import-pipe-icon.png"
import_pipe_entity.minable.result = Constants.import_pipe_name
import_pipe_entity.fluid_box.base_area = 250
import_pipe_entity.fluid_box.pipe_connections = { { position = {0, -1} } }
import_pipe_entity.pictures.up.filename = '__graftorio3__/graphics/entity/import-pipe/import-pipe-up.png'
import_pipe_entity.pictures.up.hr_version.filename = '__graftorio3__/graphics/entity/import-pipe/hr-import-pipe-up.png'
import_pipe_entity.pictures.down.filename = '__graftorio3__/graphics/entity/import-pipe/import-pipe-down.png'
import_pipe_entity.pictures.down.hr_version.filename = '__graftorio3__/graphics/entity/import-pipe/hr-import-pipe-down.png'
import_pipe_entity.pictures.left.filename = '__graftorio3__/graphics/entity/import-pipe/import-pipe-left.png'
import_pipe_entity.pictures.left.hr_version.filename = '__graftorio3__/graphics/entity/import-pipe/hr-import-pipe-left.png'
import_pipe_entity.pictures.right.filename = '__graftorio3__/graphics/entity/import-pipe/import-pipe-right.png'
import_pipe_entity.pictures.right.hr_version.filename = '__graftorio3__/graphics/entity/import-pipe/hr-import-pipe-right.png'
data:extend{import_pipe_entity}

local export_accumulator_entity = table.deepcopy(data.raw["accumulator"]["accumulator"])
export_accumulator_entity.name = Constants.export_accumulator_name
export_accumulator_entity.localised_name = "Export accumulator"
export_accumulator_entity.localised_description = "Export accumulator"
export_accumulator_entity.icon = "__graftorio3__/graphics/icons/export-accumulator-icon.png"
export_accumulator_entity.minable.result = Constants.export_accumulator_name
export_accumulator_entity.energy_source = {
    type = "electric",
    buffer_capacity = "5MJ",
    input_priority = "secondary",
    usage_priority = "secondary-input",
    input_flow_limit = "300kW",
    output_flow_limit = "0W",
}
export_accumulator_entity.picture.layers[1].filename = '__graftorio3__/graphics/entity/export-accumulator/export-accumulator.png'
export_accumulator_entity.picture.layers[1].hr_version.filename = '__graftorio3__/graphics/entity/export-accumulator/hr-export-accumulator.png'
data:extend{export_accumulator_entity}

local import_accumulator_entity = table.deepcopy(data.raw["accumulator"]["accumulator"])
import_accumulator_entity.name = Constants.import_accumulator_name
import_accumulator_entity.type = 'generator'
import_accumulator_entity.localised_name = "Import accumulator"
import_accumulator_entity.localised_description = "Import accumulator"
import_accumulator_entity.icon = "__graftorio3__/graphics/icons/import-accumulator-icon.png"
import_accumulator_entity.minable.result = Constants.import_accumulator_name
import_accumulator_entity.energy_source =
{
    type = "electric",
    buffer_capacity = "5MJ",
    usage_priority = "secondary-output",
    input_flow_limit = "0W",
    output_flow_limit = "300kW",
}
import_accumulator_entity.fluid_box = {
    pipe_connections = {}
}
import_accumulator_entity.fluid_usage_per_tick = 0
import_accumulator_entity.maximum_temperature = 500
import_accumulator_entity.max_power_output = "300kW"
import_accumulator_entity.burns_fluid = false
import_accumulator_entity.picture.layers[1].filename = '__graftorio3__/graphics/entity/import-accumulator/import-accumulator.png'
import_accumulator_entity.picture.layers[1].hr_version.filename = '__graftorio3__/graphics/entity/import-accumulator/hr-import-accumulator.png'
import_accumulator_entity.horizontal_animation = import_accumulator_entity.picture
import_accumulator_entity.vertical_animation = import_accumulator_entity.picture
data:extend{import_accumulator_entity}
