require("__graftorio3__/scripts/constants")

local ConnectRuntime = {}

function ConnectRuntime.init()
    global.connect_combinators = {}
end

function ConnectRuntime.add_combinator(event)
    if event.created_entity.name ~= Constants.combinator_name then
        return
    end

    local entity = event.created_entity

    script.register_on_entity_destroyed(entity)

    local output_entity = assert(
        entity.surface.create_entity {
            name = Constants.combinator_output_name,
            position = entity.position,
            force = entity.force,
            fast_replace = false,
            raise_built = false,
            create_build_effect_smoke = false,
        },
        "Failed to create output entity"
    )

    local control_behavior = assert(output_entity.get_or_create_control_behavior(),
        "Failed to get/create control behavior")

    entity.connect_neighbour {
        wire = defines.wire_type.red,
        target_entity = output_entity,
        source_circuit_id = defines.circuit_connector_id.combinator_output,
    }

    entity.connect_neighbour {
        wire = defines.wire_type.green,
        target_entity = output_entity,
        source_circuit_id = defines.circuit_connector_id.combinator_output,
    }

    local selector = {
        input_entity = entity,
        output_entity = output_entity,
        control_behavior = control_behavior,
        key = "",
    }

    global.connect_combinators[entity.unit_number] = selector

    selector.control_behavior.parameters = nil
end

function ConnectRuntime.remove_combinator(unit_number)
    local selector = global.connect_combinators[unit_number]

    if not selector then
        return
    end

    global.connect_combinators[unit_number] = nil

    if selector and selector.output_entity then
        selector.output_entity.destroy()
    end
end

return ConnectRuntime
