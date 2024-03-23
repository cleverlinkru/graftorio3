require("__graftorio3__/scripts/constants")
ConnectRuntime = require("connect_runtime")
ConnectGui = require("connect_gui")
ConnectImport = require("connect_import")

local ConnectCombinator = {}

local selector_filter = {
    filter = "name",
    name = Constants.combinator_name,
}

function ConnectCombinator.on_init()
    ConnectRuntime.init()
end

function ConnectCombinator.on_added(event)
    ConnectRuntime.add_combinator(event)
end

function ConnectCombinator.on_entity_destroyed(event)
    ConnectRuntime.remove_combinator(event.entity.unit_number)
end

function ConnectCombinator.on_destroyed(event)
    ConnectRuntime.remove_combinator(event.unit_number)
end

function ConnectCombinator.on_gui_opened(event)
    local entity = event.entity

    if not entity or not entity.valid or entity.name ~= Constants.combinator_name then
        return
    end

    local player = game.get_player(event.player_index)

    if player then
        ConnectGui.on_gui_added(player, entity)
    end
end

function ConnectCombinator.on_gui_closed(event)
    local element = event.element

    if not element or element.name ~= "connect_gui" then
        return
    end

    local player = game.get_player(event.player_index)

    if player then
        ConnectGui.on_gui_removed(player)
    end
end

ConnectGui.bind_all_events()

commands.add_command("connect_combinator_import", nil, function(command)
    ConnectImport.run(command)
end)

return ConnectCombinator
