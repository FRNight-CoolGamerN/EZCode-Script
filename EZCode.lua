-- EZCode Quantum Loading & Authentication System
-- Complete flow: Loading → Key Validation → Hack Universe with 50 Scripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer

-- Quantum Configuration
local LOADING_TIME = 4 -- Faster loading for better UX
local API_KEY = "6b2fc9ac-e3fc-46f3-bca2-3807c26583ae"
local API_URL = "https://junkie-development.de/api/validate"
local KEY_WEBSITE = "https://junkie-development.de/overview/ezcode"
local BACKGROUND_IMAGE = "https://i.ibb.co/d0r2g94d/background.jpg"

-- State Management
local elapsed = 0
local progress = 0
local ringAngle = 0
local glowIntensity = 0
local glowUp = true
local currentScreen = "loading" -- loading, key, main

-- ===========================================================================
-- QUANTUM SCRIPT DATABASE - 50 DIFFERENT NAMED SCRIPTS
-- ===========================================================================
local QuantumScripts = {
    ["🚪 DOORS"] = {
        {name = "🚪 Ostium Reborn", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/doors_ostium.lua'))()"},
        {name = "🚪 Seek ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/doors_seek_esp.lua'))()"},
        {name = "🚪 Auto Doors", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_doors.lua'))()"},
        {name = "🚪 Figure ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/figure_esp.lua'))()"},
        {name = "🚪 Rush Radar", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/rush_radar.lua'))()"},
        {name = "🚪 Ambush Alert", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/ambush_alert.lua'))()"},
        {name = "🚪 Doors God Mode", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/doors_god.lua'))()"},
        {name = "🚪 Speed Run", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/doors_speed.lua'))()"}
    },
    
    ["🔫 ARSENAL"] = {
        {name = "🔫 Arsenal AimBot", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/arsenal_aim.lua'))()"},
        {name = "🔫 Silent Aim", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/silent_aim.lua'))()"},
        {name = "🔫 Wall Hack", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/arsenal_wallhack.lua'))()"},
        {name = "🔫 ESP Vision", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/arsenal_esp.lua'))()"},
        {name = "🔫 Speed Hack", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/arsenal_speed.lua'))()"},
        {name = "🔫 No Recoil", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/no_recoil.lua'))()"},
        {name = "🔫 Instant Kill", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/instant_kill.lua'))()"}
    },
    
    ["🌐 UNIVERSAL"] = {
        {name = "🌐 Infinite Yield", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()"},
        {name = "🌐 CMD-X", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source'))()"},
        {name = "🌐 Dark Dex V4", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/dark_dex.lua'))()"},
        {name = "🌐 Simple Spy", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/simple_spy.lua'))()"},
        {name = "🌐 Remote Spy", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/remote_spy.lua'))()"},
        {name = "🌐 FPS Boost", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/fps_boost.lua'))()"},
        {name = "🌐 Anti AFK", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/anti_afk.lua'))()"},
        {name = "🌐 Chat Logger", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/chat_logger.lua'))()"}
    },
    
    ["🍎 BLOX FRUITS"] = {
        {name = "🍎 Auto Farm", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/blox_auto_farm.lua'))()"},
        {name = "🍎 Boss Farm", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/boss_farm.lua'))()"},
        {name = "🍎 Instant Kill", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/blox_instant_kill.lua'))()"},
        {name = "🍎 Teleport", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/blox_teleport.lua'))()"},
        {name = "🍎 Fruit Notifier", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/fruit_notifier.lua'))()"},
        {name = "🍎 Auto Raid", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_raid.lua'))()"}
    },
    
    ["🐾 PET SIMULATOR X"] = {
        {name = "🐾 Auto Hatch", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/petsim_hatch.lua'))()"},
        {name = "🐾 Damage Hack", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/petsim_damage.lua'))()"},
        {name = "🐾 Auto Farm", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/petsim_farm.lua'))()"},
        {name = "🐾 Coin Farm", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/coin_farm.lua'))()"},
        {name = "🐾 Teleport Farm", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/teleport_farm.lua'))()"}
    },
    
    ["🏠 BROOKHAVEN"] = {
        {name = "🏠 Money Farm", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/brookhaven_farm.lua'))()"},
        {name = "🏠 Speed Hack", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/brookhaven_speed.lua'))()"},
        {name = "🏠 Car Spawner", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/brookhaven_cars.lua'))()"},
        {name = "🏠 House TP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/house_tp.lua'))()"}
    },
    
    ["🚓 JAILBREAK"] = {
        {name = "🚓 Auto Arrest", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/jailbreak_arrest.lua'))()"},
        {name = "🚓 Money Farm", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/jailbreak_money.lua'))()"},
        {name = "🚓 Car Speed", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/jailbreak_speed.lua'))()"},
        {name = "🚓 Prison Escape", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/prison_escape.lua'))()"}
    },
    
    ["🔪 MURDER MYSTERY 2"] = {
        {name = "🔪 ESP + Aim", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/mm2_esp.lua'))()"},
        {name = "🔪 Auto Win", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/mm2_auto.lua'))()"},
        {name = "🔪 Murderer Finder", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/murderer_finder.lua'))()"},
        {name = "🔪 Gun Mods", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/gun_mods.lua'))()"}
    },
    
    ["🐶 ADOPT ME"] = {
        {name = "🐶 Auto Farm Bucks", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/adoptme_farm.lua'))()"},
        {name = "🐶 Pet Dupe", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/adoptme_dupe.lua'))()"},
        {name = "🐶 Auto Age", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_age.lua'))()"},
        {name = "🐶 Trade Scam", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/trade_scam.lua'))()"}
    }
}

-- Main GUI Container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EZCodeQuantumSystem"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- ===========================================================================
-- QUANTUM LOADING SCREEN - FULLY DRAGGABLE
-- ===========================================================================
local LoaderContainer = Instance.new("Frame")
LoaderContainer.Name = "QuantumLoader"
LoaderContainer.Size = UDim2.new(0, 800, 0, 600) -- Fixed size for dragging
LoaderContainer.Position = UDim2.new(0.5, -400, 0.5, -300)
LoaderContainer.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
LoaderContainer.BorderSizePixel = 0
LoaderContainer.ZIndex = 10
LoaderContainer.Parent = ScreenGui

-- Add a subtle border to show draggable area
local LoaderBorder = Instance.new("UIStroke")
LoaderBorder.Color = Color3.fromRGB(122, 162, 255)
LoaderBorder.Thickness = 2
LoaderBorder.Transparency = 0.3
LoaderBorder.Parent = LoaderContainer

local LoaderCorner = Instance.new("UICorner")
LoaderCorner.CornerRadius = UDim.new(0, 15)
LoaderCorner.Parent = LoaderContainer

-- Background Elements
local GradientFrame = Instance.new("Frame")
GradientFrame.Name = "QuantumGradient"
GradientFrame.Size = UDim2.new(1, 0, 1, 0)
GradientFrame.BackgroundColor3 = Color3.fromRGB(1, 1, 3)
GradientFrame.BorderSizePixel = 0
GradientFrame.ZIndex = 1
GradientFrame.Parent = LoaderContainer

local GradientCorner = Instance.new("UICorner")
GradientCorner.CornerRadius = UDim.new(0, 15)
GradientCorner.Parent = GradientFrame

local ParticleContainer = Instance.new("Frame")
ParticleContainer.Name = "ParticleField"
ParticleContainer.Size = UDim2.new(1, 0, 1, 0)
ParticleContainer.BackgroundTransparency = 1
ParticleContainer.ZIndex = 2
ParticleContainer.Parent = LoaderContainer

-- Create floating particles
local particles = {}
for i = 1, 15 do
    local particle = Instance.new("Frame")
    particle.Name = "QuantumParticle_" .. i
    particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
    particle.Position = UDim2.new(0, math.random(0, 800), 0, math.random(0, 600))
    particle.BackgroundColor3 = Color3.fromRGB(122, 162, 255)
    particle.BackgroundTransparency = math.random(5, 8) / 10
    particle.BorderSizePixel = 0
    particle.ZIndex = 2
    particle.Parent = ParticleContainer
    
    particles[i] = {
        instance = particle,
        speed = math.random(10, 30),
        angle = math.random(0, 360),
        radius = math.random(5, 20)
    }
end

-- Loading Content
local LoaderContent = Instance.new("Frame")
LoaderContent.Name = "LoaderContent"
LoaderContent.Size = UDim2.new(1, -40, 1, -40)
LoaderContent.Position = UDim2.new(0, 20, 0, 20)
LoaderContent.BackgroundTransparency = 1
LoaderContent.ZIndex = 5
LoaderContent.Parent = LoaderContainer

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "QuantumTitle"
TitleLabel.Size = UDim2.new(1, 0, 0, 60)
TitleLabel.Position = UDim2.new(0, 0, 0, 50)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "EZCODE QUANTUM"
TitleLabel.TextColor3 = Color3.fromRGB(122, 162, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 42
TitleLabel.TextStrokeTransparency = 0.7
TitleLabel.ZIndex = 5
TitleLabel.Parent = LoaderContent

local LoadingText = Instance.new("TextLabel")
LoadingText.Name = "LoadingStatus"
LoadingText.Size = UDim2.new(1, 0, 0, 30)
LoadingText.Position = UDim2.new(0, 0, 0, 400)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "INITIALIZING QUANTUM SYSTEMS..."
LoadingText.TextColor3 = Color3.fromRGB(200, 210, 230)
LoadingText.Font = Enum.Font.Gotham
LoadingText.TextSize = 16
LoadingText.ZIndex = 5
LoadingText.Parent = LoaderContent

local ProgressBarContainer = Instance.new("Frame")
ProgressBarContainer.Name = "ProgressBarContainer"
ProgressBarContainer.Size = UDim2.new(0, 500, 0, 20)
ProgressBarContainer.Position = UDim2.new(0.5, -250, 0, 350)
ProgressBarContainer.BackgroundTransparency = 1
ProgressBarContainer.ZIndex = 5
ProgressBarContainer.Parent = LoaderContent

local ProgressBarBackground = Instance.new("Frame")
ProgressBarBackground.Name = "ProgressBarBG"
ProgressBarBackground.Size = UDim2.new(1, 0, 1, 0)
ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ProgressBarBackground.BackgroundTransparency = 0.4
ProgressBarBackground.BorderSizePixel = 0
ProgressBarBackground.ZIndex = 5
ProgressBarBackground.Parent = ProgressBarContainer

local ProgressBarCorner = Instance.new("UICorner")
ProgressBarCorner.CornerRadius = UDim.new(0, 10)
ProgressBarCorner.Parent = ProgressBarBackground

local ProgressBarFill = Instance.new("Frame")
ProgressBarFill.Name = "ProgressBarFill"
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(122, 162, 255)
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.ZIndex = 6
ProgressBarFill.Parent = ProgressBarContainer

local ProgressFillCorner = Instance.new("UICorner")
ProgressFillCorner.CornerRadius = UDim.new(0, 10)
ProgressFillCorner.Parent = ProgressBarFill

-- ===========================================================================
-- QUANTUM KEY VALIDATION SCREEN - FULLY DRAGGABLE
-- ===========================================================================
local KeyContainer = Instance.new("Frame")
KeyContainer.Name = "QuantumKeySystem"
KeyContainer.Size = UDim2.new(0, 600, 0, 500) -- Fixed size for dragging
KeyContainer.Position = UDim2.new(0.5, -300, 0.5, -250)
KeyContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
KeyContainer.BackgroundTransparency = 0.1
KeyContainer.BorderSizePixel = 0
KeyContainer.Visible = false
KeyContainer.ZIndex = 10
KeyContainer.Parent = ScreenGui

-- Add border to show draggable area
local KeyBorder = Instance.new("UIStroke")
KeyBorder.Color = Color3.fromRGB(122, 162, 255)
KeyBorder.Thickness = 2
KeyBorder.Transparency = 0.3
KeyBorder.Parent = KeyContainer

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 15)
KeyCorner.Parent = KeyContainer

local KeyBackground = Instance.new("ImageLabel")
KeyBackground.Name = "KeyBackground"
KeyBackground.Size = UDim2.new(1, 0, 1, 0)
KeyBackground.Image = BACKGROUND_IMAGE
KeyBackground.ScaleType = Enum.ScaleType.Crop
KeyBackground.BackgroundTransparency = 1
KeyBackground.ZIndex = 9
KeyBackground.Parent = KeyContainer

local KeyBackgroundCorner = Instance.new("UICorner")
KeyBackgroundCorner.CornerRadius = UDim.new(0, 15)
KeyBackgroundCorner.Parent = KeyBackground

local KeyOverlay = Instance.new("Frame")
KeyOverlay.Name = "KeyOverlay"
KeyOverlay.Size = UDim2.new(1, 0, 1, 0)
KeyOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
KeyOverlay.BackgroundTransparency = 0.6
KeyOverlay.ZIndex = 10
KeyOverlay.Parent = KeyContainer

local KeyOverlayCorner = Instance.new("UICorner")
KeyOverlayCorner.CornerRadius = UDim.new(0, 15)
KeyOverlayCorner.Parent = KeyOverlay

local KeyContent = Instance.new("Frame")
KeyContent.Name = "KeyContent"
KeyContent.Size = UDim2.new(1, -40, 1, -40)
KeyContent.Position = UDim2.new(0, 20, 0, 20)
KeyContent.BackgroundTransparency = 1
KeyContent.ZIndex = 11
KeyContent.Parent = KeyContainer

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Name = "KeyTitle"
KeyTitle.Size = UDim2.new(1, 0, 0, 50)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "QUANTUM ACCESS"
KeyTitle.TextColor3 = Color3.fromRGB(122, 162, 255)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 28
KeyTitle.ZIndex = 11
KeyTitle.Parent = KeyContent

local KeySubtitle = Instance.new("TextLabel")
KeySubtitle.Name = "KeySubtitle"
KeySubtitle.Size = UDim2.new(1, 0, 0, 30)
KeySubtitle.Position = UDim2.new(0, 0, 0, 50)
KeySubtitle.BackgroundTransparency = 1
KeySubtitle.Text = "Enter your quantum access key from website"
KeySubtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
KeySubtitle.Font = Enum.Font.Gotham
KeySubtitle.TextSize = 14
KeySubtitle.ZIndex = 11
KeySubtitle.Parent = KeyContent

local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Size = UDim2.new(1, -40, 0, 50)
KeyInput.Position = UDim2.new(0, 20, 0, 120)
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
KeyInput.BackgroundTransparency = 0.3
KeyInput.PlaceholderText = "Paste your EZCode key from website..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 16
KeyInput.ZIndex = 11
KeyInput.Parent = KeyContent

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 8)
KeyInputCorner.Parent = KeyInput

local WebsiteButton = Instance.new("TextButton")
WebsiteButton.Name = "WebsiteButton"
WebsiteButton.Size = UDim2.new(0, 300, 0, 45)
WebsiteButton.Position = UDim2.new(0.5, -150, 0, 190)
WebsiteButton.BackgroundColor3 = Color3.fromRGB(92, 122, 234)
WebsiteButton.Text = "GET KEY FROM WEBSITE"
WebsiteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
WebsiteButton.Font = Enum.Font.GothamBold
WebsiteButton.TextSize = 14
WebsiteButton.ZIndex = 11
WebsiteButton.Parent = KeyContent

local WebsiteCorner = Instance.new("UICorner")
WebsiteCorner.CornerRadius = UDim.new(0, 8)
WebsiteCorner.Parent = WebsiteButton

local ValidateButton = Instance.new("TextButton")
ValidateButton.Name = "ValidateButton"
ValidateButton.Size = UDim2.new(0, 250, 0, 45)
ValidateButton.Position = UDim2.new(0.5, -125, 0, 250)
ValidateButton.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
ValidateButton.Text = "VALIDATE QUANTUM KEY"
ValidateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ValidateButton.Font = Enum.Font.GothamBold
ValidateButton.TextSize = 14
ValidateButton.ZIndex = 11
ValidateButton.Parent = KeyContent

local ValidateCorner = Instance.new("UICorner")
ValidateCorner.CornerRadius = UDim.new(0, 8)
ValidateCorner.Parent = ValidateButton

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 320)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Visit website to get your key"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.ZIndex = 11
StatusLabel.Parent = KeyContent

local WebsiteLink = Instance.new("TextLabel")
WebsiteLink.Name = "WebsiteLink"
WebsiteLink.Size = UDim2.new(1, 0, 0, 20)
WebsiteLink.Position = UDim2.new(0, 0, 0, 350)
WebsiteLink.BackgroundTransparency = 1
WebsiteLink.Text = KEY_WEBSITE
WebsiteLink.TextColor3 = Color3.fromRGB(100, 150, 255)
WebsiteLink.Font = Enum.Font.Gotham
WebsiteLink.TextSize = 11
WebsiteLink.ZIndex = 11
WebsiteLink.Parent = KeyContent

-- ===========================================================================
-- MAIN HACK UNIVERSE INTERFACE - FULLY DRAGGABLE WITH 50 SCRIPTS
-- ===========================================================================
local MainContainer = Instance.new("Frame")
MainContainer.Name = "QuantumHackUniverse"
MainContainer.Size = UDim2.new(0, 900, 0, 700) -- Fixed size for dragging
MainContainer.Position = UDim2.new(0.5, -450, 0.5, -350)
MainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainContainer.BackgroundTransparency = 0.1
MainContainer.BorderSizePixel = 0
MainContainer.Visible = false
MainContainer.ZIndex = 10
MainContainer.Parent = ScreenGui

-- Add border to show draggable area
local MainBorder = Instance.new("UIStroke")
MainBorder.Color = Color3.fromRGB(122, 162, 255)
MainBorder.Thickness = 2
MainBorder.Transparency = 0.3
MainBorder.Parent = MainContainer

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainContainer

-- ===========================================================================
-- QUANTUM VALIDATION SYSTEM
-- ===========================================================================
local function validateQuantumKey(key)
    local success, result = pcall(function()
        local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
        local response = game:HttpGet(API_URL .. "?key=" .. key .. "&hwid=" .. hwid .. "&user=" .. localPlayer.UserId .. "&script=ezcode")
        return response
    end)
    
    if success then
        return result == "valid" or result:find("success") or result:find("true") or result:find("active")
    end
    return false
end

-- ===========================================================================
-- ANIMATION SYSTEM
-- ===========================================================================
local function updateLoadingAnimation(dt)
    elapsed = math.min(elapsed + dt, LOADING_TIME)
    progress = elapsed / LOADING_TIME
    
    ringAngle = (ringAngle + dt * 2) % (2 * math.pi)
    
    if glowUp then
        glowIntensity = math.min(glowIntensity + dt * 0.8, 1)
        if glowIntensity >= 1 then glowUp = false end
    else
        glowIntensity = math.max(glowIntensity - dt * 0.8, 0)
        if glowIntensity <= 0 then glowUp = true end
    end
    
    -- Update title glow
    local blueIntensity = 0.48 + 0.2 * glowIntensity
    TitleLabel.TextColor3 = Color3.fromRGB(
        math.floor(122 * blueIntensity),
        math.floor(162 * blueIntensity), 
        255
    )
    
    -- Update progress bar
    ProgressBarFill.Size = UDim2.new(progress, 0, 1, 0)
    
    -- Update loading text
    local percent = math.floor(progress * 100)
    local statusMessages = {
        "INITIALIZING QUANTUM SYSTEMS...",
        "LOADING SECURITY PROTOCOLS...", 
        "ESTABLISHING CONNECTION...",
        "PREPARING HACK UNIVERSE..."
    }
    local messageIndex = math.floor(progress * #statusMessages) + 1
    LoadingText.Text = statusMessages[math.min(messageIndex, #statusMessages)] .. " " .. percent .. "%"
    
    -- Update particle animations
    for _, particle in ipairs(particles) do
        local currentTime = tick()
        local xOffset = math.cos(currentTime / particle.speed + particle.angle) * particle.radius
        local yOffset = math.sin(currentTime / particle.speed + particle.angle) * particle.radius
        particle.instance.Position = UDim2.new(
            0, (particle.instance.Position.X.Offset + xOffset) % 800,
            0, (particle.instance.Position.Y.Offset + yOffset) % 600
        )
    end
end

-- ===========================================================================
-- DRAGGABLE GUI SYSTEM
-- ===========================================================================
local function makeDraggable(gui)
    local dragging = false
    local dragInput, dragStart, startPos
    
    -- Make entire GUI draggable
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Make all containers draggable
makeDraggable(LoaderContainer)
makeDraggable(KeyContainer)
makeDraggable(MainContainer)

-- ===========================================================================
-- SCREEN TRANSITION SYSTEM
-- ===========================================================================
local function transitionToKeyScreen()
    currentScreen = "key"
    
    -- Fade out loading screen
    local fadeOut = TweenService:Create(
        LoaderContainer,
        TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    )
    
    fadeOut:Play()
    fadeOut.Completed:Connect(function()
        LoaderContainer.Visible = false
        
        -- Fade in key screen
        KeyContainer.Visible = true
        KeyContainer.BackgroundTransparency = 1
        local fadeIn = TweenService:Create(
            KeyContainer,
            TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.1}
        )
        fadeIn:Play()
    end)
end

local function transitionToHackUniverse()
    currentScreen = "main"
    
    -- Fade out key screen
    local fadeOut = TweenService:Create(
        KeyContainer,
        TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    )
    
    fadeOut:Play()
    fadeOut.Completed:Connect(function()
        KeyContainer.Visible = false
        
        -- Fade in main hack universe
        MainContainer.Visible = true
        MainContainer.BackgroundTransparency = 1
        local fadeIn = TweenService:Create(
            MainContainer,
            TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.1}
        )
        fadeIn:Play()
        
        -- Load all hacks after transition
        loadAllHacks()
    end)
end

-- ===========================================================================
-- HACK UNIVERSE LOADING SYSTEM WITH 50 SCRIPTS
-- ===========================================================================

-- ===========================================================================
-- FIXED HACK UNIVERSE INTERFACE WITH EXPANDED SCRIPTS
-- ===========================================================================

local function loadAllHacks()
    print("QUANTUM HACK UNIVERSE ACTIVATED!")
    print("Loading expanded script database with 100+ scripts...")
    
    -- Clear any existing content
    for _, child in pairs(MainContainer:GetChildren()) do
        child:Destroy()
    end

    -- Main background
    local MainBackground = Instance.new("ImageLabel")
    MainBackground.Name = "MainBackground"
    MainBackground.Size = UDim2.new(1, 0, 1, 0)
    MainBackground.Image = BACKGROUND_IMAGE
    MainBackground.ScaleType = Enum.ScaleType.Crop
    MainBackground.BackgroundTransparency = 1
    MainBackground.ZIndex = 1
    MainBackground.Parent = MainContainer

    local MainOverlay = Instance.new("Frame")
    MainOverlay.Name = "MainOverlay"
    MainOverlay.Size = UDim2.new(1, 0, 1, 0)
    MainOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainOverlay.BackgroundTransparency = 0.7
    MainOverlay.ZIndex = 2
    MainOverlay.Parent = MainContainer

    -- Header with Player Info
    local Header = Instance.new("Frame")
    Header.Name = "MainHeader"
    Header.Size = UDim2.new(1, -40, 0, 100)
    Header.Position = UDim2.new(0, 20, 0, 20)
    Header.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Header.BackgroundTransparency = 0.3
    Header.ZIndex = 10
    Header.Parent = MainContainer

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header

    local HeaderStroke = Instance.new("UIStroke")
    HeaderStroke.Color = Color3.fromRGB(122, 162, 255)
    HeaderStroke.Thickness = 2
    HeaderStroke.Transparency = 0.3
    HeaderStroke.Parent = Header

    -- Player Info Section
    local PlayerInfo = Instance.new("Frame")
    PlayerInfo.Name = "PlayerInfo"
    PlayerInfo.Size = UDim2.new(0, 300, 1, 0)
    PlayerInfo.BackgroundTransparency = 1
    PlayerInfo.Position = UDim2.new(0, 20, 0, 0)
    PlayerInfo.ZIndex = 11
    PlayerInfo.Parent = Header

    local PlayerAvatar = Instance.new("ImageLabel")
    PlayerAvatar.Name = "PlayerAvatar"
    PlayerAvatar.Size = UDim2.new(0, 60, 0, 60)
    PlayerAvatar.Position = UDim2.new(0, 0, 0.5, -30)
    PlayerAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. localPlayer.UserId .. "&width=420&height=420&format=png"
    PlayerAvatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerAvatar.BorderSizePixel = 0
    PlayerAvatar.ZIndex = 11
    PlayerAvatar.Parent = PlayerInfo

    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(0, 8)
    AvatarCorner.Parent = PlayerAvatar

    local PlayerName = Instance.new("TextLabel")
    PlayerName.Name = "PlayerName"
    PlayerName.Size = UDim2.new(0, 200, 0, 25)
    PlayerName.Position = UDim2.new(0, 70, 0, 20)
    PlayerName.BackgroundTransparency = 1
    PlayerName.Text = "Player: " .. localPlayer.Name
    PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerName.Font = Enum.Font.GothamBold
    PlayerName.TextSize = 16
    PlayerName.TextXAlignment = Enum.TextXAlignment.Left
    PlayerName.ZIndex = 11
    PlayerName.Parent = PlayerInfo

    local PlayerID = Instance.new("TextLabel")
    PlayerID.Name = "PlayerID"
    PlayerID.Size = UDim2.new(0, 200, 0, 20)
    PlayerID.Position = UDim2.new(0, 70, 0, 45)
    PlayerID.BackgroundTransparency = 1
    PlayerID.Text = "ID: " .. localPlayer.UserId
    PlayerID.TextColor3 = Color3.fromRGB(200, 200, 200)
    PlayerID.Font = Enum.Font.Gotham
    PlayerID.TextSize = 12
    PlayerID.TextXAlignment = Enum.TextXAlignment.Left
    PlayerID.ZIndex = 11
    PlayerID.Parent = PlayerInfo

    -- Title Section
    local TitleSection = Instance.new("Frame")
    TitleSection.Name = "TitleSection"
    TitleSection.Size = UDim2.new(0, 400, 1, 0)
    TitleSection.Position = UDim2.new(0.5, -200, 0, 0)
    TitleSection.BackgroundTransparency = 1
    TitleSection.ZIndex = 11
    TitleSection.Parent = Header

    local MainTitle = Instance.new("TextLabel")
    MainTitle.Name = "MainTitle"
    MainTitle.Size = UDim2.new(1, 0, 0, 40)
    MainTitle.Position = UDim2.new(0, 0, 0, 10)
    MainTitle.BackgroundTransparency = 1
    MainTitle.Text = "EZCODE QUANTUM HUB"
    MainTitle.TextColor3 = Color3.fromRGB(122, 162, 255)
    MainTitle.Font = Enum.Font.GothamBold
    MainTitle.TextSize = 24
    MainTitle.ZIndex = 11
    MainTitle.Parent = TitleSection

    local SubTitle = Instance.new("TextLabel")
    SubTitle.Name = "SubTitle"
    SubTitle.Size = UDim2.new(1, 0, 0, 20)
    SubTitle.Position = UDim2.new(0, 0, 0, 50)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = "100+ Quantum Scripts Loaded & Ready"
    SubTitle.TextColor3 = Color3.fromRGB(200, 210, 255)
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.TextSize = 14
    SubTitle.ZIndex = 11
    SubTitle.Parent = TitleSection

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 40, 0, 40)
    CloseButton.Position = UDim2.new(1, -50, 0.5, -20)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 18
    CloseButton.ZIndex = 11
    CloseButton.Parent = Header

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Main Content Area
    local MainContent = Instance.new("Frame")
    MainContent.Name = "MainContent"
    MainContent.Size = UDim2.new(1, -40, 1, -140)
    MainContent.Position = UDim2.new(0, 20, 0, 120)
    MainContent.BackgroundTransparency = 1
    MainContent.ZIndex = 5
    MainContent.Parent = MainContainer

    -- Left Side - Scrollable Tabs Container
    local TabsScrollContainer = Instance.new("ScrollingFrame")
    TabsScrollContainer.Name = "TabsScrollContainer"
    TabsScrollContainer.Size = UDim2.new(0, 250, 1, 0)
    TabsScrollContainer.Position = UDim2.new(0, 0, 0, 0)
    TabsScrollContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    TabsScrollContainer.BackgroundTransparency = 0.3
    TabsScrollContainer.ScrollBarThickness = 6
    TabsScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(122, 162, 255)
    TabsScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabsScrollContainer.ZIndex = 6
    TabsScrollContainer.Parent = MainContent

    local TabsCorner = Instance.new("UICorner")
    TabsCorner.CornerRadius = UDim.new(0, 12)
    TabsCorner.Parent = TabsScrollContainer

    local TabsStroke = Instance.new("UIStroke")
    TabsStroke.Color = Color3.fromRGB(122, 162, 255)
    TabsStroke.Thickness = 2
    TabsStroke.Transparency = 0.3
    TabsStroke.Parent = TabsScrollContainer

    -- Right Side - Scrollable Scripts Container
    local ScriptsScrollContainer = Instance.new("ScrollingFrame")
    ScriptsScrollContainer.Name = "ScriptsScrollContainer"
    ScriptsScrollContainer.Size = UDim2.new(0, 570, 1, 0)
    ScriptsScrollContainer.Position = UDim2.new(0, 270, 0, 0)
    ScriptsScrollContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    ScriptsScrollContainer.BackgroundTransparency = 0.3
    ScriptsScrollContainer.ScrollBarThickness = 6
    ScriptsScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(122, 162, 255)
    ScriptsScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScriptsScrollContainer.ZIndex = 6
    ScriptsScrollContainer.Parent = MainContent

    local ScriptsCorner = Instance.new("UICorner")
    ScriptsCorner.CornerRadius = UDim.new(0, 12)
    ScriptsCorner.Parent = ScriptsScrollContainer

    local ScriptsStroke = Instance.new("UIStroke")
    ScriptsStroke.Color = Color3.fromRGB(122, 162, 255)
    ScriptsStroke.Thickness = 2
    ScriptsStroke.Transparency = 0.3
    ScriptsStroke.Parent = ScriptsScrollContainer

    -- Expanded Quantum Script Database - 100+ SCRIPTS
    local ExpandedQuantumScripts = {
        ["🚪 DOORS SCRIPTS"] = {
            {name = "🚪 Ostium Reborn V3", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/doors_ostium.lua'))()"},
            {name = "🚪 Seek ESP Ultimate", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/doors_seek_esp.lua'))()"},
            {name = "🚪 Auto Doors Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_doors.lua'))()"},
            {name = "🚪 Figure ESP Advanced", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/figure_esp.lua'))()"},
            {name = "🚪 Rush Radar System", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/rush_radar.lua'))()"},
            {name = "🚪 Ambush Alert Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/ambush_alert.lua'))()"},
            {name = "🚪 God Mode Ultimate", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/doors_god.lua'))()"},
            {name = "🚪 Speed Run Hack", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/doors_speed.lua'))()"},
            {name = "🚪 Auto Collect Items", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_collect.lua'))()"},
            {name = "🚪 Doors Full ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/doors_full_esp.lua'))()"}
        },
        
        ["🔫 ARSENAL HACKS"] = {
            {name = "🔫 Arsenal AimBot Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/arsenal_aim.lua'))()"},
            {name = "🔫 Silent Aim Ultimate", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/silent_aim.lua'))()"},
            {name = "🔫 Wall Hack Vision", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/arsenal_wallhack.lua'))()"},
            {name = "🔫 ESP Vision Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/arsenal_esp.lua'))()"},
            {name = "🔫 Speed Hack Ultra", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/arsenal_speed.lua'))()"},
            {name = "🔫 No Recoil Master", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/no_recoil.lua'))()"},
            {name = "🔫 Instant Kill God", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/instant_kill.lua'))()"},
            {name = "🔫 Auto Headshot", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_headshot.lua'))()"},
            {name = "🔫 Trigger Bot", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/trigger_bot.lua'))()"},
            {name = "🔫 Skin Changer", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/skin_changer.lua'))()"}
        },
        
        ["🌐 UNIVERSAL TOOLS"] = {
            {name = "🌐 Infinite Yield V7", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()"},
            {name = "🌐 CMD-X Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source'))()"},
            {name = "🌐 Dark Dex V5", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/dark_dex.lua'))()"},
            {name = "🌐 Simple Spy Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/simple_spy.lua'))()"},
            {name = "🌐 Remote Spy Elite", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/remote_spy.lua'))()"},
            {name = "🌐 FPS Boost Ultra", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/fps_boost.lua'))()"},
            {name = "🌐 Anti AFK Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/anti_afk.lua'))()"},
            {name = "🌐 Chat Logger Plus", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/chat_logger.lua'))()"},
            {name = "🌐 Server Hop", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/server_hop.lua'))()"},
            {name = "🌐 Auto Clicker", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_clicker.lua'))()"}
        },
        
        ["🍎 BLOX FRUITS"] = {
            {name = "🍎 Auto Farm Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/blox_auto_farm.lua'))()"},
            {name = "🍎 Boss Farm Elite", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/boss_farm.lua'))()"},
            {name = "🍎 Instant Kill God", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/blox_instant_kill.lua'))()"},
            {name = "🍎 Teleport Master", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/blox_teleport.lua'))()"},
            {name = "🍎 Fruit Notifier Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/fruit_notifier.lua'))()"},
            {name = "🍎 Auto Raid Ultimate", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_raid.lua'))()"},
            {name = "🍎 Sea Events Auto", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/sea_events.lua'))()"},
            {name = "🍎 Auto Buy Haki", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_buy_haki.lua'))()"},
            {name = "🍎 Sword Master", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/sword_master.lua'))()"},
            {name = "🍎 Devil Fruit ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/devil_fruit_esp.lua'))()"}
        },
        
        ["🐾 PET SIMULATOR X"] = {
            {name = "🐾 Auto Hatch Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/petsim_hatch.lua'))()"},
            {name = "🐾 Damage Hack Ultra", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/petsim_damage.lua'))()"},
            {name = "🐾 Auto Farm Elite", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/petsim_farm.lua'))()"},
            {name = "🐾 Coin Farm Master", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/coin_farm.lua'))()"},
            {name = "🐾 Teleport Farm Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/teleport_farm.lua'))()"},
            {name = "🐾 Auto Enchant", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_enchant.lua'))()"},
            {name = "🐾 Bank Auto Deposit", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/bank_auto.lua'))()"},
            {name = "🐾 Rainbow Pet Farm", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/rainbow_farm.lua'))()"},
            {name = "🐾 Auto Trade", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_trade.lua'))()"},
            {name = "🐾 Pet Duplicator", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/pet_duplicator.lua'))()"}
        },
        
        ["🏠 BROOKHAVEN RP"] = {
            {name = "🏠 Money Farm Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/brookhaven_farm.lua'))()"},
            {name = "🏠 Speed Hack Elite", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/brookhaven_speed.lua'))()"},
            {name = "🏠 Car Spawner Plus", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/brookhaven_cars.lua'))()"},
            {name = "🏠 House TP Master", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/house_tp.lua'))()"},
            {name = "🏠 Auto Roleplay", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_rp.lua'))()"},
            {name = "🏠 Furniture Spawner", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/furniture_spawner.lua'))()"},
            {name = "🏠 Plot Claimer", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/plot_claimer.lua'))()"},
            {name = "🏠 Money Printer", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/money_printer.lua'))()"},
            {name = "🏠 Vehicle Modder", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/vehicle_modder.lua'))()"},
            {name = "🏠 Anti Report", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/anti_report.lua'))()"}
        },
        
        ["🚓 JAILBREAK HACKS"] = {
            {name = "🚓 Auto Arrest Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/jailbreak_arrest.lua'))()"},
            {name = "🚓 Money Farm Elite", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/jailbreak_money.lua'))()"},
            {name = "🚓 Car Speed Ultra", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/jailbreak_speed.lua'))()"},
            {name = "🚓 Prison Escape Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/prison_escape.lua'))()"},
            {name = "🚓 Cop Bypass", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/cop_bypass.lua'))()"},
            {name = "🚓 Bank Auto Rob", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/bank_auto_rob.lua'))()"},
            {name = "🚓 Weapon Spawner", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/weapon_spawner.lua'))()"},
            {name = "🚓 Key System Bypass", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/key_bypass.lua'))()"},
            {name = "🚓 Helicopter Fly", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/heli_fly.lua'))()"},
            {name = "🚓 No Clip Mode", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/no_clip.lua'))()"}
        },
        
        ["🔪 MM2 SCRIPTS"] = {
            {name = "🔪 ESP + Aim Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/mm2_esp.lua'))()"},
            {name = "🔪 Auto Win Elite", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/mm2_auto.lua'))()"},
            {name = "🔪 Murderer Finder", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/murderer_finder.lua'))()"},
            {name = "🔪 Gun Mods Plus", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/gun_mods.lua'))()"},
            {name = "🔪 Sheriff ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/sheriff_esp.lua'))()"},
            {name = "🔪 Auto Collect Gun", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_collect_gun.lua'))()"},
            {name = "🔪 Speed Hack MM2", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/mm2_speed.lua'))()"},
            {name = "🔪 Invisible Mode", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/invisible_mode.lua'))()"},
            {name = "🔪 Knife Aura", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/knife_aura.lua'))()"},
            {name = "🔪 Map Teleport", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/map_teleport.lua'))()"}
        },
        
        ["🐶 ADOPT ME SCRIPTS"] = {
            {name = "🐶 Auto Farm Bucks Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/adoptme_farm.lua'))()"},
            {name = "🐶 Pet Dupe Elite", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/adoptme_dupe.lua'))()"},
            {name = "🐶 Auto Age Master", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_age.lua'))()"},
            {name = "🐶 Trade Scam Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/trade_scam.lua'))()"},
            {name = "🐶 Auto Complete Tasks", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_tasks.lua'))()"},
            {name = "🐶 Mega Neon Maker", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/mega_neon.lua'))()"},
            {name = "🐶 House Builder", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/house_builder.lua'))()"},
            {name = "🐶 Vehicle Spawner", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/vehicle_spawner.lua'))()"},
            {name = "🐶 Fly Pets", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/fly_pets.lua'))()"},
            {name = "🐶 Auto Hatch Eggs", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_hatch_eggs.lua'))()"}
        },
        
        ["🎯 AIMBOT PACKS"] = {
            {name = "🎯 Universal AimBot", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/universal_aim.lua'))()"},
            {name = "🎯 Silent Aim Pack", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/silent_aim_pack.lua'))()"},
            {name = "🎯 Trigger Bot Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/trigger_bot_pro.lua'))()"},
            {name = "🎯 Auto Click Aim", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/auto_click_aim.lua'))()"},
            {name = "🎯 FOV Changer", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/fov_changer.lua'))()"},
            {name = "🎯 Smooth Aim", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/smooth_aim.lua'))()"},
            {name = "🎯 Prediction Aim", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/prediction_aim.lua'))()"},
            {name = "🎯 Legit AimBot", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/legit_aim.lua'))()"},
            {name = "🎯 Rage AimBot", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/rage_aim.lua'))()"},
            {name = "🎯 Humanized Aim", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/humanized_aim.lua'))()"}
        },
        
        ["⚡ SPEED HACKS"] = {
            {name = "⚡ Universal Speed", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/universal_speed.lua'))()"},
            {name = "⚡ Super Speed", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/super_speed.lua'))()"},
            {name = "⚡ Fly Hack Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/fly_hack.lua'))()"},
            {name = "⚡ No Clip Ultimate", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/no_clip_ultimate.lua'))()"},
            {name = "⚡ Jump Hack", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/jump_hack.lua'))()"},
            {name = "⚡ Inf Jump", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/inf_jump.lua'))()"},
            {name = "⚡ WalkSpeed Changer", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/walkspeed_changer.lua'))()"},
            {name = "⚡ SwimSpeed Hack", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/swimspeed_hack.lua'))()"},
            {name = "⚡ Vehicle Speed", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/vehicle_speed.lua'))()"},
            {name = "⚡ Teleport Hack", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/teleport_hack.lua'))()"}
        },
        
        ["🛡️ ESP PACKS"] = {
            {name = "🛡️ Universal ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/universal_esp.lua'))()"},
            {name = "🛡️ Player ESP Pro", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/player_esp.lua'))()"},
            {name = "🛡️ Item ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/item_esp.lua'))()"},
            {name = "🛡️ Chams Hack", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/chams_hack.lua'))()"},
            {name = "🛡️ X-Ray Vision", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/xray_vision.lua'))()"},
            {name = "🛡️ Name ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/name_esp.lua'))()"},
            {name = "🛡️ Health ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/health_esp.lua'))()"},
            {name = "🛡️ Distance ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/distance_esp.lua'))()"},
            {name = "🛡️ Tracers ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/tracers_esp.lua'))()"},
            {name = "🛡️ Box ESP", script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EZCodeDev/scripts/main/box_esp.lua'))()"}
        }
    }

    -- Create category tabs
    local currentCategory = "🚪 DOORS SCRIPTS"
    local tabButtons = {}
    
    local function createTabButton(categoryName, position)
        local button = Instance.new("TextButton")
        button.Name = categoryName .. "Tab"
        button.Size = UDim2.new(1, -20, 0, 45)
        button.Position = UDim2.new(0, 10, 0, position * 50)
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        button.BackgroundTransparency = 0.3
        button.Text = categoryName
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 14
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.Parent = TabsScrollContainer
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = button
        
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 15)
        padding.Parent = button
        
        button.MouseButton1Click:Connect(function()
            currentCategory = categoryName
            updateScriptDisplay()
            
            -- Update active tab visual
            for _, btn in pairs(tabButtons) do
                btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            end
            button.BackgroundColor3 = Color3.fromRGB(92, 122, 234)
        end)
        
        table.insert(tabButtons, button)
        return button
    end
    
    local function createScriptButton(scriptData, index)
        local button = Instance.new("TextButton")
        button.Name = "Script_" .. index
        button.Size = UDim2.new(1, -20, 0, 50)
        button.Position = UDim2.new(0, 10, 0, (index-1) * 60)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        button.BackgroundTransparency = 0.2
        button.Text = scriptData.name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 13
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.Parent = ScriptsScrollContainer
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = button
        
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 15)
        padding.Parent = button
        
        local executeIndicator = Instance.new("Frame")
        executeIndicator.Name = "ExecuteIndicator"
        executeIndicator.Size = UDim2.new(0, 6, 0, 6)
        executeIndicator.Position = UDim2.new(1, -15, 0.5, -3)
        executeIndicator.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        executeIndicator.BorderSizePixel = 0
        executeIndicator.Parent = button
        
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(1, 0)
        indicatorCorner.Parent = executeIndicator
        
        button.MouseButton1Click:Connect(function()
            loadstring(scriptData.script)()
            executeIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
            wait(0.5)
            executeIndicator.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        end)
    end
    
    local function updateScriptDisplay()
        -- Clear existing scripts
        for _, child in pairs(ScriptsScrollContainer:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        -- Add new scripts for current category
        if ExpandedQuantumScripts[currentCategory] then
            for i, scriptData in ipairs(ExpandedQuantumScripts[currentCategory]) do
                createScriptButton(scriptData, i)
            end
            ScriptsScrollContainer.CanvasSize = UDim2.new(0, 0, 0, #ExpandedQuantumScripts[currentCategory] * 60)
        end
    end
    
    -- Initialize tabs
    local tabIndex = 0
    for categoryName, _ in pairs(ExpandedQuantumScripts) do
        local tabButton = createTabButton(categoryName, tabIndex)
        if tabIndex == 0 then
            tabButton.BackgroundColor3 = Color3.fromRGB(92, 122, 234) -- Highlight first tab
        end
        tabIndex = tabIndex + 1
    end
    
    -- Set canvas size for tabs
    TabsScrollContainer.CanvasSize = UDim2.new(0, 0, 0, tabIndex * 50)
    
    -- Show first category by default
    updateScriptDisplay()
    
    -- Load universal scripts automatically
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    
    print("✓ Expanded Quantum Hub Loaded")
    print("✓ Player Info Displayed")
    print("✓ Scrollable Tabs & Scripts Active")
    print("✓ 100+ Scripts Ready for Execution")
end
-- ===========================================================================
-- EVENT HANDLERS
-- ===========================================================================
WebsiteButton.MouseButton1Click:Connect(function()
    setclipboard(KEY_WEBSITE)
    WebsiteButton.Text = "WEBSITE LINK COPIED!"
    StatusLabel.Text = "Status: Website link copied to clipboard!"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    wait(2)
    WebsiteButton.Text = "GET KEY FROM WEBSITE"
end)

ValidateButton.MouseButton1Click:Connect(function()
    local key = KeyInput.Text:gsub("%s+", "")
    
    if key == "" then
        StatusLabel.Text = "Status: Please enter a quantum key"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    StatusLabel.Text = "Status: Validating quantum signature..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    ValidateButton.Text = "VALIDATING..."
    
    -- Simulate validation process
    wait(1.5)
    
    if validateQuantumKey(key) then
        StatusLabel.Text = "Status: Quantum key validated! Loading hacks..."
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        ValidateButton.Text = "ACCESS GRANTED"
        
        wait(1)
        transitionToHackUniverse()
    else
        StatusLabel.Text = "Status: Invalid key - Get from website"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        ValidateButton.Text = "VALIDATE QUANTUM KEY"
        KeyInput.Text = ""
    end
end)

-- ===========================================================================
-- MAIN LOADING LOOP
-- ===========================================================================
local animationConnection
animationConnection = RunService.Heartbeat:Connect(function(dt)
    if currentScreen == "loading" then
        updateLoadingAnimation(dt)
        
        if progress >= 1 then
            animationConnection:Disconnect()
            transitionToKeyScreen()
        end
    end
end)

print("EZCode Quantum System Initialized")
print("Website: " .. KEY_WEBSITE)
print("50 Different Scripts Ready:")
print("🚪 DOORS (8 Scripts)")
print("🔫 ARSENAL (7 Scripts)")
print("🌐 UNIVERSAL (8 Scripts)")
print("🍎 BLOX FRUITS (6 Scripts)")
print("🐾 PET SIMULATOR X (5 Scripts)")
print("🏠 BROOKHAVEN (4 Scripts)")
print("🚓 JAILBREAK (4 Scripts)")
print("🔪 MURDER MYSTERY 2 (4 Scripts)")
print("🐶 ADOPT ME (4 Scripts)")
print("The universe now has access to 50 different scripts!")
