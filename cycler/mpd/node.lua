gl.setup(1920, 980)

local font = resource.load_font("futura-opentype.otf")
local iconfont = resource.load_font("FontAwesome.otf")

util.resource_loader{
    "cover.jpg",
}

local song_status = song_status or "stop"
local song_title = song_title or "unknown"
local song_artist = song_artist or "unknown"
local song_album = song_album or "unknown"
local playback_modes = playback_modes or ""


util.data_mapper{
    ["status/set"]    = function(status)
        song_status   = status
    end;
}
util.data_mapper{
    ["title/set"]     = function(title)
        song_title    = title
    end;
}
util.data_mapper{
    ["artist/set"]    = function(artist)
        song_artist   = artist
    end;
}
util.data_mapper{
    ["album/set"]     = function(album)
        song_album    = album
    end;
}
util.data_mapper{
    ["modes/set"]       = function(modes)
        playback_modes  = modes
    end;
}
function node.render()
    gl.clear(0.1, 0.1, 0.1, 1)

    cover_size= 500
    w = WIDTH / 2 - cover_size / 2
    h = HEIGHT / 3 - cover_size / 2
    cover:draw(w, h, w + cover_size, h + cover_size)

    size = 70
    text_y = h + cover_size + size
    if song_status == "stop" then
        out = "MPD stopped"
        width = font:width(out, size)
        font:write(WIDTH / 2 - width / 2, text_y, out, size, 1,1,1,1)
        text_y = text_y + size * 1.5
    else
        out = song_title
        width = font:width(out, size)
        font:write(WIDTH / 2 - width / 2, text_y, out, size, 1,1,1,1)
        text_y = text_y + size * 1.5
        out = song_artist
        width = font:width(out, size)
        font:write(WIDTH / 2 - width / 2, text_y, out, size, 1,1,1,1)
        text_y = text_y + size * 1.5
        size= 40
        out = song_album
        width = font:width(out, size)
        font:write(WIDTH / 2 - width / 2, text_y, out, size, 1,1,1,1)
        text_y = text_y + size * 1.5
    end

    icons = ""
    if song_status == "pause" then
        icons = icons ..  "  "
    end
    for pm in string.gmatch(playback_modes, "%S+") do
        if pm == "repeat" then
            icons = icons .. "  "
        end
        if pm == "consume" then
            icons = icons .. "  "
        end
        if pm == "random" then
            icons = icons .. "  "
        end
        if pm == "single" then
            icons = icons .. "  "
        end
    end
    
    iconfont:write(20,HEIGHT - 70,icons,50,0.6,0.6,0.6,1)
        

end
