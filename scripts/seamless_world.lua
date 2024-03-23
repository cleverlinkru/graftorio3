local SeamlessWorld = {}

function SeamlessWorld.on_init()
    callback = function(event)
        local surface = event.surface

        if surface.name ~= "nauvis" then
            return
        end

        local sourceSurface = game.get_surface("nauvis-source")

        if not sourceSurface then
            local settings = surface.map_gen_settings
            settings.width = 0
            settings.height = 0
            sourceSurface = game.create_surface("nauvis-source", settings)
        end

        local shift_x = settings.global["graftorio3-shift-x"].value
        local shift_y = settings.global["graftorio3-shift-y"].value

        local map_w = surface.map_gen_settings.width
        local map_h = surface.map_gen_settings.height
        local chunk_x1 = event.area.left_top.x
        local chunk_y1 = event.area.left_top.y
        local chunk_x2 = event.area.right_bottom.x
        local chunk_y2 = event.area.right_bottom.y

        local x_min = -map_w / 2
        local y_min = -map_h / 2
        local x_max = map_w / 2
        local y_max = map_h / 2

        local dest_x1 = chunk_x1
        local dest_y1 = chunk_y1
        local dest_x2 = chunk_x2
        local dest_y2 = chunk_y2
        if dest_x1 < x_min then
            dest_x1 = x_min
        end
        if dest_y1 < y_min then
            dest_y1 = y_min
        end
        if dest_x2 > x_max then
            dest_x2 = x_max
        end
        if dest_y2 > y_max then
            dest_y2 = y_max
        end

        local source_x1 = dest_x1 + map_w * shift_x
        local source_y1 = dest_y1 + map_h * shift_y
        local source_x2 = dest_x2 + map_w * shift_x
        local source_y2 = dest_y2 + map_h * shift_y

        sourceSurface.request_to_generate_chunks({source_x1, source_y1})
        sourceSurface.request_to_generate_chunks({source_x1, source_y2})
        sourceSurface.request_to_generate_chunks({source_x2, source_y1})
        sourceSurface.request_to_generate_chunks({source_x2, source_y2})
        sourceSurface.force_generate_chunk_requests()

        sourceSurface.clone_area({
            source_area = {{source_x1, source_y1}, {source_x2, source_y2}},
            destination_area = {{dest_x1, dest_y1}, {dest_x2, dest_y2}},
            destination_surface = "nauvis"
        })
    end

    script.on_event(defines.events.on_chunk_generated, callback)

    global.export_chests = {}
    global.import_chests = {}
    global.export_pipes = {}
    global.import_pipes = {}
    global.export_accumulators = {}
    global.import_accumulators = {}
    global.transfer_leaks = {}
end

function SeamlessWorld.on_added_entity(created_entity)
    if created_entity.name == Constants.export_chest_name then
        script.register_on_entity_destroyed(created_entity)
        global.export_chests[created_entity.unit_number] = created_entity
    end

    if created_entity.name == Constants.import_chest_name then
        script.register_on_entity_destroyed(created_entity)
        global.import_chests[created_entity.unit_number] = created_entity
    end

    if created_entity.name == Constants.export_pipe_name then
        script.register_on_entity_destroyed(created_entity)
        global.export_pipes[created_entity.unit_number] = created_entity
    end

    if created_entity.name == Constants.import_pipe_name then
        script.register_on_entity_destroyed(created_entity)
        global.import_pipes[created_entity.unit_number] = created_entity
    end

    if created_entity.name == Constants.export_accumulator_name then
        script.register_on_entity_destroyed(created_entity)
        global.export_accumulators[created_entity.unit_number] = created_entity
    end

    if created_entity.name == Constants.import_accumulator_name then
        script.register_on_entity_destroyed(created_entity)
        global.import_accumulators[created_entity.unit_number] = created_entity
    end
end

function SeamlessWorld.on_destroyed_entity(unit_number)
    local export_chest_entity = global.export_chests[unit_number]
    if export_chest_entity then
        global.export_chests[unit_number] = nil
    end

    local import_chest_entity = global.import_chests[unit_number]
    if import_chest_entity then
        global.import_chests[unit_number] = nil
    end

    local export_pipe_entity = global.export_pipes[unit_number]
    if export_pipe_entity then
        global.export_pipes[unit_number] = nil
    end

    local import_pipe_entity = global.import_pipes[unit_number]
    if import_pipe_entity then
        global.import_pipes[unit_number] = nil
    end

    local export_accumulator_entity = global.export_accumulators[unit_number]
    if export_accumulator_entity then
        global.export_accumulators[unit_number] = nil
    end

    local import_accumulator_entity = global.import_accumulators[unit_number]
    if import_accumulator_entity then
        global.import_accumulators[unit_number] = nil
    end
end

function checkLeaks(posX, posY, oldContents, newContents, insertedKey, insertedVal)
    local oldContKey = ''
    local oldContVal = 0
    for key,val in pairs(oldContents) do
        oldContKey = key
        oldContVal = val
    end

    local newContKey = ''
    local newContVal = 0
    for key,val in pairs(newContents) do
        newContKey = key
        newContVal = val
    end

    if oldContKey == insertedKey then
        local realInserted = newContVal - oldContVal
        if realInserted < insertedVal then
            registerLeak(posX, posY, insertedKey, insertedVal - realInserted)
        end
    else
        if oldContKey ~= '' and oldContKey ~= nil then
            registerLeak(posX, posY, insertedKey, insertedVal)
        end
    end
end

function registerLeak(posX, posY, key, count)
    local index = posX..','..posY..','..key
    if global.transfer_leaks[index] == nil then
        global.transfer_leaks[index] = {
            posX = posX,
            posY = posY,
            key = key,
            count = 0,
        }
    end
    global.transfer_leaks[index].count = global.transfer_leaks[index].count + count
end

commands.add_command("seamless_world_export", nil, function(command)
    local surface = game.get_surface("nauvis")
    local shift_x = settings.global["graftorio3-shift-x"].value
    local shift_y = settings.global["graftorio3-shift-y"].value
    local map_w = surface.map_gen_settings.width
    local map_h = surface.map_gen_settings.height
    rcon.print(shift_x..','..shift_y..','..map_w..','..map_h)

    if global.export_chests then
        for _,export_chest_entity in pairs(global.export_chests) do
            local inventory = export_chest_entity.get_inventory(defines.inventory.chest)
            if not inventory.is_empty() then
                rcon.print('export-chest')
                rcon.print(math.floor(export_chest_entity.position.x)..','..math.floor(export_chest_entity.position.y))

                for key,count in pairs(inventory.get_contents()) do
                    rcon.print(key..','..count)
                end

                inventory.clear()
            end
        end
    end

    if global.import_chests then
        for _,import_chest_entity in pairs(global.import_chests) do
            rcon.print('import-chest')
            rcon.print(math.floor(import_chest_entity.position.x)..','..math.floor(import_chest_entity.position.y))
            rcon.print(',')
        end
    end

    if global.export_pipes then
        for _,export_pipe_entity in pairs(global.export_pipes) do
            if export_pipe_entity.get_fluid_count() ~= 0 then
                rcon.print('export-pipe')
                rcon.print(math.floor(export_pipe_entity.position.x)..','..math.floor(export_pipe_entity.position.y))

                for key,count in pairs(export_pipe_entity.get_fluid_contents()) do
                    rcon.print(key..','..count)
                end

                export_pipe_entity.clear_fluid_inside()
            end
        end
    end

    if global.import_pipes then
        for _,import_pipe_entity in pairs(global.import_pipes) do
            rcon.print('import-pipe')
            rcon.print(math.floor(import_pipe_entity.position.x)..','..math.floor(import_pipe_entity.position.y))
            rcon.print(',')
        end
    end

    if global.export_accumulators then
        for _,export_accumulator_entity in pairs(global.export_accumulators) do
            if export_accumulator_entity.energy ~= 0 then
                rcon.print('export-accumulator')
                rcon.print(math.floor(export_accumulator_entity.position.x)..','..math.floor(export_accumulator_entity.position.y))
                rcon.print(','..export_accumulator_entity.energy)

                export_accumulator_entity.energy = 0
            end
        end
    end

    if global.import_accumulators then
        for _,import_accumulator_entity in pairs(global.import_accumulators) do
            rcon.print('import-accumulator')
            rcon.print(math.floor(import_accumulator_entity.position.x)..','..math.floor(import_accumulator_entity.position.y))
            rcon.print(',')
        end
    end
end)

commands.add_command("seamless_world_import", nil, function(command)
    local param = command.parameter
    local data = {}
    param = param .. ","
    local from = 1
    for i = 1, #param do
        if string.sub(param, i, i) == ',' then
            data[#data+1] = string.sub(param, from, i-1)
            from = i + 1
        end
    end

    local i = 0
    while i < #data do
        i = i + 1

        local type = data[i]
        local posX = tonumber(data[i + 1])
        local posY = tonumber(data[i + 2])
        local name = data[i + 3]
        local count = tonumber(data[i + 4])
        i = i + 4

        if type == 'import-chest' then
            if global.import_chests then
                for _,import_chest_entity in pairs(global.import_chests) do
                    local entPosX = math.floor(import_chest_entity.position.x)
                    local entPosY = math.floor(import_chest_entity.position.y)
                    if (entPosX == posX) and (entPosY == posY) then
                        local inventory = import_chest_entity.get_inventory(defines.inventory.chest)
                        local oldChestContents = inventory.get_contents()
                        inventory.insert({name=name, count=count})
                        local newChestContents = inventory.get_contents()
                        checkLeaks(entPosX, entPosY, oldChestContents, newChestContents, name, count)
                    end
                end
            end
        end

        if type == 'import-pipe' then
            if global.import_pipes then
                for _,import_pipe_entity in pairs(global.import_pipes) do
                    local entPosX = math.floor(import_pipe_entity.position.x)
                    local entPosY = math.floor(import_pipe_entity.position.y)
                    if (entPosX == posX) and (entPosY == posY) then
                        local oldPipeContents = import_pipe_entity.get_fluid_contents()
                        import_pipe_entity.insert_fluid({name=name, amount=count})
                        local newPipeContents = import_pipe_entity.get_fluid_contents()
                        checkLeaks(entPosX, entPosY, oldPipeContents, newPipeContents, name, count)
                    end
                end
            end
        end

        if type == 'import-accumulator' then
            if global.import_accumulators then
                for _,import_accumulator_entity in pairs(global.import_accumulators) do
                    local entPosX = math.floor(import_accumulator_entity.position.x)
                    local entPosY = math.floor(import_accumulator_entity.position.y)
                    if (entPosX == posX) and (entPosY == posY) then
                        local oldAccContents = { energy = import_accumulator_entity.energy }
                        import_accumulator_entity.energy = import_accumulator_entity.energy + count
                        local newAccContents = { energy = import_accumulator_entity.energy }
                        checkLeaks(entPosX, entPosY, oldAccContents, newAccContents, 'energy', count)
                    end
                end
            end
        end
    end
end)

return SeamlessWorld
