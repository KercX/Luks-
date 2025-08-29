-- Сервисы
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Блокируем Escape и Leave
ContextActionService:BindAction("BlockExit", function() 
    return Enum.ContextActionResult.Sink 
end, false, Enum.KeyCode.Escape)

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = PlayerGui

-- Фрейм на весь экран
local frame = Instance.new("Frame")
frame.Size = UDim2.new(1,0,1,0)
frame.Position = UDim2.new(0,0,0,0)
frame.BackgroundColor3 = Color3.new(0,0,0)
frame.Parent = screenGui

-- Скример изображение
local image = Instance.new("ImageLabel")
image.Size = UDim2.new(1,0,1,0)
image.Position = UDim2.new(0,0,0,0)
image.Image = "rbxassetid://9022095265" -- вставьте ID картинки
image.BackgroundTransparency = 1
image.Parent = frame

-- Скример звук
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://1835335562" -- вставьте ID звука
sound.Volume = 1
sound.Parent = frame
sound:Play()

-- Список цветов для мигания
local colors = {Color3.new(1,0,0), Color3.new(1,1,1), Color3.new(0,0,0), Color3.new(1,1,0)}

-- Динамическое мигание и звук
spawn(function()
    while true do
        frame.BackgroundColor3 = colors[math.random(1,#colors)]
        image.Visible = not image.Visible
        if math.random() < 0.3 then
            sound:Play()
        end
        wait(0.1)
    end
end)

-- Анимация приближения и случайного вращения изображения
spawn(function()
    while true do
        image.Size = UDim2.new(0,0,0,0)
        local tween = TweenService:Create(image, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Size=UDim2.new(1,0,1,0), Rotation=math.random(-30,30)})
        tween:Play()
        tween.Completed:Wait()
        wait(math.random(0.3,0.7))
    end
end)

-- Дополнительно: случайное появление маленьких изображений
spawn(function()
    while true do
        local mini = image:Clone()
        mini.Size = UDim2.new(0,100,0,100)
        mini.Position = UDim2.new(math.random(),0,math.random(),0)
        mini.Parent = frame
        local tween = TweenService:Create(mini, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size=UDim2.new(1,0,1,0), Position=UDim2.new(0,0,0,0)})
        tween:Play()
        tween.Completed:Connect(function() mini:Destroy() end)
        wait(math.random(0.5,1))
    end
end)
