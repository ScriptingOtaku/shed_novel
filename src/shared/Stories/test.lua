local function createLine(text, options, character, background)
    return {
        text = text,
        options = options,
        character = character,
        background = background,
    }
end

local function createOption(choice: string, story: table)
    return {
        choice = choice,
        story = story,
    }
end

--TODO: maybe add a wait action

return {
    createLine("Hello", nil, "Player", "Ben"),
    createLine("Hello", nil, "Shed"),
    createLine("Want to go somewhere?", {
        createOption("No", {
            createLine("Ok, I'll stay here", nil, "Shed"),
        }),
        createOption("Yes", {
            createLine("Ok, I'll go", nil, "Shed", "HappyHome"),
        })
    }, "Shed"),
}