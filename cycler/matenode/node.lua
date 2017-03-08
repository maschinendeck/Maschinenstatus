gl.setup(1920, 980)

local font = resource.load_font("Inconsolata.otf")
local font_futura = resource.load_font("futura-opentype.otf")
local logo = resource.load_image("mate.png")
local lines = {}
local caffeine = 0

function wrap(str, limit, indent, indent1)
    indent = indent or ""
    indent1 = indent1 or indent
    limit = limit or 72
    function wrap_parargraph(str)
        local here = 1-#indent1
        return indent1..str:gsub("(%s+)()(%S+)()", function(sp, st, word, fi)
            if fi-here > limit then
                here = st - #indent
                return "\n"..indent..word
            end
        end)
    end
    local splitted = {}
    for par in string.gmatch(str, "[^\n]+") do
        local wrapped = wrap_parargraph(par)
        for line in string.gmatch(wrapped, "[^\n]+") do
            splitted[#splitted + 1] = line
        end
    end
    return splitted
end

util.file_watch("prices", function(content)
    lines = wrap(content, 60)
end)

util.file_watch("caffeine", function(caff)
    caffeine = "Koffeinverbrauch (laufender Monat): " .. caff .. "mg"
end)

function node.render()
    gl.clear(0.1, 0.1, 0.1, 1)
    font_futura:write(100,50,caffeine,50,1,1,1,1)
    local logo_size = 600
    local offset = 150
    logo:draw(WIDTH-logo_size-offset,offset,WIDTH - offset,logo_size + offset)
    y = 200
    x = 100
    for i, line in ipairs(lines) do
        local size = 40
        font:write(x, y, line, size, 1, 1, 1, 1)
        y = y + size
    end
end
