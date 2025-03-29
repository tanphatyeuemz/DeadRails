--[ pls dont skid my hub ]--

local RimusLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Duc18-code/scriptducv3/refs/heads/main/UInew.lua"))()
local Notify = RimusLib:MakeNotify({
    Title = "Notification",
    Content = "tanphat là bố",
    Image = "rbxassetid://100756646036568",
    Time = 1,
    Delay = 5
})

local RimusHub = RimusLib:MakeGui({
    NameHub = "PhatDepZai Hub",
    NameGam = "     [version : deadrails]",
    Icon = "rbxassetid://100756646036568"
})

-- Tab Chung
local TabChung = RimusHub:CreateTab({
    Name = "Tab Chung",
    Icon = "rbxassetid://100756646036568"
})

-- AimBot trong Tab Chung
local aimbotEnabled = false

local AimButton = TabChung:AddButton({
    Title = "Toggle AimBot",
    Content = "Bật/Tắt AimBot",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        aimbotEnabled = not aimbotEnabled
        if aimbotEnabled then
            print("AimBot Đã Bật")
            -- Thêm code aimbot tại đây
            -- Ví dụ: Tìm kiếm mục tiêu gần nhất và tự động bắn
            while aimbotEnabled do
                local target = nil
                local closestDistance = math.huge
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            target = player
                        end
                    end
                end
                if target then
                    -- Code bắn vào mục tiêu ở đây
                    print("Đã nhắm đến: " .. target.Name)
                end
                wait(0.1) -- Kiểm tra lại mỗi 0.1 giây
            end
        else
            print("AimBot Đã Tắt")
        end
    end
})

-- Tab ESP
local TabESP = RimusHub:CreateTab({
    Name = "Tab ESP",
    Icon = "rbxassetid://100756646036568"
})

-- ESP Quái Vật
local espEnabled = false

local EspButton = TabESP:AddButton({
    Title = "Toggle ESP",
    Content = "Bật/Tắt ESP quái vật",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        espEnabled = not espEnabled
        if espEnabled then
            print("ESP Đã Bật")
            -- Thêm code ESP để hiển thị quái vật gần đó
            local function createESPForMonster(monster)
                local espBox = Instance.new("BoxHandleAdornment")
                espBox.Parent = monster
                espBox.Adornee = monster
                espBox.Size = monster.HumanoidRootPart.Size
                espBox.Color3 = Color3.new(1, 0, 0) -- Màu đỏ cho quái vật
                espBox.Transparency = 0.5
                espBox.ZIndex = 10
                espBox.AlwaysOnTop = true
            end

            -- Tìm và thêm ESP cho quái vật gần đó
            game:GetService("Workspace").ChildAdded:Connect(function(child)
                if child:IsA("Model") and child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") then
                    createESPForMonster(child)
                end
            end)
        else
            print("ESP Đã Tắt")
            -- Xóa các ESP hiện tại
            for _, child in pairs(game:GetService("Workspace"):GetDescendants()) do
                if child:IsA("BoxHandleAdornment") then
                    child:Destroy()
                end
            end
        end
    end
})

-- Tab NPC Lock
local TabNPCLock = RimusHub:CreateTab({
    Name = "Tab NPC Lock",
    Icon = "rbxassetid://100756646036568"
})

-- NPC Lock Function
local npcLockEnabled = false

local NpcLockButton = TabNPCLock:AddButton({
    Title = "Toggle NPC Lock",
    Content = "Bật/Tắt NPC Lock",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        npcLockEnabled = not npcLockEnabled
        if npcLockEnabled then
            print("NPC Lock Đã Bật")
            -- Thêm code NPC Lock tại đây
            while npcLockEnabled do
                local npc = game.Workspace:FindFirstChild("NPC") -- Giả sử NPC có tên là "NPC"
                if npc then
                    -- Lock vào NPC
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
                    print("Đã khóa vào NPC")
                end
                wait(0.1)
            end
        else
            print("NPC Lock Đã Tắt")
        end
    end
})

-- Tab Teleport 80km
local TabTeleport = RimusHub:CreateTab({
    Name = "Tab Teleport 80km",
    Icon = "rbxassetid://100756646036568"
})

-- Teleport 80km Function
local Teleport80kmButton = TabTeleport:AddButton({
    Title = "Teleport 80km",
    Content = "Di chuyển 80km",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        local targetPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(80000, 0, 80000)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
        print("Đã teleport tới 80km")
    end
})
