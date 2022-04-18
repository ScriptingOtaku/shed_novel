local story_helper = {}

function story_helper.createLine(text, options, character, background)
    return {
        text = text,
        options = options,
        character = character,
        background = background,
    }
end
function story_helper.createOption(choice: string, story: table)
    return {
        choice = choice,
        story = story,
    }
end
function story_helper.createWait(time: number)
    return {
        text = "WAIT",
        time = time,
    }
end
function story_helper.editBackground(background: string, character: string)
    return {
        text = "EDIT",
        background = background,
        character = character,
    }
end
function story_helper.playSound(sound: number, looped: boolean, volume: number)
    return {
        text = "SOUND",
        sound = sound,
        looped = looped,
        volume = volume,
    }
end

return story_helper