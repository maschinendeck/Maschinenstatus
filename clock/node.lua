gl.setup(1920, 100)
local font = resource.load_font("futura_opentype.otf")

local base_time = N.base_time or (-60*60)
util.data_mapper{
    ["time/set"] = function(time)
        base_time = tonumber(time) - sys.now()
        N.base_time = base_time
    end;
}

function fillup(x,y,n)
    while #x < n do
        x = y .. x
    end
    return(x)
end

function node.render()
    gl.clear(0.8, 0.8, 0.8, 1)
    local beatsTime = ((base_time + sys.now() + 60*60) / 86.4) % 1000
    local beatsTimeR = math.floor(beatsTime)
    local beatsTimeRT = fillup(tostring(beatsTimeR),"0",3)
    if beatsTimeR == 1 then
        out = "@ " .. beatsTimeRT .. " .beat"
    else
        out = "@ " .. beatsTimeRT .. " .beats"
    end 

    size = 70
    width = font:width(out, size)
    font:write(WIDTH - width - 10, HEIGHT / 2 - size / 2, out, size, 0,0,0,1)

    local time = base_time + sys.now()
    local minute = math.floor(time % 3600 / 60)
    local hour = math.floor(((time / 3600) + 1) % 24)
    hour = fillup(tostring(hour),"0",2)
    minute = fillup(tostring(minute),"0",2)
    local second = time % 60

    out = hour .. ":" .. minute
    
    size = 70
    width = font:width(out, size)
    font:write(WIDTH / 2 - width / 2, HEIGHT / 2 - size / 2, out, size, 0,0,0,1)
end
