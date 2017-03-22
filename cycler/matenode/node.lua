gl.setup(1920, 980)

local font_futura = resource.load_font("futura-opentype.otf")
local logo = resource.load_image("mate.png")
local day = caff_day or 23
local month = caff_month or 42

util.data_mapper{
    ["caffeine_day/set"]    = function(caff_day)
        day = caff_day
    end;
}
util.data_mapper{
    ["caffeine_month/set"]    = function(caff_month)
        month = caff_month
    end;
}

function node.render()
    gl.clear(0.1, 0.1, 0.1, 1)
    monthStr = "month: " .. month .. "mg"
    dayStr = "day: " .. day .. "mg"
    font_futura:write(100,100,"caffeine:",100,.5,.5,.5,1)
    font_futura:write(100,300,monthStr,100,1,1,1,1)
    font_futura:write(100,500,dayStr,100,1,1,1,1)
    local logo_size = 600
    local offset = 150
    logo:draw(WIDTH-logo_size-offset,offset,WIDTH - offset,logo_size + offset)
end
