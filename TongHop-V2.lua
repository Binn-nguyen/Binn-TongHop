-- =============================================================================
-- BINN HUB: DANG NGUYEN THIEN PHUC (AUTO-LAYOUT WITH TOGGLE BUTTON)
-- =============================================================================

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BinnHub-TongHopV1"
ScreenGui.ResetOnSpawn = false

-- Tự động dọn dẹp bản cũ nếu sếp chạy lại script
if CoreGui:FindFirstChild("BinnHub-TongHopV1") and CoreGui["BinnHub-TongHopV1"] ~= ScreenGui then
    CoreGui["BinnHub-TongHopV1"]:Destroy()
end

-- [1. KHỦNG CHÍNH - MAIN FRAME]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(480, 420)
Main.Position = UDim2.new(0.5, -240, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(255, 140, 0) -- Viền cam
MainStroke.Thickness = 2

-- [2. NÚT THU NHỎ TRÒN (TOGGLE BUTTON)]
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Name = "ToggleButton"
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleButton.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleButton.Size = UDim2.fromOffset(50, 50)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "BINN"
ToggleButton.TextColor3 = Color3.fromRGB(255, 140, 0)
ToggleButton.TextSize = 12
ToggleButton.Visible = false

local ToggleCorner = Instance.new("UICorner", ToggleButton)
ToggleCorner.CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleButton)
ToggleStroke.Color = Color3.fromRGB(255, 140, 0)
ToggleStroke.Thickness = 1.5

-- Nút gạch ngang để thu nhỏ
local MinimizeBtn = Instance.new("TextButton", Main)
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(1, -35, 0, 10)
MinimizeBtn.Size = UDim2.fromOffset(25, 25)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 140, 0)
MinimizeBtn.TextSize = 14

local isTweening = false
MinimizeBtn.MouseButton1Click:Connect(function()
    if isTweening then return end
    isTweening = true
    Main:TweenSize(UDim2.fromOffset(480, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true, function()
        Main.Visible = false
        ToggleButton.Visible = true
        isTweening = false
    end)
end)

ToggleButton.MouseButton1Click:Connect(function()
    if isTweening then return end
    isTweening = true
    ToggleButton.Visible = false
    Main.Visible = true
    Main:TweenSize(UDim2.fromOffset(480, 420), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true, function()
        isTweening = false
    end)
end)

local dragToggle, dragStartToggle, startPosToggle
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true dragStartToggle = input.Position startPosToggle = ToggleButton.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragToggle = false end end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartToggle
        ToggleButton.Position = UDim2.new(startPosToggle.X.Scale, startPosToggle.X.Offset + delta.X, startPosToggle.Y.Scale, startPosToggle.Y.Offset + delta.Y)
    end
end)

-- [3. TIÊU ĐỀ CHÍNH]
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Text = "BINN HUB | CRE: DANG PHUC"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Center

local TabContainer = Instance.new("Frame", Main)
TabContainer.Size = UDim2.new(1, 0, 0, 40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundTransparency = 1

local ContentFrame = Instance.new("Frame", Main)
ContentFrame.Size = UDim2.new(1, 0, 1, -80)
ContentFrame.Position = UDim2.new(0, 0, 0, 80)
ContentFrame.BackgroundTransparency = 1

-- [4. LOGIC XỬ LÝ CHẠY SCRIPT TỰ ĐỘNG THÊM LOADSTRING]
local function Execute(name, link)
    task.spawn(function()
        local delayTime = math.random(5, 10) 
        print("Đang khởi chạy " .. name .. " sau " .. delayTime .. "s...")
        task.wait(delayTime)
        -- Tự động bọc loadstring(game:HttpGet()) xung quanh link https công khai
        loadstring(game:HttpGet(link))()
    end)
end

-- [5. HÀM TẠO TAB]
local function CreateTab(name, index)
    local btn = Instance.new("TextButton", TabContainer)
    btn.Size = UDim2.new(1/3, 0, 1, 0)
    btn.Position = UDim2.new(index * 1/3, 0, 0, 0)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    
    local scroll = Instance.new("ScrollingFrame", ContentFrame)
    scroll.Name = name
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 6
    scroll.Visible = (index == 0)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local layout = Instance.new("UIListLayout", scroll)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 15)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
    
    btn.MouseButton1Click:Connect(function() 
        for _, f in pairs(ContentFrame:GetChildren()) do 
            if f:IsA("ScrollingFrame") then 
                f.Visible = (f.Name == name) 
            end 
        end 
    end)
    return scroll
end

-- [6. HÀM TẠO SECTION]
local function AddSection(parentScroll, sectionName)
    local sec = Instance.new("Frame", parentScroll)
    sec.Name = sectionName
    sec.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", sec)
    
    local lbl = Instance.new("TextLabel", sec)
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Text = sectionName
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.Font = Enum.Font.GothamBold
    lbl.BackgroundTransparency = 1
    
    local btnLayout = Instance.new("UIListLayout", sec)
    btnLayout.SortOrder = Enum.SortOrder.LayoutOrder
    btnLayout.Padding = UDim.new(0, 6)
    btnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    btnLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sec.Size = UDim2.new(0.92, 0, 0, btnLayout.AbsoluteContentSize.Y + 15)
    end)
    return sec
end

-- [7. HÀM TẠO BUTTON]
local function CreateButton(parentSec, name, link)
    local btn = Instance.new("TextButton", parentSec)
    btn.Size = UDim2.new(0.92, 0, 0, 32)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() Execute(name, link) end)
end

-- =============================================================================
-- // CẤU HÌNH DATA SCRIPTS CHỈ DÙNG LINK HTTPS (BỎ LOADSTRING)
-- =============================================================================

-- TAB 1: Blox Fruits
local Tab1 = CreateTab("Blox Fruits", 0) 
local s1 = AddSection(Tab1, "Main")
CreateButton(s1, "UI redz", "https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua")
CreateButton(s1, "Tay hub", "https://raw.githubusercontent.com/VTDROBLOX/Animehub/refs/heads/main/Tayhub.txt")
CreateButton(s1, "Redz huy", "https://raw.githubusercontent.com/huy384/redzHub/refs/heads/main/redzHub.lua")
CreateButton(s1, "OMG hub (có key)", "https://api.luarmor.net/files/v3/loaders/20f318386e3fbf069ee3fa797cfc9f34.lua")
CreateButton(s1, "UI banana", "https://minhz-hub.vercel.app/main_ui")
CreateButton(s1, "Gravity Hub", "https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/MainPremium.lua")
CreateButton(s1, "RealKid hub", "https://raw.githubusercontent.com/realkidhub/realkid/refs/heads/main/main.lua")
CreateButton(s1, "Longhihi", "https://raw.githubusercontent.com/longhihilonghihi-hub/BananaHub/refs/heads/main/CombackVersion")
CreateButton(s1, "Binn Banana hub", "https://raw.githubusercontent.com/Binn-nguyen/Banana-Hub/refs/heads/main/Phucdepzai-Banana.lua")
CreateButton(s1, "NatAov Hub (Marines)", "https://raw.githubusercontent.com/Dev-AnhTuansitink/NatAov-Hub/refs/heads/main/ILoveYou.lua")
CreateButton(s1, "Orange Hub", "https://raw.githubusercontent.com/HieuDepTrai-Z/Dev_Orange/refs/heads/main/OrangeHub.lua")
CreateButton(s1, "Neji Hub", "https://raw.githubusercontent.com/Dev-NejiDepzai/Bloxfruits/refs/heads/main/Main.lua")

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
CreateButton(s2, "Andepzai hub", "https://raw.githubusercontent.com/DarkMuscles/Games/Roblox/Bloxfruits/AnDepZaiHub.lua")
CreateButton(s2, "NatAov Kaitun BF", "https://raw.githubusercontent.com/Dev-AnhTuansitink/NatAov-Hub/refs/heads/main/NatAovKaitunBF.lua")

-- TAB 2: Garden
local Tab2 = CreateTab("Garden", 1)
local s3 = AddSection(Tab2, "Main")
CreateButton(s3, "Speed hub (có key)", "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua")
CreateButton(s3, "Hoshi hub (có key)", "https://script.roscripts.io/mzMEwEq")
CreateButton(s3, "Library hub (không key)", "https://raw.githubusercontent.com/Wonik99/library-hub/refs/heads/main/growagarden2")
CreateButton(s3, "Fake robux (có key)", "https://pastefy.app/rxGKgtBB/raw")
CreateButton(s3, "UB hub (no key)", "https://raw.githubusercontent.com/TeamUBHub/UBLoader/refs/heads/main/index/Key.lua")

-- TAB 3: 99 Night
local Tab3 = CreateTab("99 Night", 2)
local s4 = AddSection(Tab3, "Main")
CreateButton(s4, "Void ware (no key)", "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua")
CreateButton(s4, "foxnamehub (no key)", "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua")
CreateButton(s4, "Raygull stable (no key)", "https://raw.githubusercontent.com/raygull3d/99-Nights-in-the-Forest-Script/refs/heads/main/99%20Days%20Scirpt%20By%20Raygull.lua")
CreateButton(s4, "Toasty XD hub (có key)", "https://raw.githubusercontent.com/nouralddin-abdullah/ToastyHub-XD/refs/heads/main/hub-main.lua")
CreateButton(s4, "H4x (no key key)", "https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader.lua")
