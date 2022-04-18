local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local Dialogue = require(script.Parent:WaitForChild("Dialogue"))
local Set = require(script.Parent:WaitForChild("Set"))

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local StoryHandler = {}

type Story = {
    [Line]: Line
}
type Line = {}

local mount = nil

local function ScreenGui(children: table)
    return Roact.createElement("ScreenGui", {
        IgnoreGuiInset = true,
    }, children)
end

local function UnMount()
    if mount then
        Roact.unmount(mount)
        mount = nil
    end
end

local function get_next_line(story: Story, last_line_index: number)
    local next_line = story[last_line_index + 1]
    return next_line
end

local function get_story(story_name: string)
    local story_file = require(ReplicatedStorage.Stories:WaitForChild(story_name))
    return story_file
end

local function run(story: Story, line: Line, index: number)

    if line == nil then
        UnMount()
        Set:remove_all()
        return
    end

    local text = line.text
    local options = line.options
    local character = line.character

    if text ~= "END" then
        if text ~= "WAIT" then
            if text ~= "EDIT" then
                Set:update(line)
                if options == nil or options == {} then
                    mount = Roact.mount(ScreenGui(Roact.createElement(Dialogue, {
                        dialogue_text = text,
                        character_name = character,
                        scroll_finished = function()
                            UnMount()
                            run(
                                story,
                                get_next_line(story, index),
                                index + 1
                            )
                        end,

                    })), PlayerGui)
                else
                    mount = Roact.mount(ScreenGui(Roact.createElement(Dialogue, {
                        dialogue_text = text,
                        character_name = character,
                        dialogue_options = options,
                        scroll_finished = function() end,
                        on_click = function(_choice: string, choice_index: number)
                            UnMount()
                            run(
                                options[choice_index].story,
                                get_next_line(options[choice_index].story, 0),
                                1
                            )
                        end,

                    })), PlayerGui)
                end
            else
                UnMount()
                Set:update(line)
                run(
                    story,
                    get_next_line(story, index),
                    index + 1
                )
            end
        else
            UnMount()
            task.wait(line.time)
            run(
                story,
                get_next_line(story, index),
                index + 1
            )
        end
    else
        print("END")
        Set:remove_all()
        UnMount()
    end
end

function StoryHandler:start(story_name: string)
    UnMount()
    local story = get_story(story_name)
    local current_line = story[1]
    run(story, current_line, 1)
end

return StoryHandler