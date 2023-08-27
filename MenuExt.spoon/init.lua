local MenuExt = {}

MenuExt.name = "Menu Extras Helper"
MenuExt.version = "1.0"
MenuExt.author = "Quin Marilyn <quin.marilyn05@gmail.com>"
MenuExt.license = "MIT"

local synth = hs.speech.new()

local function speak(text)
    if hs.application.get("VoiceOver") ~= nil then
        hs.osascript.applescript(
            "tell application \"VoiceOver\" to output \""
                .. text:gsub("\"", "\\\"")
                .. "\""
        )
    else
        synth:speak(text)
    end
end

local function getMenuExtras()
    local extras = {}
    for _, application in ipairs(hs.application.runningApplications()) do
        -- TODO: This is slow on first run, figure out why
        local element = hs.axuielement.applicationElement(application)
        local appExtras = element.AXExtrasMenuBar
        if not appExtras then
            goto continue
        end
        for _, extra in ipairs(appExtras) do
            local hidden = not extra.AXPosition
            local label = ""
            local labelAttrs = {
                "AXHelp",
                "AXValue",
                "AXTitle",
                "AXDescription",
            }
            for _, attr in ipairs(labelAttrs) do
                local value = extra[attr]
                if value then
                    if label ~= "" then
                        label = label .. " - "
                    end
                    label = label .. value
                end
            end
            if label == "" then
                label = application:name()
            end
            table.insert(
                extras,
                {
                    application = application,
                    extra = extra,
                    hidden = hidden,
                    label = label,
                }
            )
        end
        ::continue::
    end
    table.sort(extras, function(first, second)
        if first.hidden or second.hidden then
            return false
        end
        return first.extra.AXPosition.x < second.extra.AXPosition.x
    end)
    return extras
end

local function getMenuExtra(index)
    local extras = getMenuExtras()
    speak(extras[index].label)
end

local hotkeys = {}

for i = 0, 9 do
    local key = tostring(i)
    local hotkey = hs.hotkey.bind("control-command", key, function()
        getMenuExtra(i)
    end)
    table.insert(hotkeys, hotkey)
end

function MenuExt.start()
    for _, hotkey in ipairs(hotkeys) do
        hotkey:enable()
    end
end

function MenuExt.stop()
    for _, hotkey in ipairs(hotkeys) do
        hotkey:disable()
    end
end

return MenuExt
