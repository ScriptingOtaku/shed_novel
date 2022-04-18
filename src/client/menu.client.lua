local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local StoryHandler = require(script.Parent:WaitForChild("StoryHandler"))

local mount = nil

mount = Roact.mount(Roact.createElement("ScreenGui", {
    IgnoreGuiInset = true
}, {
    Roact.createElement("TextButton", {
        Text = "Start Story",
        Size = UDim2.new(1, 0, 1, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        TextSize = 30,
        BackgroundColor3 = Color3.new(1, 1, 1),
        TextColor3 = Color3.new(0, 0, 0),
        [Roact.Event.Activated] = function()
            StoryHandler:start("Book")
            Roact.unmount(mount)
            mount = nil
        end,
    })
}), game.Players.LocalPlayer.PlayerGui)