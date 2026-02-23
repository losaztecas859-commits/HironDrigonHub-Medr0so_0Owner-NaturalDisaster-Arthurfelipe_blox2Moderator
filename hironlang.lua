--// HironLang v1
local Hiron = {}
Hiron.__index = Hiron

local player = game.Players.LocalPlayer

-- =========================
-- UTIL
-- =========================

local function split(str)
    local t = {}
    for word in string.gmatch(str, "[^%.]+") do
        table.insert(t, word)
    end
    return t
end

-- =========================
-- CREATE
-- =========================

function Hiron:create(args)
    
    if args[1] == "part" then
        
        local p = Instance.new("Part")
        p.Anchored = true
        p.Parent = workspace
        
        for i,v in ipairs(args) do
            
            if v == "size" then
                p.Size = Vector3.new(
                    tonumber(args[i+1]),
                    tonumber(args[i+2]),
                    tonumber(args[i+3])
                )
            end
            
            if v == "pos" then
                p.Position = Vector3.new(
                    tonumber(args[i+1]),
                    tonumber(args[i+2]),
                    tonumber(args[i+3])
                )
            end
            
            if v == "color" then
                local c = args[i+1]
                
                if c == "red" then
                    p.Color = Color3.fromRGB(255,0,0)
                elseif c == "blue" then
                    p.Color = Color3.fromRGB(0,0,255)
                elseif c == "green" then
                    p.Color = Color3.fromRGB(0,255,0)
                end
            end
        end
        
    elseif args[1] == "message" then
        
        local msg = table.concat(args, " ", 2)
        warn("[HIRON MESSAGE]: "..msg)
        
    end
end

-- =========================
-- PLAYER
-- =========================

function Hiron:player(args)
    
    if args[1] == "walkspeed" and args[2] == "set" then
        player.Character:WaitForChild("Humanoid").WalkSpeed = tonumber(args[3])
    end
    
    if args[1] == "jumppower" and args[2] == "set" then
        player.Character:WaitForChild("Humanoid").JumpPower = tonumber(args[3])
    end
    
end

-- =========================
-- MAIN RUN
-- =========================

function Hiron:run(command)
    
    local args = split(command)
    local main = args[1]
    table.remove(args, 1)
    
    if self[main] then
        self[main](self, args)
    else
        warn("Comando inválido: "..main)
    end
    
end

return setmetatable({}, Hiron)