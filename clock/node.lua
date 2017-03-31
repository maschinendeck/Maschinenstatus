gl.setup(1920, 100)
local font = resource.load_font("futura_opentype.otf")
local logo = resource.load_image("Logo.png")

local humanTime = humanTime or "13:37"
local beatsTime = beatsTime or "@ 666 beats"

util.data_mapper{
    ["time/set"] = function(time)
        humanTime = time
    end;
}

util.data_mapper{
    ["beats/set"] = function(beats)
        beatsTime = beats
    end;
}


function node.render()
    gl.clear(0.8, 0.8, 0.8, 1)
    size = 70
    width = font:width(beatsTime, size)
    font:write(WIDTH - width - 10, HEIGHT / 2 - size / 2, beatsTime, size, 0,0,0,1)
    
    size = 70
    width = font:width(humanTime, size)
    font:write(WIDTH / 2 - width / 2, HEIGHT / 2 - size / 2, humanTime, size, 0,0,0,1)

    if beatsTime == "@ 000 beats" or humanTime == "23:23"
    then 
        logo:draw(90,90,5,5)
    else
        logo:draw(5,5,90,90)
    end
end
