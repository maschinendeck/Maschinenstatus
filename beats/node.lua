gl.setup(800, 600)
local ddate = require("ddate")
local font = resource.load_font("Overpass-ExtraLight.ttf")

local base_time = N.base_time or (-60*60)
util.data_mapper{
    ["time/set"] = function(time)
        beats_now = sys.now() -- / 86.4
        base_time = tonumber(time) - beats_now
        N.base_time = base_time
    end;
}

local Mlogo = resource.load_image{
    file = "MLogo-weiss.png";
    mipmap = true;
}


local logoSize = 300
function node.render()
    local time = ((base_time + sys.now() + 60*60) / 86.4) % 1000
    local timeR = math.floor(time)
    local timeRT = timeR
    if timeR < 100 then
        timeRT = '0' .. timeR
    end
    if timeR < 10 then
        timeRT = '00' .. timeR
    end
    if timeR == 1 then
        out = "@ " .. timeRT .. " .beat"
    else
        out = "@ " .. timeRT .. " .beats"
    end
    size = 120
    width = font:width(out, size)
    posY = (0 - 120 - 100 - 20 - logoSize) + ((sys.now()*100) % (HEIGHT + 120 + 100 + 20 + logoSize))
    font:write(WIDTH / 2 - width / 2, posY, out, size, 1,1,1,1)

    posY = posY + size
    size = 100
    out = ddate.date("%C", base_time + sys.now())
    --outSplit = {}
    --for i in string.gmatch(out, "%S+") do
    --    table.insert(outSplit, i)
    --    print(i)
    --end
    --print(outSplit[1])
    width = font:width(out, size)
    posOffset = (sys.now() * -600) % (WIDTH + width)
    font:write(posOffset - width, posY, out, size, 1,1,1,1)

    posY = posY + size
    Mlogo:draw(WIDTH / 2 - logoSize / 2, posY, WIDTH / 2 + logoSize / 2, posY + logoSize)
end
