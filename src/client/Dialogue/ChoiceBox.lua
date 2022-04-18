local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local ChoiceBox = Roact.Component:extend("ChoiceBox")

local ChoiceButton = require(script.Parent.ChoiceButton)

local TEXT_WAIT = 0.05
local FINISHED_WAIT = 1

function generate_choices(choices: table, onClick )
    local added = {}
    added.UIListLayout = Roact.createElement("UIListLayout", {
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    for index, choice in ipairs(choices) do
        table.insert(added, Roact.createElement(ChoiceButton, {
            choice_text = choice.choice,
            choice_index = index,
            choice_count = #choices,
            on_click = onClick,
        }))
    end

    return added
end

function ChoiceBox:init()
    self:setState({
        ScrollTextIndex = 1,
    })
end

function ChoiceBox:render()
    return Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.9),
        BackgroundColor3 = Color3.fromRGB(229, 206, 194),
        Position = UDim2.new(0.405, 0, 0.9, 0),
        Size = UDim2.new(0.711, 0, .2, 0),
    }, {
        UICorner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 15),
        }),
        CharacterName = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Color3.fromRGB(192, 158, 148),
            Position = UDim2.new(0.063, 0, 0, 0),
            Size = UDim2.new(0.206, 0, 0.326, 0),
            Text = self.props.character_name,
            TextScaled = true,
            TextColor3 = Color3.fromRGB(120, 107, 104),
            TextWrapped = true,
            Font = Enum.Font.PatrickHand,
        }, {
            UICorner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 15),
            }),
            UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 50,
            }),
        }),
        DialogueText = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(1, 0, 0.6, 0),
            Text = self.props.dialogue_text,
            TextScaled = true,
            TextColor3 = Color3.fromRGB(152, 136, 132),
            TextWrapped = true,
            Font = Enum.Font.Arial,
            MaxVisibleGraphemes = self.state.ScrollTextIndex,
        }, {
            UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 92,
            }),
        }),
        Choices = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(1.026, 0, 0.5, 0),
            Size = UDim2.new(0.237, 0, 1, 0),
        }, generate_choices(self.props.dialogue_options, self.props.on_click)),
    })
end

function ChoiceBox:didMount()
    task.spawn(function()
        local text_length = self.props.dialogue_text:len()
        for i = 1, text_length do
            task.wait(TEXT_WAIT)
            self:setState({
                ScrollTextIndex = i,
            })
        end
        task.wait(FINISHED_WAIT)
        self.props.scroll_finished()
    end)
end

return ChoiceBox