gl.setup(1920, 980)

json = require "json"

local font = resource.load_font("futura-opentype.otf")
local iconfont = resource.load_font("FontAwesome.otf")
local events = events or "none"

function cutLongTitle(n,size,title)
    if font:width(title,size) < n then
        return(title)
    end
    while font:width(title .. "..",size) > n do
        title = string.sub(title,0,string.len(title) - 1)
    end
    return(title .. "..")
end


util.file_watch("events.json", function(content)
    events = json.decode(content)
    for idx, event in ipairs(events) do
        event.title = cutLongTitle(900,80,event.title)
    end
    
end)


function node.render()
    gl.clear(0.1, 0.1, 0.1, 1)
    y = 250
    step = (HEIGHT - y) / 2
    hdrsize = 80
    size = 50
    iconsize = 50
    x = 1000
    w = font:width("What's next?",hdrsize)
    font:write(WIDTH - w - 50,50,"What's next?",hdrsize,.2,.2,.2,1)
    for idx, event in ipairs(events) do
        w = font:width(event.title,size)
        font:write(100,y,event.title,hdrsize,1,1,1,1)
        local substep =  (step - hdrsize * 2) / 4

        iconfont:write(x,y,"",iconsize,1,.5,1,1)
        iconfont:write(x,y + size * 1.5,"",iconsize,1,.5,1,1)
        iconfont:write(x,y + 2 * (size * 1.5),"",iconsize,1,.5,1,1)

        font:write(x + 100,y,event.location,size,1,1,1,1)
        font:write(x + 100,y + size * 1.5,event.date,size,1,1,1,1)
        font:write(x + 100,y +  2 * (size * 1.5),event.time,size,1,1,1,1)
        y = y + step
    end
end
