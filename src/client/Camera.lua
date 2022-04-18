
local CameraModule = {}

local Camera = workspace.CurrentCamera

local function set_to_scriptable()
    Camera.CameraType = Enum.CameraType.Scriptable
    repeat
        Camera.CameraType = Enum.CameraType.Scriptable
    until Camera.CameraType == Enum.CameraType.Scriptable
end

function CameraModule:set_background(background_model: Instance)
    set_to_scriptable()
    local camera_part = background_model:FindFirstChild("CameraPart", true)
    if camera_part then
        Camera.CFrame = camera_part.CFrame
    else
        warn("Background model does not have a CameraPart")
        Camera.CFrame = background_model:GetPivot()
    end
end

function CameraModule:set_character(character_model: Instance, offset: Vector3, rotation: Vector3)
    if not offset then
        offset = character_model:FindFirstChild("Offset", true)
    end
    offset = offset or Vector3.new(0, 0, 0)
    if not rotation then
        rotation = character_model:FindFirstChild("Rotation", true)
    end
    rotation = rotation or Vector3.new(0, 0, 0)
    character_model:PivotTo(Camera.CFrame * CFrame.new(offset) * CFrame.Angles(
        math.rad(rotation.X),
        math.rad(rotation.Y),
        math.rad(rotation.Z)
    ))
end

return CameraModule