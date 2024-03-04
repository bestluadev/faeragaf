if game.PlaceId == 2788229376 then
    game.Loaded:Wait()
    local bb=game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
        bb:CaptureController()bb:ClickButton2(Vector2.new())
    
        local ScreenGui = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local TextLabel = Instance.new("TextLabel")
        local TextLabel_2 = Instance.new("TextLabel")
        
        --Properties:
        
        
        
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        
        Frame.Parent = ScreenGui
        Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
        Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Frame.BorderSizePixel = 0
        Frame.Position = UDim2.new(-0.346668959, 0, -0.214874744, 0)
        Frame.Size = UDim2.new(0, 2703, 0, 1705)
        
        TextLabel.Parent = ScreenGui
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel.BorderSizePixel = 0
        TextLabel.Position = UDim2.new(0.0923842415, 0, 0.385629267, 0)
        TextLabel.Size = UDim2.new(0.756897628, 0, 0.0759672374, 0)
        TextLabel.Font = Enum.Font.SourceSansBold
        TextLabel.Text = "WELCOME BACK TO HEVELEX CONTROL"
        TextLabel.TextColor3 = Color3.fromRGB(255, 251, 251)
        TextLabel.TextSize = 33.000
        TextLabel.TextWrapped = true
        
        TextLabel_2.Parent = ScreenGui
        TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.BackgroundTransparency = 1.000
        TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel_2.BorderSizePixel = 0
        TextLabel_2.Position = UDim2.new(0.0923842639, 0, 0.500361979, 0)
        TextLabel_2.Size = UDim2.new(0.756897628, 0, 0.0759672374, 0)
        TextLabel_2.Font = Enum.Font.SourceSansBold
        TextLabel_2.Text = "| "..game.Players.LocalPlayer.Name .. " / ".. game.Players.LocalPlayer.DisplayName .. " |"
        TextLabel_2.TextColor3 = Color3.fromRGB(255, 251, 251)
        TextLabel_2.TextSize = 33.000
        TextLabel_2.TextWrapped = true
    
        getgenv().adverting = false
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    
         -------------------- DELETE CHAIRS ------------------------------
      
      for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Seat") or v:IsA("VehicleSeat") then
            v.Disabled = true
        end
    end

    game:GetService("ReplicatedStorage"):WaitForChild("ChargeButton"):FireServer(unpack(args))
    
        getgenv().isDropping = false
        local speed = 50
        local c
        local h
        local bv
        local bav
        local cam
        local flying
        local p = game.Players.LocalPlayer
        local buttons = {
            W = false,
            S = false,
            A = false,
            D = false,
            Moving = false
        }
    
        local function getMoneyAroundMe()
            wait(0.5)
            for i, money in ipairs(game.Workspace.Ignored.Drop:GetChildren()) do
                if money.Name == "MoneyDrop" and (money.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 20 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = money.CFrame
                    fireclickdetector(money.ClickDetector)
                    wait(0.5)
                end
            end
        end
    
        local startFly = function()
            if not p.Character or not p.Character.Head or flying then
                return
            end
            c = p.Character
            h = c.Humanoid
            h.PlatformStand = true
            cam = workspace:WaitForChild('Camera')
            bv = Instance.new("BodyVelocity")
            bav = Instance.new("BodyAngularVelocity")
            bv.Velocity, bv.MaxForce, bv.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
            bav.AngularVelocity, bav.MaxTorque, bav.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
            bv.Parent = c.Head
            bav.Parent = c.Head
            flying = true
            h.Died:connect(function()
                flying = false
            end)
        end
    
        local Players = game:GetService('Players')
    
        local endFly = function()
            if not p.Character or not flying then
                return
            end
            h.PlatformStand = false
            bv:Destroy()
            bav:Destroy()
            flying = false
        end
    
        game:GetService("UserInputService").InputBegan:connect(function(input, GPE)
            if GPE then
                return
            end
            for i, e in pairs(buttons) do
                if i ~= "Moving" and input.KeyCode == Enum.KeyCode[i] then
                    buttons[i] = true
                    buttons.Moving = true
                end
            end
        end)
    
        game:GetService("UserInputService").InputEnded:connect(function(input, GPE)
            if GPE then
                return
            end
            local a = false
            for i, e in pairs(buttons) do
                if i ~= "Moving" then
                    if input.KeyCode == Enum.KeyCode[i] then
                        buttons[i] = false
                    end
                    if buttons[i] then
                        a = true
                    end
                end
            end
            buttons.Moving = a
        end)
    
        local setVec = function(vec)
            return vec * (speed / vec.Magnitude)
        end
    
        game:GetService("RunService").Heartbeat:connect(function(step)
            if flying and c and c.PrimaryPart then
                local p = c.PrimaryPart.Position
                local cf = cam.CFrame
                local ax, ay, az = cf:toEulerAnglesXYZ()
                c:SetPrimaryPartCFrame(CFrame.new(p.x, p.y, p.z) * CFrame.Angles(ax, ay, az))
                if buttons.Moving then
                    local t = Vector3.new()
                    if buttons.W then
                        t = t + (setVec(cf.lookVector))
                    end
                    if buttons.S then
                        t = t - (setVec(cf.lookVector))
                    end
                    if buttons.A then
                        t = t - (setVec(cf.rightVector))
                    end
                    if buttons.D then
                        t = t + (setVec(cf.rightVector))
                    end
                    c:TranslateBy(t * step)
                end
            end
        end)
        Players.PlayerAdded:Connect(function(player)
            game.StarterGui:SetCore("SendNotification", {
                Title = "Someone joined!",
                Text = player.name .. " joined the game.",
                Duration = 5
            })
        end)
    
        local function PlayerAdded(Player)
            local function Chatted(Message)
                local plr = game.Players.LocalPlayer
                local character = plr.Character or plr.CharacterAdded:Wait()
                local humanoid = character:FindFirstChild("Humanoid")
                local PlayerHumanoid = plr.Character:WaitForChild("Humanoid")
                local targetHumanoid = Player.Character:WaitForChild("Humanoid")
                local LastTargetPosition = targetHumanoid.RootPart.CFrame
                local Length = 3
    
                if Player.UserId == getgenv().controller then
    
                    local finalMsg = Message:lower()
    
                    for i, v in pairs(getgenv().alts) do
                        if v == plr.UserId then
                            if finalMsg == getgenv().prefix .. "ffsvjfvsjjvsgsdfv^^_^^ " .. plr.Name:lower() then
                                startFly()
    
                            end
                            if finalMsg == getgenv().prefix .. "snrtsnnsfrqfsfuvsgsvds^" then
                                startFly()
    
                            end
    
                            if finalMsg == getgenv().prefix .. "say" then
                                local var = string.sub(msg,space+1)
                                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(string.sub(msg,space+1), "All")
                            end    
    
                
    
    
                            if finalMsg == getgenv().prefix .. "delcash " .. plr.Name:lower() then
                                getMoneyAroundMe()
                            end
    
                            if finalMsg == getgenv().prefix .. "delcash" then
                                getMoneyAroundMe()
                            end
    
    
                            if finalMsg == getgenv().prefix .. "setup train" then
                                game.Players.LocalPlayer.Character.Head.Anchored = false
                                for i, v in pairs(getgenv().alts) do
                                    if i == "Alt1" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(602.509, 48.15, -97.112)
                                        end
                                    end
                                    if i == "Alt2" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(606.752, 48.15, -101.354)
                                        end
                                    end
                                    if i == "Alt3" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(610.641, 48.15, -105.244)
                                        end
                                    end
                                    if i == "Alt4" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(614.883, 48.15, -109.486)
                                        end
                                    end
                                    if i == "Alt5" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(608.166, 48.15, -91.455)
                                        end
                                    end
                                    if i == "Alt6" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(612.408, 48.15, -95.698)
                                        end
                                    end
                                    if i == "Alt7" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(616.297, 48.15, -99.587)
                                        end
                                    end
                                    if i == "Alt8" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(620.54, 48.15, -103.829)
                                        end
                                    end
                                    if i == "Alt9" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(613.823, 48.15, -85.798)
                                        end
                                    end
                                    if i == "Alt10" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(618.065, 48.15, -90.041)
                                        end
                                    end
                                    if i == "Alt11" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(621.954, 48.15, -93.93)
                                        end
                                    end
                                    if i == "Alt12" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(626.197, 48.15, -98.172)
                                        end
                                    end
                                    if i == "Alt13" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(619.48, 48.15, -80.141)
                                        end
                                    end
                                    if i == "Alt14" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(623.722, 48.15, -84.384)
                                        end
                                    end
                                    if i == "Alt15" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(627.611, 48.15, -88.273)
                                        end
                                    end
                                    if i == "Alt16" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(631.854, 48.15, -92.515)
                                        end
                                    end
                                    if i == "Alt17" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(625.136, 48.15, -74.485)
                                        end
                                    end
                                    if i == "Alt18" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(629.379, 48.15, -78.727)
                                        end
                                    end
                                    if i == "Alt19" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(633.268, 48.15, -82.616)
                                        end
                                    end
                                    if i == "Alt20" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(637.51, 48.15, -86.859)
                                        end
                                    end
                                    if i == "Alt21" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(630.793, 48.15, -68.828)
                                        end
                                    end
                                    if i == "Alt22" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(635.036, 48.15, -73.07)
                                        end
                                    end
                                    if i == "Alt23" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(638.925, 48.15, -76.959)
                                        end
                                    end
                                    if i == "Alt24" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(643.167, 48.15, -81.202)
                                        end
                                    end
                                    if i == "Alt25" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(636.45, 48.15, -63.171)
                                        end
                                    end
                                    if i == "Alt26" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(640.693, 48.15, -67.413)
                                        end
                                    end
                                    if i == "Alt27" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(644.582, 48.15, -71.303)
                                        end
                                    end
                                    if i == "Alt28" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(648.824, 48.15, -75.545)
                                        end
                                    end
                                    if i == "Alt29" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(642.107, 48.15, -57.514)
                                        end
                                    end
                                    if i == "Alt30" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(646.35, 48.15, -61.757)
                                        end
                                    end
                                    if i == "Alt31" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(650.239, 48.15, -65.646)
                                        end
                                    end
                                    if i == "Alt32" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(654.481, 48.15, -69.888)
                                        end
                                    end
                                    if i == "Alt33" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(645.995, 48, -51.75)
                                        end
                                    end
                                    if i == "Alt34" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(650.995, 48, -56.75)
                                        end
                                    end
                                    if i == "Alt35" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(655.495, 48, -61.25)
                                        end
                                    end
                                    if i == "Alt36" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(659.495, 48, -65.25)
                                        end
                                    end
                                    if i == "Alt37" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(651.745, 48.15, -46.5)
                                        end
                                    end
                                    if i == "Alt38" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(656.495, 48, -50.75)
                                        end
                                    end
                                end
                            end
    
                            if finalMsg == getgenv().prefix .. "setup topbank" then
                                game.Players.LocalPlayer.Character.Head.Anchored = false
                                for i, v in pairs(getgenv().alts) do
                                    if i == "Alt1" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-439.576, 38.985, -293.62)
                                        end
                                    end
                                    if i == "Alt2" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-439.576, 38.985, -287.62)
                                        end
                                    end
                                    if i == "Alt3" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-439.576, 38.985, -282.12)
                                        end
                                    end
                                    if i == "Alt4" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-439.576, 38.985, -276.12)
                                        end
                                    end
                                    if i == "Alt5" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-447.576, 39.006, -293.62)
                                        end
                                    end
                                    if i == "Alt6" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-447.576, 39.006, -287.62)
                                        end
                                    end
                                    if i == "Alt7" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-447.576, 39.006, -282.12)
                                        end
                                    end
                                    if i == "Alt8" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-447.576, 39.006, -276.12)
                                        end
                                    end
                                    if i == "Alt9" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-455.576, 39.028, -293.62)
                                        end
                                    end
                                    if i == "Alt10" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-455.576, 39.028, -287.62)
                                        end
                                    end
                                    if i == "Alt11" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-455.576, 39.028, -282.12)
                                        end
                                    end
                                    if i == "Alt12" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-455.576, 39.028, -276.12)
                                        end
                                    end
                                    if i == "Alt13" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-463.576, 39.049, -293.62)
                                        end
                                    end
                                    if i == "Alt14" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-463.576, 39.049, -287.62)
                                        end
                                    end
                                    if i == "Alt15" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-463.576, 39.049, -282.12)
                                        end
                                    end
                                    if i == "Alt16" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-463.576, 39.049, -276.12)
                                        end
                                    end
                                    if i == "Alt17" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-471.576, 39.071, -293.62)
                                        end
                                    end
                                    if i == "Alt18" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-471.576, 39.071, -287.62)
                                        end
                                    end
                                    if i == "Alt19" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-471.576, 39.071, -282.12)
                                        end
                                    end
                                    if i == "Alt20" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-471.576, 39.071, -276.12)
                                        end
                                    end
                                    if i == "Alt21" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-479.575, 39.092, -293.62)
                                        end
                                    end
                                    if i == "Alt22" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-479.576, 39.092, -287.62)
                                        end
                                    end
                                    if i == "Alt23" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-479.575, 39.092, -282.12)
                                        end
                                    end
                                    if i == "Alt24" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-479.575, 39.092, -276.12)
                                        end
                                    end
                                    if i == "Alt25" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-487.576, 39.113, -293.62)
                                        end
                                    end
                                    if i == "Alt26" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-487.576, 39.113, -287.62)
                                        end
                                    end
                                    if i == "Alt27" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-487.575, 39.113, -282.12)
                                        end
                                    end
                                    if i == "Alt28" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-487.576, 39.113, -276.12)
                                        end
                                    end
                                    if i == "Alt29" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-495.576, 39.135, -293.62)
                                        end
                                    end
                                    if i == "Alt30" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-495.576, 39.135, -287.62)
                                        end
                                    end
                                    if i == "Alt31" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-495.576, 39.135, -282.12)
                                        end
                                    end
                                    if i == "Alt32" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-495.576, 39.135, -276.12)
                                        end
                                    end
                                    if i == "Alt33" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-504.076, 39.159, -293.87)
                                        end
                                    end
                                    if i == "Alt34" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-504.076, 39.159, -287.87)
                                        end
                                    end
                                    if i == "Alt35" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-504.076, 39.159, -282.37)
                                        end
                                    end
                                    if i == "Alt36" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-504.076, 39.159, -276.37)
                                        end
                                    end
                                    if i == "Alt37" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-510.577, 39.176, -276.37)
                                        end
                                    end
                                    if i == "Alt38" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-510.577, 39.176, -282.37)
                                        end
                                    end
                                end
                            end
    
    
                            if finalMsg == getgenv().prefix .. "setup club" then
                                game.Players.LocalPlayer.Character.Head.Anchored = false
                                for i, v in pairs(getgenv().alts) do
                                    if i == "Alt1" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-273.592, -6.208, -404.911)
                                        end
                                    end
                                    if i == "Alt2" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-267.592, -6.208, -404.911)
                                        end
                                    end
                                    if i == "Alt3" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-262.092, -6.208, -404.911)
                                        end
                                    end
                                    if i == "Alt4" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-256.092, -6.208, -404.911)
                                        end
                                    end
                                    if i == "Alt5" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-273.592, -6.208, -396.911)
                                        end
                                    end
                                    if i == "Alt6" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-267.592, -6.208, -396.911)
                                        end
                                    end
                                    if i == "Alt7" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-262.092, -6.208, -396.911)
                                        end
                                    end
                                    if i == "Alt8" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-256.092, -6.208, -396.911)
                                        end
                                    end
                                    if i == "Alt9" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-273.592, -6.208, -388.911)
                                        end
                                    end
                                    if i == "Alt10" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-267.592, -6.208, -388.911)
                                        end
                                    end
                                    if i == "Alt11" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-262.092, -6.208, -388.911)
                                        end
                                    end
                                    if i == "Alt12" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-256.092, -6.208, -388.911)
                                        end
                                    end
                                    if i == "Alt13" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-273.592, -6.208, -380.911)
                                        end
                                    end
                                    if i == "Alt14" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-267.592, -6.208, -380.911)
                                        end
                                    end
                                    if i == "Alt15" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-262.092, -6.208, -380.911)
                                        end
                                    end
                                    if i == "Alt16" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-256.092, -6.208, -380.911)
                                        end
                                    end
                                    if i == "Alt17" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-273.592, -6.208, -372.911)
                                        end
                                    end
                                    if i == "Alt18" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-267.592, -6.208, -372.911)
                                        end
                                    end
                                    if i == "Alt19" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-262.092, -6.208, -372.911)
                                        end
                                    end
                                    if i == "Alt20" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-256.092, -6.208, -372.911)
                                        end
                                    end
                                    if i == "Alt21" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-273.592, -6.208, -364.911)
                                        end
                                    end
                                    if i == "Alt22" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-267.592, -6.208, -364.911)
                                        end
                                    end
                                    if i == "Alt23" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-262.092, -6.208, -364.911)
                                        end
                                    end
                                    if i == "Alt24" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-256.092, -6.208, -364.911)
                                        end
                                    end
                                    if i == "Alt25" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-273.592, -6.208, -356.911)
                                        end
                                    end
                                    if i == "Alt26" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-267.592, -6.208, -356.911)
                                        end
                                    end
                                    if i == "Alt27" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-262.092, -6.208, -356.911)
                                        end
                                    end
                                    if i == "Alt28" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-256.092, -6.208, -356.911)
                                        end
                                    end
                                    if i == "Alt29" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-273.592, -6.208, -348.911)
                                        end
                                    end
                                    if i == "Alt30" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-267.592, -6.208, -348.911)
                                        end
                                    end
                                    if i == "Alt31" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-262.092, -6.208, -348.911)
                                        end
                                    end
                                    if i == "Alt32" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-256.092, -6.208, -348.911)
                                        end
                                    end
                                    if i == "Alt33" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-244.592, -6.208, -404.911)
                                        end
                                    end
                                    if i == "Alt34" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-237.592, -6.208, -404.911)
                                        end
                                    end
                                    if i == "Alt35" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-241.592, -6.208, -400.911)
                                        end
                                    end
                                    if i == "Alt36" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-282.592, -6.208, -404.911)
                                        end
                                    end
                                    if i == "Alt37" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-289.592, -6.208, -404.911)
                                        end
                                    end
                                    if i == "Alt38" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-286.592, -6.208, -401.911)
                                        end
                                    end
                                end
                            end
    
    
                            if finalMsg == getgenv().prefix .. "setup jail" then
                                game.Players.LocalPlayer.Character.Head.Anchored = false
                                for i, v in pairs(getgenv().alts) do
                                    if i == "Alt1" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-326.505, 22.95, -28.25)
                                        end
                                    end
                                    if i == "Alt2" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-326.505, 22.95, -22.25)
                                        end
                                    end
                                    if i == "Alt3" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-326.505, 22.95, -16.75)
                                        end
                                    end
                                    if i == "Alt4" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-326.505, 22.95, -10.75)
                                        end
                                    end
                                    if i == "Alt5" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-318.505, 22.95, -28.25)
                                        end
                                    end
                                    if i == "Alt6" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-318.505, 22.95, -22.25)
                                        end
                                    end
                                    if i == "Alt7" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-318.505, 22.95, -16.75)
                                        end
                                    end
                                    if i == "Alt8" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-318.505, 22.95, -10.75)
                                        end
                                    end
                                    if i == "Alt9" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-310.505, 22.95, -28.25)
                                        end
                                    end
                                    if i == "Alt10" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-310.505, 22.95, -22.25)
                                        end
                                    end
                                    if i == "Alt11" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-310.505, 22.95, -16.75)
                                        end
                                    end
                                    if i == "Alt12" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-310.505, 22.95, -10.75)
                                        end
                                    end
                                    if i == "Alt13" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-302.505, 22.95, -28.25)
                                        end
                                    end
                                    if i == "Alt14" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-302.505, 22.95, -22.25)
                                        end
                                    end
                                    if i == "Alt15" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-302.505, 22.95, -16.75)
                                        end
                                    end
                                    if i == "Alt16" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-302.505, 22.95, -10.75)
                                        end
                                    end
                                    if i == "Alt17" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-294.505, 22.95, -28.25)
                                        end
                                    end
                                    if i == "Alt18" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-294.505, 22.95, -22.25)
                                        end
                                    end
                                    if i == "Alt19" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-294.505, 22.95, -16.75)
                                        end
                                    end
                                    if i == "Alt20" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-294.505, 22.95, -10.75)
                                        end
                                    end
                                    if i == "Alt21" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-286.505, 22.95, -28.25)
                                        end
                                    end
                                    if i == "Alt22" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-278.505, 22.95, -10.75)
                                        end
                                    end
                                    if i == "Alt23" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-270.505, 22.95, -28.25)
                                        end
                                    end
                                    if i == "Alt24" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-270.505, 22.95, -22.25)
                                        end
                                    end
                                    if i == "Alt25" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-270.505, 22.95, -22.25)
                                        end
                                    end
                                    if i == "Alt26" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-270.505, 22.95, -10.75)
                                        end
                                    end
                                    if i == "Alt27" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-377.25, 21.25, -284.5)
                                        end
                                    end
                                    if i == "Alt28" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-383.25, 21.25, -284.5)
                                        end
                                    end
                                    if i == "Alt29" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-365.75, 21.25, -276.5)
                                        end
                                    end
                                    if i == "Alt30" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-371.75, 21.25, -276.5)
                                        end
                                    end
                                    if i == "Alt31" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-371.75, 21.25, -276.5)
                                        end
                                    end
                                    if i == "Alt32" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-383.25, 21.25, -276.5)
                                        end
                                    end
                                    if i == "Alt33" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-365.75, 21.25, -269.5)
                                        end
                                    end
                                    if i == "Alt34" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-365.75, 21.25, -292.5)
                                        end
                                    end
                                    if i == "Alt35" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-377.25, 21.25, -269.5)
                                        end
                                    end
                                    if i == "Alt36" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-383.25, 21.25, -269.5)
                                        end
                                    end
                                    if i == "Alt37" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-383.25, 21.25, -263.5)
                                        end
                                    end
                                    if i == "Alt38" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-377.25, 21.25, -263.5)
                                            end
                                        end
                                    end
                                end
    
                                
                            if finalMsg == getgenv().prefix .. "setup basketball" then
                                game.Players.LocalPlayer.Character.Head.Anchored = false
                                for i, v in pairs(getgenv().alts) do
                                    if i == "Alt1" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-941.045, 22, -507.7)
                                        end
                                    end
                                    if i == "Alt2" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-935.045, 22, -507.7)
                                        end
                                    end
                                    if i == "Alt3" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-929.545, 22, -507.7)
                                        end
                                    end
                                    if i == "Alt4" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-923.545, 22, -507.7)
                                        end
                                    end
                                    if i == "Alt5" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-941.045, 22, -499.7)
                                        end
                                    end
                                    if i == "Alt6" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-935.045, 22, -499.7)
                                        end
                                    end
                                    if i == "Alt7" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-929.545, 22, -499.7)
                                        end
                                    end
                                    if i == "Alt8" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-923.545, 22, -499.7)
                                        end
                                    end
                                    if i == "Alt9" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-941.045, 22, -491.7)
                                        end
                                    end
                                    if i == "Alt10" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-935.045, 22, -491.7)
                                        end
                                    end
                                    if i == "Alt11" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-929.545, 22, -491.7)
                                        end
                                    end
                                    if i == "Alt12" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-941.045, 22, -483.7)
                                        end
                                    end
                                    if i == "Alt13" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-935.045, 22, -483.7)
                                        end
                                    end
                                    if i == "Alt14" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-929.545, 22, -483.7)
                                        end
                                    end
                                    if i == "Alt15" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-923.545, 22, -483.7)
                                        end
                                    end
                                    if i == "Alt16" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-941.045, 22, -475.7)
                                        end
                                    end
                                    if i == "Alt17" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-935.045, 22, -475.7)
                                        end
                                    end
                                    if i == "Alt18" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-929.545, 22, -475.7)
                                        end
                                    end
                                    if i == "Alt19" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-923.545, 22, -475.7)
                                        end
                                    end
                                    if i == "Alt20" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-941.045, 22, -467.7)
                                        end
                                    end
                                    if i == "Alt21" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-935.045, 22, -467.7)
                                        end
                                    end
                                    if i == "Alt22" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-929.545, 22, -467.7)
                                        end
                                    end
                                    if i == "Alt23" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-923.545, 22, -467.7)
                                        end
                                    end
                                    if i == "Alt24" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-941.045, 22, -459.7)
                                        end
                                    end
                                    if i == "Alt25" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-935.045, 22, -459.7)
                                        end
                                    end
                                    if i == "Alt26" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-929.545, 22, -459.7)
                                        end
                                    end
                                    if i == "Alt27" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-923.545, 22, -459.7)
                                        end
                                    end
                                    if i == "Alt28" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-941.045, 22, -451.7)
                                        end
                                    end
                                    if i == "Alt29" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-935.045, 22, -451.7)
                                        end
                                    end
                                    if i == "Alt30" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-929.545, 22, -451.7)
                                        end
                                    end
                                    if i == "Alt31" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-923.545, 22, -451.7)
                                        end
                                    end
                                    if i == "Alt32" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-941.045, 22, -445.7)
                                        end
                                    end
                                    if i == "Alt33" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-935.045, 22, -445.7)
                                        end
                                    end
                                    if i == "Alt34" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-929.045, 22, -445.7)
                                        end
                                    end
                                    if i == "Alt35" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-923.045, 22, -445.7)
                                        end
                                    end
                                    if i == "Alt36" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-942.045, 22, -439.7)
                                        end
                                    end
                                    if i == "Alt37" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-935.045, 22, -439.7)
                                        end
                                    end
                                    if i == "Alt38" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-929.045, 22.1, -439.7)
                                        end
                                    end
                                end
                            end
    
                            if finalMsg == getgenv().prefix .. "setup bank" then
                                game.Players.LocalPlayer.Character.Head.Anchored = false
                                for i, v in pairs(getgenv().alts) do
                                    if i == "Alt1" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-389, 21, -338)
                                        end
                                    end
                                    if i == "Alt2" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-385, 21, -338)
                                        end
                                    end
                                    if i == "Alt3" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-380, 21, -337)
                                        end
                                    end
                                    if i == "Alt4" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-376, 21, -338)
                                        end
                                    end
                                    if i == "Alt5" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-370, 21, -338)
                                        end
                                    end
                                    if i == "Alt6" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-366, 21, -338)
                                        end
                                    end
                                    if i == "Alt7" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-361, 21, -338)
                                        end
                                    end
                                    if i == "Alt8" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-361, 21, -333)
                                        end
                                    end
                                    if i == "Alt9" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-365, 21, -334)
                                        end
                                    end
                                    if i == "Alt10" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-370, 21, -334)
                                        end
                                    end
                                    if i == "Alt11" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-375, 21, -334)
                                        end
                                    end
                                    if i == "Alt12" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-381, 21, -334)
                                        end
                                    end
                                    if i == "Alt13" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-386, 21, -334)
                                        end
                                    end
                                    if i == "Alt14" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-390, 21, -334)
                                        end
                                    end
                                    if i == "Alt15" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-390, 21, -331)
                                        end
                                    end
                                    if i == "Alt16" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-386, 21, -331)
                                        end
                                    end
                                    if i == "Alt17" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-382, 21, -331)
                                        end
                                    end
                                    if i == "Alt18" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-376, 21, -331)
                                        end
                                    end
                                    if i == "Alt19" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-371, 21, -331)
                                        end
                                    end
                                    if i == "Alt20" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-366, 21, -331)
                                        end
                                    end
                                    if i == "Alt21" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-361, 21, -331)
                                        end
                                    end
                                    if i == "Alt22" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-361, 21, -327)
                                        end
                                    end
                                    if i == "Alt23" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-365, 21, -327)
                                        end
                                    end
                                    if i == "Alt24" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-371, 21, -326)
                                        end
                                    end
                                    if i == "Alt25" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-376, 21, -327)
                                        end
                                    end
                                    if i == "Alt26" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-381, 21, -326)
                                        end
                                    end
                                    if i == "Alt27" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-385, 21, -327)
                                        end
                                    end
                                    if i == "Alt28" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-390, 21, -323)
                                        end
                                    end
                                    if i == "Alt29" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-390, 21, -326)
                                        end
                                    end
                                    if i == "Alt30" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-390, 21, -323)
                                        end
                                    end
                                    if i == "Alt31" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-385, 21, -323)
                                        end
                                    end
                                    if i == "Alt32" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-381, 21, -323)
                                        end
                                    end
                                    if i == "Alt33" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-375, 21, -324)
                                        end
                                    end
                                    if i == "Alt34" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-370, 21, -323)
                                        end
                                    end
                                    if i == "Alt35" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-365, 21, -324)
                                        end
                                    end
                                    if i == "Alt36" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-360, 21, -324)
                                        end
                                    end
                                    if i == "Alt37" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-359, 21, -318)
                                        end
                                    end
                                    if i == "Alt38" then
                                        if v == plr.UserId then
                                            game:service 'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                                CFrame.new(-364, 21, -319)
                                        end
                                    end
                                end
                            end
    
                            if finalMsg == getgenv().prefix .. "drop" then
    
                                if getgenv().isDropping == false then
    
                                    getgenv().isDropping = true
    
                                    if getgenv().isDropping == true then
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 102, false, yomama)
                                        local args = {
                                            [1] = "STARTED DROPPING!",
                                            [2] = "All"
                                        }
    
                                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                            unpack(args))
                                    end
                                    while getgenv().isDropping == true do
    
                                        if game:GetService("Players").LocalPlayer.DataFolder.Currency.Value < 10000 then
                                            local args = {
                                                [1] = "Ran out of money, stopped dropping.",
                                                [2] = "All"
                                            }
    
                                            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents
                                                .SayMessageRequest:FireServer(unpack(args))
                                        end
    
                                        local args = {
                                            [1] = "DropMoney",
                                            [2] = "10000"
                                        }
    
                                        game:GetService("ReplicatedStorage").MainEvent:FireServer(unpack(args))
                                        wait(15)
                                    end
                                else
    
                                    getgenv().isDropping = false
                                    if getgenv().isDropping == false then
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 102, false, yomama)
                                        local args = {
                                            [1] = "STOPPED DROPPING!",
                                            [2] = "All"
                                        }
    
                                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                            unpack(args))
                                    end
    
                                end
    
                            end
    
                            if finalMsg == getgenv().prefix .. "drop " .. plr.Name:lower() then
    
                                if getgenv().isDropping == false then
    
                                    getgenv().isDropping = true
    
                                    if getgenv().isDropping == true then
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 102, false, yomama)
                                        local args = {
                                            [1] = "STARTED DROPPING!",
                                            [2] = "All"
                                        }
    
                                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                            unpack(args))
                                    end
                                    while getgenv().isDropping == true do
    
                                        if game:GetService("Players").LocalPlayer.DataFolder.Currency.Value < 10000 then
                                            local args = {
                                                [1] = "Ran out of money, stopped dropping.",
                                                [2] = "All"
                                            }
    
                                            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents
                                                .SayMessageRequest:FireServer(unpack(args))
                                        end
    
                                        local args = {
                                            [1] = "DropMoney",
                                            [2] = "10000"
                                        }
    
                                        game:GetService("ReplicatedStorage").MainEvent:FireServer(unpack(args))
                                        wait(15)
                                    end
                            
                            else
                        
                                    getgenv().isDropping = false
                                    if getgenv().isDropping == false then
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 102, false, yomama)
                                        local args = {
                                            [1] = "STOPPED DROPPING!",
                                            [2] = "All"
                                        }
    
                                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                            unpack(args))
                                    end
    
                                end
    
                            end

                            if finalMsg == getgenv().prefix .. "altad" then
                                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(string.sub(msg,space+1), "All")
                                end
    
                            if finalMsg == getgenv().prefix .. "ad" then
                                
    
                                if getgenv().adverting == false then
    
                                    getgenv().adverting = true
    
                                    while getgenv().adverting == true do
    
                                        local args = {
                                            [1] = getgenv().adMessage,
                                            [2] = "All"
                                        }
    
                                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                            unpack(args))
                                        wait(getgenv().adMessageCooldown)
    
                                    end
                                else
    
                                    getgenv().adverting = false
    
                                end
    
                            end
    
    
                            game:GetService("StarterGui"):SetCore("SendNotification",{
                                Title = "ALT CONTROL", -- Required
                                Text = "Alt Control Seccessfully Loaded!", -- Required
                            })
    
                            if finalMsg == getgenv().prefix .. "ad " .. plr.Name:lower() then
    
                                if getgenv().adverting == false then
    
                                    getgenv().adverting = true
    
                                    while getgenv().adverting == true do
    
                                        local args = {
                                            [1] = getgenv().adMessage,
                                            [2] = "All"
                                        }
    
                                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                            unpack(args))
                                        wait(getgenv().adMessageCooldown)
    
                                    end
                                else
    
                                    getgenv().adverting = false
    
                                end
    
                            end
    
                            if finalMsg == getgenv().prefix .. "wiggle" then
    
                                game:GetService("Players"):Chat("/e dance2")
    
                            end
                            if finalMsg == getgenv().prefix .. "wiggle " .. plr.Name:lower() then
    
                                game:GetService("Players"):Chat("/e dance2")
    
                            end
    
                            if finalMsg == getgenv().prefix .. "wallet " .. plr.Name:lower() then
                                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                    if v.name == "Wallet" then
                                        v.Parent = game.Players.LocalPlayer.Character
                                    else
                                        local localPlayer = game.Players.LocalPlayer
                                        local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
                                        if humanoid then
                                            humanoid:UnequipTools()
                                        end
                                    end
                                end
    
                            end
    
                            if finalMsg == getgenv().prefix .. "wallet" then
                                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                    if v.name == "Wallet" then
                                        v.Parent = game.Players.LocalPlayer.Character
                                    else
                                        local localPlayer = game.Players.LocalPlayer
                                        local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
                                        if humanoid then
                                            humanoid:UnequipTools()
                                        end
                                    end
                                end
    
                            end
    
                            if finalMsg == getgenv().prefix .. "ddjkfjrvrjvrqrvrv^^^_______avarvaqfdfdrvetarrvfbcf3qtst " .. plr.Name:lower() then
                                local args = {
                                    [1] = "Set spot successfully!",
                                    [2] = "All"
                                }
    
                                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                    unpack(args))
                                local Players = game:GetService("Players")
                                local function getPlayerByUserId(userId)
                                    for _, player in pairs(Players:GetPlayers()) do
                                        if player.UserId == userId then
                                            return player
                                        end
                                    end
                                end
    
                                local plrrlrllr = getPlayerByUserId(getgenv().controller)
    
                                getgenv().poss = plrrlrllr.Character.HumanoidRootPart.Position
    
                            end
                            if finalMsg == getgenv().prefix .. "ddjkfjrvrjvrqrvrv^^^_______avarvaqrvetarrvfbcf3qtst" then
                                local args = {
                                    [1] = "Set spot successfully!",
                                    [2] = "All"
                                }
    
                                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                    unpack(args))
                                local Players = game:GetService("Players")
                                local function getPlayerByUserId(userId)
                                    for _, player in pairs(Players:GetPlayers()) do
                                        if player.UserId == userId then
                                            return player
                                        end
                                    end
                                end
    
                                local plrrlrllr = getPlayerByUserId(getgenv().controller)
    
                                getgenv().poss = plrrlrllr.Character.HumanoidRootPart.Position
    
                            end
    
                            if finalMsg == getgenv().prefix .. "money? " .. plr.Name:lower() then
    
                                local args = {
                                    [1] = "I have " ..
                                        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.MoneyText.Text,
                                    [2] = "All"
                                }
    
                                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                    unpack(args))
    
                            end
    
                            if finalMsg == getgenv().prefix .. "money?" then
    
                                local args = {
                                    [1] = "I have " ..
                                        game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.MoneyText.Text,
                                    [2] = "All"
                                }
    
                                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                    unpack(args))
    
                            end
    
                            if finalMsg == getgenv().prefix .. "sdcrtveybetbehb3brdcw&&^^^^" then
                                endFly()
                            end
                            if finalMsg == getgenv().prefix .. "htshtstvwtv^^^^^^^^^dd " .. plr.Name:lower() then
                                endFly()
                            end
                            if finalMsg == getgenv().prefix .. "airlock " .. plr.Name:lower() then
                                game.Players.LocalPlayer.Character.Head.Anchored = false
                                local player = game.Players.LocalPlayer
                                local character = player.Character
                                local humanoid = character:FindFirstChild("Humanoid")
                                local LPlr = game.Players.LocalPlayer
                                local Character = LPlr.Character
                                local HRP = Character:WaitForChild("HumanoidRootPart")
                                humanoid.Jump = true
                                wait(0.3)
                                game.Players.LocalPlayer.Character.Head.Anchored = true
    
                            end
                            if finalMsg == getgenv().prefix .. "airlock" then
                                game.Players.LocalPlayer.Character.Head.Anchored = false
                                local player = game.Players.LocalPlayer
                                local character = player.Character
                                local humanoid = character:FindFirstChild("Humanoid")
                                local LPlr = game.Players.LocalPlayer
                                local Character = LPlr.Character
                                local HRP = Character:WaitForChild("HumanoidRootPart")
                                humanoid.Jump = true
                                wait(0.3)
                                game.Players.LocalPlayer.Character.Head.Anchored = true
    
                            end
                            if finalMsg == getgenv().prefix .. "reset" then
                                humanoid.Health = 0
                            end
    
    
                            if finalMsg == getgenv().prefix .. "reset " .. plr.Name:lower() then
                                humanoid.Health = 0
                            end
    
                            if finalMsg == getgenv().prefix .. "kick" then
                                plr:Kick("You've been kicked by the Controller.")
                            end
                            if finalMsg == getgenv().prefix .. "kick " .. plr.Name:lower() then
                                plr:Kick("You've been kicked by the Controller.")
                            end
    
                            if finalMsg == getgenv().prefix .. "bringalts" then
                                game.Players.LocalPlayer.Character.Head.Anchored = false
                                PlayerHumanoid.RootPart.CFrame = LastTargetPosition + LastTargetPosition.LookVector * Length
                                PlayerHumanoid.RootPart.CFrame =
                                    CFrame.new(PlayerHumanoid.RootPart.CFrame.Position, Vector3.new(
                                        LastTargetPosition.Position.X, PlayerHumanoid.RootPart.CFrame.Position.Y,
                                        LastTargetPosition.Position.Z))
                            end
    
                            if finalMsg == getgenv().prefix .. "bring " .. plr.Name:lower() then
                                game.Players.LocalPlayer.Character.Head.Anchored = false
                                PlayerHumanoid.RootPart.CFrame = LastTargetPosition + LastTargetPosition.LookVector * Length
                                PlayerHumanoid.RootPart.CFrame =
                                    CFrame.new(PlayerHumanoid.RootPart.CFrame.Position, Vector3.new(
                                        LastTargetPosition.Position.X, PlayerHumanoid.RootPart.CFrame.Position.Y,
                                        LastTargetPosition.Position.Z)) do

                                        PlayerHumanoid.RootPart.CFrame = LastTargetPosition + LastTargetPosition.LookVector * Length
                                PlayerHumanoid.RootPart.CFrame =
                                    CFrame.new(PlayerHumanoid.RootPart.CFrame.Position, Vector3.new(
                                        LastTargetPosition.Position.X, PlayerHumanoid.RootPart.CFrame.Position.Y,
                                        LastTargetPosition.Position.Z))
                                        
                            end
    
                            if finalMsg == getgenv().prefix .. "freeze" then
    
                                game.Players.LocalPlayer.Character.Head.Anchored = true
    
                            end
    
                            if finalMsg == getgenv().prefix .. "freeze " .. plr.Name:lower() then
    
                                game.Players.LocalPlayer.Character.Head.Anchored = true
    
                            end
                            if finalMsg == getgenv().prefix .. "unfreeze" then
    
                                game.Players.LocalPlayer.Character.Head.Anchored = false
    
                            end
                            if finalMsg == getgenv().prefix .. "unfreeze " .. plr.Name:lower() then
    
                                game.Players.LocalPlayer.Character.Head.Anchored = false
    
                            end
                        end
                    end
    
                end
            end
            Player.Chatted:Connect(Chatted)
        end
    
        local GetPlayers = Players:GetPlayers()
        for i = 1, #GetPlayers do
            local Player = GetPlayers[i]
            coroutine.resume(coroutine.create(function()
                PlayerAdded(Player)
            end))
        end
        Players.PlayerAdded:Connect(PlayerAdded)
    
        if game.Players.LocalPlayer.UserId == getgenv().controller then
            function RandomVariable(length)
                local res = ""
                for i = 1, length do
                    res = res .. string.char(math.random(97, 122))
                end
                return res
            end
    
        for i, v in pairs(getgenv().alts) do
    
            if v == game.Players.LocalPlayer.UserId then
    
                Clip = false
    
                local speaker = game.Players.LocalPlayer
                wait(0.1)
                local function NoclipLoop()
                    if Clip == false and speaker.Character ~= nil then
                        for _, child in pairs(speaker.Character:GetDescendants()) do
                            if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                                child.CanCollide = false
                            end
                        end
                    end
                end
                Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
                workspace:FindFirstChildOfClass('Terrain').WaterWaveSize = 0
                workspace:FindFirstChildOfClass('Terrain').WaterWaveSpeed = 0
                workspace:FindFirstChildOfClass('Terrain').WaterReflectance = 0
                workspace:FindFirstChildOfClass('Terrain').WaterTransparency = 0
                game:GetService("Lighting").GlobalShadows = false
                game:GetService("Lighting").FogEnd = 9e9
                settings().Rendering.QualityLevel = 1
                for i, v in pairs(game:GetDescendants()) do
                    if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or
                        v:IsA("TrussPart") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                    elseif v:IsA("Decal") then
                        v.Transparency = 1
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        v.Lifetime = NumberRange.new(0)
                    elseif v:IsA("Explosion") then
                        v.BlastPressure = 1
                        v.BlastRadius = 1
                    end
                end
                for i, v in pairs(game:GetService("Lighting"):GetDescendants()) do
                    if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or
                        v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                        v.Enabled = false
                    end
                end
                workspace.DescendantAdded:Connect(function(child)
                    coroutine.wrap(function()
                        if child:IsA('ForceField') then
                            game:GetService('RunService').Heartbeat:Wait()
                            child:Destroy()
                        elseif child:IsA('Sparkles') then
                            game:GetService('RunService').Heartbeat:Wait()
                            child:Destroy()
                        elseif child:IsA('Smoke') or child:IsA('Fire') then
                            game:GetService('RunService').Heartbeat:Wait()
                            child:Destroy()
                        end
                    end)()
                end)
    
                local timeBegan = tick()
                for i, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Material = "SmoothPlastic"
                    end
                end
                for i, v in ipairs(game:GetService("Lighting"):GetChildren()) do
                    v:Destroy()
                end
                local timeEnd = tick() - timeBegan
                local timeMS = math.floor(timeEnd * 1000)
    
                local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
                local g = game
                local w = g.Workspace
                local l = g.Lighting
                local t = w.Terrain
                t.WaterWaveSize = 0
                t.WaterWaveSpeed = 0
                t.WaterReflectance = 0
                t.WaterTransparency = 0
                l.GlobalShadows = false
                l.FogEnd = 9e9
                l.Brightness = 0
                settings().Rendering.QualityLevel = "Level01"
                for i, v in pairs(g:GetDescendants()) do
                    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                        v.Transparency = 1
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        v.Lifetime = NumberRange.new(0)
                    elseif v:IsA("Explosion") then
                        v.BlastPressure = 1
                        v.BlastRadius = 1
                    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                        v.Enabled = false
                    elseif v:IsA("MeshPart") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                        v.TextureID = 10385902758728957
                    end
                end
                for i, e in pairs(l:GetChildren()) do
                    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or
                        e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                        e.Enabled = false
                    end
                end
    
                local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
                local g = game
                local w = g.Workspace
                local l = g.Lighting
                local t = w.Terrain
                t.WaterWaveSize = 0
                t.WaterWaveSpeed = 0
                t.WaterReflectance = 0
                t.WaterTransparency = 0
                l.GlobalShadows = false
                l.FogEnd = 9e9
                l.Brightness = 0
                settings().Rendering.QualityLevel = "Level01"
                for i, v in pairs(g:GetDescendants()) do
                    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                        v.Transparency = 1
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        v.Lifetime = NumberRange.new(0)
                    elseif v:IsA("Explosion") then
                        v.BlastPressure = 1
                        v.BlastRadius = 1
                    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                        v.Enabled = false
                    elseif v:IsA("MeshPart") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                        v.TextureID = 10385902758728957
                    end
                end
                for i, e in pairs(l:GetChildren()) do
                    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or
                        e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                        e.Enabled = false
                    end
                end
    
                function RandomVariable(length)
                    local res = ""
                    for i = 1, length do
                        res = res .. string.char(math.random(97, 122))
                    end
                    return res
                end
    
     
    
    else
        game.Players.LocalPlayer:Kick("Only da hood.")
    end
    end
    end
    end
    end)
end
