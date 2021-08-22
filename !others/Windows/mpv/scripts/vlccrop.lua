-- First lua script, vlc style crop for mpv
require "mp.msg"
require "mp.options"

local label_prefix = mp.get_script_name()
local cropstring = string.format("%s-crop", label_prefix)
local cropnumber = 0

function gettargettar(inaspect)
    local result
    -- Handling the current crop status in this function since its scope needs to transcent this function
    cropnumber = cropnumber + 1

    if cropnumber == 1 then
        mp.osd_message("Crop: 16:10")
        result = 16 / 10
    elseif cropnumber == 2 then
        mp.osd_message("Crop: 16:9")
        result = 16 / 9
    elseif cropnumber == 3 then
        mp.osd_message("Crop: 4:3")
        result = 4 / 3
    elseif cropnumber == 4 then
        mp.osd_message("Crop: 1.85:1")
        result = 1.85 / 1
    elseif cropnumber == 5 then
        mp.osd_message("Crop: 2.21:1")
        result = 2.21 / 1
    elseif cropnumber == 6 then
        mp.osd_message("Crop: 2.35:1")
        result = 2.35 / 1
    elseif cropnumber == 7 then
        mp.osd_message("Crop: 2.39:1")
        result = 2.39 / 1
    elseif cropnumber == 8 then
        mp.osd_message("Crop: 5:3")
        result = 5 / 3
    elseif cropnumber == 9 then
        mp.osd_message("Crop: 5:4")
        result = 5 / 4
    elseif cropnumber == 10 then
        mp.osd_message("Crop: 1:1")
        result = 1 / 1
    elseif cropnumber == 11 then
        mp.osd_message("Crop: 9:16")
        result = 9 / 16
    else
        mp.osd_message("Crop: Default")
        cropnumber = 0
        result = inaspect
    end

    return result
end

function is_cropable()
    for _, track in pairs(mp.get_property_native('track-list')) do
        if track.type == 'video' and track.selected then
            return not track.albumart
        end
    end

    return false
end

function on_press()
    -- If it's not cropable, exit.
    if not is_cropable() then
        mp.msg.warn("autocrop only works for videos.")
        return
    end

    -- Get current video fields, this doesnt take into consideration pixel aspect ratio
    local width = mp.get_property_native("width")
    local height = mp.get_property_native("height")
    local aspect = mp.get_property_native("video-params/aspect")

    local neww
    local newh
    local newx
    local newy

    -- Get target aspect ratio
    targetar = gettargettar(aspect)
    mp.msg.info("Cropping Video, Target Aspect Ratio: " .. tostring(targetar))

    -- Compare target AR to current AR, crop height or width depending on what is needed
    if targetar < aspect then
        -- Reduce width
        neww = height * targetar
        newh = height
        newx = (width - neww) / 2
        newy = 0
    elseif targetar > aspect then
        -- Reduce height
        neww = width
        newh = width * (1 / targetar)
        newx = 0
        newy = (height - newh) / 2
    else
        -- This probably doesnt have to exist tbh
        neww = width
        newh = height
        newx = 0
        newy = 0
    end

    -- Apply crop
    mp.command(string.format("%s vf pre @%s:lavfi-crop=w=%s:h=%s:x=%s:y=%s",
                             'no-osd', cropstring, neww, newh, newx, newy))
end

mp.add_key_binding("c", "toggle_crop", on_press)
