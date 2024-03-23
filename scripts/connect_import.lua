local ConnectImport = {}

function ConnectImport.run(command)
    local param = command.parameter
    local data = {}
    param = param .. ","
    local from = 1
    for i = 1, #param do
        if string.sub(param, i, i) == ',' then
            data[#data+1] = string.sub(param, from, i-1)
            from = i+1
        end
    end

    local combinator_key = data[1]
    local signal_type = data[2]
    local signal_name = data[3]
    local count = data[4]

    for _,selector in pairs(global.connect_combinators) do
        if selector.key == combinator_key then
            selector.control_behavior.parameters = { {
                signal = {
                    type = signal_type,
                    name = signal_name
                },
                count = count,
                index = 1
            } }
        end
    end
end

return ConnectImport
