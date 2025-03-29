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

-- Thêm tính năng Hiển thị vùng Hitbox cho quái vật
local espEnabled = false
local espObjects = {}

local function createHitboxForMonster(monster)
    -- Tạo vùng hitbox xung quanh quái vật
    local humanoidRootPart = monster:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        -- Tạo Box hoặc Cylinder xung quanh quái vật
        local hitbox = Instance.new("BoxHandleAdornment")
        hitbox.Parent = monster
        hitbox.Adornee = humanoidRootPart
        hitbox.Size = humanoidRootPart.Size * 2 -- Tăng kích thước của vùng hitbox (có thể thay đổi tỷ lệ này)
        hitbox.Color3 = Color3.new(1, 0, 0) -- Màu đỏ
        hitbox.Transparency = 0.5 -- Độ trong suốt (có thể thay đổi để nhìn rõ hơn)
        hitbox.ZIndex = 10
        hitbox.AlwaysOnTop = true
        table.insert(espObjects, hitbox)
    end
end

local function removeESP()
    -- Xóa các vùng hitbox hiện tại
    for _, esp in pairs(espObjects) do
        esp:Destroy()
    end
    espObjects = {}
end

local EspButton = TabChung:AddButton({
    Title = "Toggle Hitbox ESP",
    Content = "Bật/Tắt Hiển Thị Vùng Hitbox cho Quái Vật",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        espEnabled = not espEnabled
        if espEnabled then
            print("Hiển Thị Vùng Hitbox Đã Bật")
            -- Lắng nghe các quái vật mới xuất hiện
            game:GetService("Workspace").ChildAdded:Connect(function(child)
                if child:IsA("Model") and child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") then
                    local monsterType = child.Name:lower()  -- Lọc các quái vật
                    if string.find(monsterType, "zombie") or string.find(monsterType, "chó sói") or string.find(monsterType, "cướp") then
                        createHitboxForMonster(child)  -- Tạo vùng hitbox cho quái vật
                    end
                end
            end)
        else
            print("Hiển Thị Vùng Hitbox Đã Tắt")
            removeESP()  -- Xóa các vùng hitbox
        end
    end
})

-- Kiểm tra khi viên đạn va vào vùng hitbox
game:GetService("RunService").Heartbeat:Connect(function()
    if espEnabled then
        -- Kiểm tra xem viên đạn có chạm vào vùng hitbox hay không
        for _, monster in pairs(game.Workspace:GetChildren()) do
            if monster:IsA("Model") and monster:FindFirstChild("Humanoid") and monster:FindFirstChild("HumanoidRootPart") then
                local monsterType = monster.Name:lower()
                if string.find(monsterType, "zombie") or string.find(monsterType, "chó sói") or string.find(monsterType, "cướp") then
                    local hitbox = monster:FindFirstChild("BoxHandleAdornment")
                    if hitbox and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        -- Kiểm tra xem có viên đạn hay tầm bắn nào va vào vùng hitbox hay không
                        local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - monster.HumanoidRootPart.Position).Magnitude
                        if distance < hitbox.Size.Magnitude then
                            -- Tự động tấn công hoặc bắn trúng quái vật
                            print("Bắn trúng quái vật: " .. monster.Name)
                            -- Ở đây bạn có thể gọi thêm các hành động như giảm máu quái vật hoặc làm một hành động nào đó khi trúng
                        end
                    end
                end
            end
        end
    end
end)

