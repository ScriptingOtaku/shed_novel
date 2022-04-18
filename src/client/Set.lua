local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Camera = require(script.Parent:WaitForChild("Camera"))

local set = {}

local last_background = nil
local last_background_model = nil
local last_character = nil
local last_character_model = nil

local Backgrounds = ReplicatedStorage:WaitForChild("Backgrounds")
local Characters = ReplicatedStorage:WaitForChild("Characters")

function get_background_model(background: string)
    local background_model = Backgrounds:FindFirstChild(background):Clone()
    return background_model
end
function get_character_model(character: string)
    print(character)
    local character_model = Characters:FindFirstChild(character):Clone()
    return character_model
end

function set:set_background(background: string)
    local model = get_background_model(background)
    if last_background ~= background then
        if last_background_model then
            last_background_model:Destroy()
        end
        if model then
            last_background = background
            last_background_model = model
            model.Parent = workspace
            Camera:set_background(model)
        else
            warn("Background not found: " .. background.."; Defaulting to last background")
            if last_background then
                set:set_background(last_background)
            else
                warn("No last background to default to")
            end
        end
    end
end
function set:set_character(character: string)
    local model = get_character_model(character)
    if last_character ~= character then
        if last_character_model then
            last_character_model:Destroy()
        end
        if model then
            last_character = character
            last_character_model = model
            model.Parent = workspace
            local character_stand = last_background_model:FindFirstChild("CharacterStand")
            if character_stand then
                model:PivotTo(character_stand:GetPivot())
            else
                Camera:set_character(model)
            end
        else
            warn("Character not found: " .. character.."; Defaulting to last character")
            if last_character then
                set:set_character(last_character)
            else
                warn("No last character to default to")
            end
        end
    end
end

function set:update(line: table)
    local background = line.background or last_background
    local character = line.character or last_character
    if background then
        self:set_background(background)
    end
    if character then
        if character == "Player" then
            character = "Nothing"
        end
        if character == "Narrator" then
            character = "Nothing"
        end
        self:set_character(character)
    end
end

function set:remove_all()
    last_background = nil
    last_character = nil
    if last_background_model then
        last_background_model:Destroy()
    end
    if last_character_model then
        last_character_model:Destroy()
    end
    last_background_model = nil
    last_character_model = nil
end

return set