local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local Dialogue = Roact.Component:extend("Dialogue")

local TextBox = require(script.TextBox)
local ChoiceBox = require(script.ChoiceBox)

function Dialogue:init()
    
end

function Dialogue:render()

    local dialogue_text = self.props.dialogue_text
    local dialogue_options = self.props.dialogue_options
    local character_name = self.props.character_name
    local on_click = self.props.on_click

    if dialogue_options and dialogue_options ~= {} then
        return Roact.createElement(ChoiceBox, {
            dialogue_text = dialogue_text,
            dialogue_options = dialogue_options,
            character_name = character_name,
            on_click = on_click,
            scroll_finished = self.props.scroll_finished,
        })
    else
        return Roact.createElement(TextBox, {
            dialogue_text = dialogue_text,
            character_name = character_name,
            scroll_finished = self.props.scroll_finished,
        })
    end
end

return Dialogue