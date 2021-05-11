--[[

	Lua Phase Calculator
		Made with @Shaar-games & @iThorgrim-Hub

]]--
local intbin = {
    ["0"] = "000",
    ["1"] = "001",
    ["2"] = "010",
    ["3"] = "011",
    ["4"] = "100",
    ["5"] = "101",
    ["6"] = "110",
    ["7"] = "111"
}

function IntToBin(int)
    local str = string.gsub(string.format("%o", int), "(.)", function(d) return intbin[d] end)

    return str
end

function onHello()
    io.write('________Main Menu Phase Calculator________\n\n')
    io.write('1 - Joint Phase\n')
    io.write('2 - Negative Phase\n')
    io.write('3 - Phase Compatibility\n')
    io.write('4 - List unique phase\n')
    onSelect(tonumber(io.read()))
end

function onSelect(intid)
    local Case = {
        [1] = function()
            io.write('Enter your phase :')
            local int = io.read()
            io.write('Enter maximum phase :\n(Default is maximum phase of World of Warcraft (4 294 967 294))\n')
            local scope = io.read()
            JointPhase(assert(int, 'Please enter a valid number'), scope)
        end,
        [2] = function()
            io.write('Enter your phase :')
            local int = io.read()
            io.write('Enter maximum phase \n : Default is maximum phase of World of Warcraft (4 294 967 294)\n')
            local scope = io.read()
            NegativePhase(assert(int, 'Please enter a valid number'), scope)
        end,
        [3] = function()
            io.write('Enter your first phase :\n')
            local phase_1 = io.read()
            io.write('Enter your second phase :\n')
            local phase_2 = io.read()
            PhaseCompatibility(phase_1, phase_2)
        end,
        [4] = function()
            GenerateUniquePhase()
        end,
    }

    if (intid == nil or intid > #Case or intid == 0) then
        onHello()
    else
        Case[intid]()
    end
end

function PhaseCompatibility(phase_1, phase_2)
    local binphase_1 = tostring(tonumber(IntToBin(phase_1)))
    local binphase_2 = tostring(tonumber(IntToBin(phase_2)))

    if string.sub(binphase_2, -string.len(binphase_1)) == binphase_1 then
        io.write(phase_1 .. ' is compatible with ' .. phase_2)
    else
        io.write(phase_1 .. ' is not compatible with ' .. phase_2)
    end

    io.write('\n\n')
    onHello()
end

function GenerateUniquePhase()
    local file = io.open('uniques_phase.txt', "w+")

    for i = 0, 32 do
        i = 2 ^ i
        file:write(" " .. i .. "\n")
    end

    io.close(file)
end

function NegativePhase(int, scope)
    int = tonumber(int)
    scope = tonumber(scope)

    if not scope or scope <= 0 then
        scope = 4294967294
    end

    if type(int) ~= "number" or int <= 0 or int > 2 ^ 32 then
        --
        error('Please enter a valid number', 1)

        return
    end

    local search = tostring(tonumber(IntToBin(int)))
    local file = io.open("NegativePhase" .. int .. ".txt", "w+")
    file:write("\t" .. int .. "\n")

    for i = 0, scope do
        local str = tostring(IntToBin(i))
        io.write("\rRemaining values " .. scope - i)

        if not (string.sub(str, -string.len(search)) == search) then
            file:write("Decimal : " .. i .. ",\t Binary:" .. str .. "\n")
        end
    end

    io.close(file)
end

function JointPhase(int, scope)
    int = tonumber(int)
    scope = tonumber(scope)

    if not scope or scope <= 0 then
        scope = 4294967294
    end

    if type(int) ~= "number" or int <= 0 or int > 2 ^ 32 then
        --
        error('Please enter a valid number', 1)

        return
    end

    local search = tostring(tonumber(IntToBin(int)))
    local file = io.open("JointPhases" .. int .. ".txt", "w+")
    file:write("\t" .. int .. "\n")

    for i = 0, scope do
        local str = tostring(IntToBin(i))
        io.write("\rRemaining values " .. scope - i)

        if string.sub(str, -string.len(search)) == search then
            file:write("Decimal : " .. i .. ",\t Binary:" .. str .. "\n")
        end
    end

    io.close(file)
end

onHello()
