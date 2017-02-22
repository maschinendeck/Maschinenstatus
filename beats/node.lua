gl.setup(800, 600)

local font = resource.load_font("Overpass-ExtraLight.ttf")

local base_time = N.base_time or 0
util.data_mapper{
    ["time/set"] = function(time)
        beats_now = sys.now() / 86.4
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
    local time = (base_time + (sys.now() / 86.4)) % 1000
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
    size = 125
    width = font:width(out, size)
    posY = (0 - size - logoSize) + ((sys.now()*300) % (HEIGHT + size + logoSize))
    font:write(WIDTH / 2 - width / 2, posY, out, size, 1,1,1,1)
    posY = posY + size
    Mlogo:draw(WIDTH / 2 - logoSize / 2, posY, WIDTH / 2 + logoSize / 2, posY + logoSize)
end
