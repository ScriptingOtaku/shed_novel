local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local ChoiceButton = Roact.Component:extend("ChoiceButton")

function ChoiceButton:init()
    
end

function ChoiceButton:render()
    return Roact.createElement("TextButton", {
        BackgroundColor3 = Color3.fromRGB(229, 206, 194),
        Size = UDim2.new(0.87, 0, .3, 0),
        Text = self.props.choice_text,
        TextScaled = true,
        TextColor3 = Color3.fromRGB(152, 136, 132),
        TextWrapped = true,
        Font = Enum.Font.Arial,
        [Roact.Event.Activated] = function()
            self.props.on_click(self.props.choice_text, self.props.choice_index)
        end,
    }, {
        UICorner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 15),
        }),
        UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
            MaxTextSize = 50,
        }),
    })
end

return ChoiceButton