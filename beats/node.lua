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

function node.render()
    local time = (base_time + (sys.now() / 86.4)) % 1000
    out = "@ " .. math.floor(time) .. " .beats"
    size = 100
    width = font:width(out, size)
    font:write(WIDTH / 2 - width / 2, HEIGHT / 2 - size / 2, out, 100, 1,1,1,1)
end
