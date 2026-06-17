-- // BINN HUB: DANG NGUYEN THIEN PHUC (AUTO-LAYOUT EDITION)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BinnHub-TongHopV1"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui); Main.Size = UDim2.new(0, 480, 0, 420); Main.Position = UDim2.new(0.5, -240, 0.5, -210); Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Main.Active = true; Main.Draggable = true; Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Main); Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "BINN HUB | CRE: DANG PHUC"; Title.TextColor3 = Color3.new(1,1,1); Title.Font = Enum.Font.GothamBold; Title.BackgroundTransparency = 1
local TabContainer = Instance.new("Frame", Main); TabContainer.Size = UDim2.new(1, 0, 0, 40); TabContainer.Position = UDim2.new(0, 0, 0, 40); TabContainer.BackgroundTransparency = 1
local ContentFrame = Instance.new("Frame", Main); ContentFrame.Size = UDim2.new(1, 0, 1, -80); ContentFrame.Position = UDim2.new(0, 0, 0, 80); ContentFrame.BackgroundTransparency = 1

local function Execute(name, link)
    task.spawn(function()
        local delayTime = math.random(5, 10) 
        print("Đang khởi chạy " .. name .. " sau " .. delayTime .. "s...")
        task.wait(delayTime)
        -- Tự động kiểm tra: Nếu chỉ là link thuần thì tự bọc loadstring, nếu là code sẵn thì chạy luôn
        if string.match(link, "^http") then
            loadstring(game:HttpGet(link))()
        else
            loadstring(link)()
        end
    end)
end

local function CreateTab(name, index)
    local btn = Instance.new("TextButton", TabContainer); btn.Size = UDim2.new(1/3, 0, 1, 0); btn.Position = UDim2.new(index * 1/3, 0, 0, 0); btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.TextColor3 = Color3.new(1,1,1); btn.Font = Enum.Font.GothamBold
    
    -- Chuyển thành ScrollingFrame để cuộn được mượt mà khi có nhiều Section
    local scroll = Instance.new("ScrollingFrame", ContentFrame); scroll.Name = name; scroll.Size = UDim2.new(1, 0, 1, 0); scroll.BackgroundTransparency = 1; scroll.ScrollBarThickness = 6; scroll.Visible = (index == 0); scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    local layout = Instance.new("UIListLayout", scroll); layout.SortOrder = Enum.SortOrder.LayoutOrder; layout.Padding = UDim.new(0, 15); layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
    
    btn.MouseButton1Click:Connect(function() for _, f in pairs(ContentFrame:GetChildren()) do if f:IsA("ScrollingFrame") then f.Visible = (f.Name == name) end end end)
    return scroll
end

local function AddSection(parentScroll, sectionName)
    local sec = Instance.new("Frame", parentScroll); sec.Name = sectionName; sec.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Instance.new("UICorner", sec)
    local lbl = Instance.new("TextLabel", sec); lbl.Size = UDim2.new(1, 0, 0, 30); lbl.Text = sectionName; lbl.TextColor3 = Color3.new(1,1,1); lbl.Font = Enum.Font.GothamBold; lbl.BackgroundTransparency = 1
    
    local btnLayout = Instance.new("UIListLayout", sec); btnLayout.SortOrder = Enum.SortOrder.LayoutOrder; btnLayout.Padding = UDim.new(0, 6); btnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    -- Tự động giãn chiều cao Section dựa trên số lượng nút bên trong
    btnLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sec.Size = UDim2.new(0.92, 0, 0, btnLayout.AbsoluteContentSize.Y + 15)
    end)
    return sec
end

local function CreateButton(parentSec, name, link)
    local btn = Instance.new("TextButton", parentSec); btn.Size = UDim2.new(0.92, 0, 0, 32); btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); btn.TextColor3 = Color3.new(1,1,1); btn.Font = Enum.Font.Gotham; Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() Execute(name, link) end)
end

-- // ================= CẤU HÌNH HUB (SIÊU GỌN LẸ) =================
local Tab1 = CreateTab("Blox Fruits", 0) 
local s1 = AddSection(Tab1, "Main")
CreateButton(s1, "UI redz", "https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua")
CreateButton(s1, "Tay hub", "https://raw.githubusercontent.com/VTDROBLOX/Animehub/refs/heads/main/Tayhub.txt")
CreateButton(s1, "Redz huy", "https://raw.githubusercontent.com/huy384/redzHub/refs/heads/main/redzHub.lua")
CreateButton(s1, "OMG hub (có key)", "https://api.luarmor.net/files/v3/loaders/20f318386e3fbf069ee3fa797cfc9f34.lua")
CreateButton(s1, "UI banana", 'loadstring(game:HttpGet("https://minhz-hub.vercel.app/main_ui",true))()')
CreateButton(s1, "Gravity Hub", "https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/MainPremium.lua")
CreateButton(s1, "RealKid hub", "https://raw.githubusercontent.com/realkidhub/realkid/refs/heads/main/main.lua")
CreateButton(s1, "Longhihi", "https://raw.githubusercontent.com/longhihilonghihi-hub/BananaHub/refs/heads/main/CombackVersion")
CreateButton(s1, "Binn Banana hub", "https://raw.githubusercontent.com/Binn-nguyen/Banana-Hub/refs/heads/main/Phucdepzai-Banana.lua")

local s2 = AddSection(Tab1, "Kaitun VIP")
CreateButton(s2, "Kaitun VIP", "https://raw.githubusercontent.com/NaNacuti/kaitunvip/refs/heads/main/NaNakaitunBF.luau")
CreateButton(s2, "Tay kaitun", "https://raw.githubusercontent.com/VTDROBLOX/Animehub/refs/heads/main/tayhubkaitun.lua")
CreateButton(s2, "Blue x kaitun", "https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/KaitunBloxFruits.lua")
CreateButton(s2, "Night hub kaitun", "https://api.luarmor.net/files/v4/loaders/d6c7959dcc94cd24467080d82a56dcf9.lua")
CreateButton(s2, "PVP Kaitun", "https://api.luarmor.net/files/v4/loaders/2ffcdb62773f587bfb9eb0d52bb35b0c.lua")
CreateButton(s2, "Hernomous hub", "https://raw.githubusercontent.com/hermanos-dev/hermanos-hub/refs/heads/main/Loader.lua")
CreateButton(s2, "Lonely hub (có key)", "https://raw.githubusercontent.com/LongHip12/LonelyHub/refs/heads/main/LonelyHub-BountyM1.lua")
CreateButton(s2, "Tzuan hub (no key)", "https://raw.githubusercontent.com/tzuanyeuban/TzuanHub/refs/heads/main/Autobountynew.lua")
CreateButton(s2, "Night hub 30/4 (no key)", "https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua")
CreateButton(s2, "Andepzai hub", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkMuscles/Games/Roblox/Bloxfruits/AnDepZaiHub.lua", true))()')

local Tab2 = CreateTab("Garden", 1)
local s3 = AddSection(Tab2, "Main")
CreateButton(s3, "Speed hub (có key)", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()')
CreateButton(s3, "Hoshi hub (có key)", "https://script.roscripts.io/mzMEwEq")
CreateButton(s3, "Library hub (không key)", "https://raw.githubusercontent.com/Wonik99/library-hub/refs/heads/main/growagarden2")
CreateButton(s3, "Fake robux (có key)", "https://pastefy.app/rxGKgtBB/raw")
CreateButton(s3, "UB hub (no key)", "https://raw.githubusercontent.com/TeamUBHub/UBLoader/refs/heads/main/index/Key.lua")

local Tab3 = CreateTab("99 Night", 2)
local s4 = AddSection(Tab3, "Main")
CreateButton(s4, "Void ware (no key)", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()')
CreateButton(s4, "foxnamehub (no key)", "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua")
CreateButton(s4, "Raygull stable (no key)", "https://raw.githubusercontent.com/raygull3d/99-Nights-in-the-Forest-Script/refs/heads/main/99%20Days%20Scirpt%20By%20Raygull.lua")
CreateButton(s4, "Toasty XD hub (có key)", "https://raw.githubusercontent.com/nouralddin-abdullah/ToastyHub-XD/refs/heads/main/hub-main.lua")
CreateButton(s4, "H4x (no key key)", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader.lua", true))()')
