
-- Start your story with someone being given a book recommendation.

local Helper = require(script.Parent.Parent.Story_Helper)

local IDK = {
    Helper.createLine("It all comes flowing out of you.", nil, "Narrator", "Shed"),
    Helper.createLine("I was just at home reading a stupid book!", nil, "Player"),
    Helper.createLine("I need to get home!", nil, "Player"),
    Helper.createLine("Hey buddy, we'll get you home fine.", nil, "Shed", "Shed"),
    Helper.createLine("Thank you.", nil, "Player"),
    Helper.createLine("Suddenly everything becomes dark.", nil, "Narrator", "BLACK"),
    Helper.playSound(2834289304, false, 10),
    Helper.createLine("You die.", nil, "Narrator", "BLACK"),
    Helper.createWait(5),
}

local ReadBook = {
    Helper.createLine("In a land far far away, there lived a shed and a gnome.", nil, "Book", "Bedroom"),
    Helper.createLine("*YAWN*", nil, "Player"),
    Helper.createLine("You doze off to sleep.", nil, "Narrator", "BLACK"),
    Helper.playSound(4735243077, false, 5),
    Helper.createWait(2),

    Helper.createLine("You wake up to find yourself in a shed.", nil, "Narrator", "BLACK"),
    Helper.createLine("Hey! What are you doing inside of S.H.E.D.?", nil, "Gnome", "Shed"),
    Helper.createLine("Uh.. Nothing", nil, "Player"),
    Helper.createLine("C'Mon Gnome. Leave the kid alone", nil, "Shed", "Shed"),

    Helper.createLine("Where am I?", nil, "Player"),
    Helper.createLine("You are in a shed.", nil, "Narrator"),

    Helper.createLine("How did you get here?", {
        Helper.createOption("I don't know!", IDK),
    }, "Gnome"),
    

    Helper.createWait(10),
}

local TakeBook = {
    Helper.editBackground("Bedroom", "Book"),
    Helper.createLine("Uh thanks... I'll take it.", {
        Helper.createOption("Read book", ReadBook),
    }, "Player"),
}
local KickTheo = {
    -- Ending
    Helper.createLine("Go away!", nil, "Player"),
    Helper.createLine("But Mom want's you to take this book!", nil, "Theo"),
    Helper.createLine("I can pick out my own books! Just Go!", nil, "Player"),
    Helper.editBackground("Bedroom", "Nothing"),
}

local StoryStart = {
    -- Intro
    Helper.playSound(1846631912, true, 5),
    Helper.editBackground("Bedroom", "Theo"),
    Helper.playSound(157167203, false, 2),
    Helper.createLine("Hey, Mom wanted me to give you this book.", nil, "Theo"),
    Helper.createLine("She said it was about a shed and gnome or something.", nil, "Theo"),
    Helper.createLine("I wasn't really paying attention.", {
        Helper.createOption("Take the book.", TakeBook),
        Helper.createOption("Kick Theo out of your room.", KickTheo),
    }, "Theo"),
}

return IDK