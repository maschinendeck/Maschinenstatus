gl.setup(1920, 1080)

local font = resource.load_font("silkscreen.ttf")

local song_status = N.song_status or "stop"
local song_title = N.song_title or "unknown"
local song_artist = N.song_artist or "unknown"


util.data_mapper{
    ["status/set"]      = function(status)
        N.song_status   = status
    end;
}
util.data_mapper{
    ["title/set"]       = function(title)
        N.song_title    = title
    end;
}
util.data_mapper{
    ["artist/set"]      = function(artist)
        N.song_artist   = artist
    end;
}

function node.render()
    gl.clear(1, 0, 0, 1)
    local status = N.song_status
    if status == "stop" then
        out = "MPD stopped"
    else
        out = N.song_artist ..  " - " .. N.song_title  
        if status == "pause" then
            out = "{paused} " .. out
        end
    end
    size = 50
    width = font:width(out, size)
    font:write(WIDTH / 2 - width / 2, HEIGHT / 2 - size / 2, out, size, 1,1,0,1)
    
end
