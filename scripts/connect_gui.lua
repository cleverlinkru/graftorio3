local ConnectGui = {}

local function find_connect_entry_by_unit_number(unit_number)
    return global.connect_combinators[unit_number]
end

local function find_connect_entry_by_gui_element(gui)
    local unit_number = gui.tags.unit_number
    if not unit_number or type(unit_number) ~= "number" then
        return
    end

    return global.connect_combinators[unit_number]
end

local function write_text_boxes(entry, gui)
    local key_textfield = gui.inner_frame.options_flow.control_flow.key_textfield

    key_textfield.text = entry.key or ""
end

function ConnectGui.on_gui_added(player, entity)
    local screen = player.gui.screen

    if screen.connect_gui then
        screen.connect_gui.destroy()
    end

    local gui = screen.add {
        type = "frame",
        name = "connect_gui",
        direction = "vertical",

        tags = {
            unit_number = entity.unit_number,
        }
    }

    local title_bar = gui.add {
        type = "flow",
        name = "title_bar",
        direction = "horizontal",
    }

    title_bar.drag_target = gui

    title_bar.add {
        type = "label",
        name = "title",
        style = "frame_title",
        ignored_by_interaction = true,
        caption = "Connect combinator",
    }

    title_bar.add {
        type = "empty-widget",
        name = "drag_handle",
        ignored_by_interaction = true,
        style = "flib_titlebar_drag_handle",
    }

    title_bar.add {
        type = "sprite-button",
        name = "close_button",
        style = "frame_action_button",
        sprite = "utility/close_white",
        hovered_sprite = "utility/close_black",
    }

    local inner_frame = gui.add {
        type = "frame",
        name = "inner_frame",
        direction = "vertical",
        style = "inside_shallow_frame_with_padding",
    }

    inner_frame.style.padding = 12
    inner_frame.style.bottom_padding = 9

    local options_flow = inner_frame.add {
        type = "flow",
        name = "options_flow",
        direction = "vertical",
    }

    options_flow.style.horizontal_align = "left"

    local control_flow = options_flow.add {
        type = "flow",
        name = "control_flow",
        direction = "vertical",
    }

    local key_textfield = control_flow.add {
        type = "textfield",
        name = "key_textfield",
        clear_and_focus_on_right_click = true,
    }

    local entry = find_connect_entry_by_unit_number(entity.unit_number)
    if entry then
        write_text_boxes(entry, gui)
    end

    player.opened = gui
    gui.force_auto_center()
end

function ConnectGui.on_gui_removed(player)
    local screen = player.gui.screen

    local gui = screen.connect_gui

    if gui then
        gui.destroy()
    else
        player.test = player.test2
    end
end

function ConnectGui.bind_all_events()
    script.on_event(defines.events.on_gui_click, function(eventData)
        local element = eventData.element

        local player = game.get_player(eventData.player_index)

        if not player then
            return
        end

        if element.name == "close_button" then
            ConnectGui.on_gui_removed(player)
        end
    end)

    script.on_event(defines.events.on_gui_text_changed, function(eventData)
        local player = game.get_player(eventData.player_index)

        if not player then
            return
        end

        local gui = player.gui.screen.connect_gui

        if not gui then
            return
        end

        local selector_entry = find_connect_entry_by_gui_element(gui)

        if not selector_entry then
            return
        end

        local key_textfield = gui.inner_frame.options_flow.control_flow.key_textfield

        if eventData.element == key_textfield then
            selector_entry.key = eventData.element.text
        end
    end)
end

return ConnectGui
