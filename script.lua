local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local player = game.Players.LocalPlayer

local Window = OrionLib:MakeWindow({Name = "Uran Hub", HidePremium = false, SaveConfig = true})

function correctKeyNotification()
    OrionLib:MakeNotification({
        Name = "Correct key",
        Content = "You are logged in as "..player.Name.."",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

function incorrectKeyNotification()
    OrionLib:MakeNotification({
        Name = "Incorrect key",
        Content = "You entered the wrong key!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

_G.key = "cgpv"
_G.keyinput = "string"
_G.playerToGoto = "string"

function makeScriptHub()
    local playerTab = Window:MakeTab({
        Name = "Player",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    playerTab:AddToggle({   
        Name = "Noclip",
	    Default = false,
	    Callback = function(Value)
            if Value == true then
                player.Character.Humanoid:ChangeState(11)
            end
        end
    })
    playerTab:AddToggle({   
        Name = "God",
	    Default = false,
        Callback = function(Value)
            local normalstate = player.Character.Humanoid:GetState()
            if Value == true then
                if player.Character then
                    player.Character.Humanoid.Name = "1"
                    local l = player.Character["1"]:Clone()
 
                    l.Parent = player.Character
                    
                    l.Name = "Humanoid"; wait(0.1)
                    
                    player.Character["1"]:Destroy()
                    
                    workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
                    
                    player.Character.Animate.Disabled = true; wait(0.1)
                    
                    player.Character.Animate.Disabled = false
                end
            else
                player.Character.Humanoid:ChangeState(normalstate)
            end
        end
    })
    playerTab:AddTextbox({
        Name = "Teleport to a player",
        Default = "",
        TextDisappear = false,
        Callback = function(Value)
            _G.playerToGoto = Value
        end	  
    })
    playerTab:AddButton({
        Name = "Teleport to entered player",
        Callback = function()
            local tp_namedplayer = _G.playerToGoto
            local tp_player = game:GetService("Players")[tp_namedplayer]
            local PLR = game:GetService("Players").LocalPlayer
         
            if tp_player then
                for i = 1,1 do
                    wait(.08)
                    PLR.Character.HumanoidRootPart.CFrame = tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
                end
            end
        end
    })
end

local Tab = Window:MakeTab({
	Name = "Key",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddTextbox({
	Name = "Enter key",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		_G.keyinput = Value
	end	  
})

Tab:AddButton({
	Name = "Check key",
	Callback = function()
      	if _G.keyinput == _G.key then
            makeScriptHub()
            correctKeyNotification()
        else
            incorrectKeyNotification()
        end
  	end    
})
