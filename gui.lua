--[[
    Be a speedster for script to work
    
    Made by fireztron at @v3rm
    
]]
repeat wait() until game:IsLoaded()

--// For Non-Synapse Users (credits to egg salad)
if not pcall(function() return syn.protect_gui end) then
    syn = {}
    syn.protect_gui = function(egg)
        egg.Parent = game.CoreGui
    end
end

--// lib stuff uwuware i think
local lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/fireztron/uwuware-ui-library/main/ui.lua', true))()
local window = lib:CreateWindow('The Flash: Project... GUI')
window:AddLabel({text = "fireztron @ v3rmillion"})
--// auto attack UI
window:AddToggle({text = 'Kill aura', state = autoattack, callback = function(v) 
    autoattack = v; 
end})
--// godmode UI
window:AddToggle({text = 'Graball', state = graball, callback = function(v) 
    graball = v; 
end})

--// Init library
lib:Init()

--// ESSENTIAL VARS
local RS = game:GetService("RunService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local humanoids = {}

--// GET HUMS TABLE
local function getHums()
    local hums = {}
    for _, plr in pairs(Players:GetPlayers()) do
        local char = plr.Character
        if plr ~= LP and char then
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hum then
                table.insert(hums, hum)
            end
        end
    end
    return hums
end

--// LOOP
coroutine.wrap(function() --apparently coroutine's better
    while true do
        for _,hum in ipairs(getHums()) do
            local LPChar = LP.Character
            if hum.Parent and LPChar then
                local enemyhrp = hum.Parent:FindFirstChild("HumanoidRootPart")
                local hrp = LPChar:FindFirstChild("HumanoidRootPart")
                if enemyhrp and hrp then --(enemyhrp.Position - hrp.Position).Magnitude < 15 then
                    local speedsterScript = LPChar:FindFirstChild("Speedster")
                    if speedsterScript then
                        local remote = speedsterScript:FindFirstChild("Remote")
                        if remote then
                            if autoattack then
                                --// Weak punch
                                local args = {
                                    [1] = "Hit",
                                    [2] = enemyhrp,
                                    [3] = "single"
                                }

                                remote:FireServer(unpack(args))

                                --// Strong punch
                                local args = {
                                    [1] = "Hit",
                                    [2] = enemyhrp,
                                    [3] = "double"
                                }

                                remote:FireServer(unpack(args))
                            end
                            if graball then
                                --// Grab
                                local args = {
                                    [1] = "Grab",
                                    [2] = enemyhrp.Parent
                                }
                                remote:FireServer(unpack(args))
                            end
                        end
                    end
                end
            end
        end
        RS.Heartbeat:Wait()
    end
end)()

warn("loaded thingy")
