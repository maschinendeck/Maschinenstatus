gl.setup(1920, 980)
local font = resource.load_font("futura_opentype.otf")

local raumstatus = raumstatus or "unknown"
local wireless = wireless or "unknown"
local total = total or "unknown"

util.data_mapper{
    ["status/set"] = function(raum)
        raumstatus = raum
    end;
}
util.data_mapper{
    ["clients_w/set"] = function(clients_w)
        wireless = clients_w
    end;
}
util.data_mapper{
    ["clients_t/set"] = function(clients_t)
        total = clients_t
    end;
}

function node.render()
    gl.clear(0.1, 0.1, 0.1, 1)
    local status = raumstatus 
    out = "Raumstatus: " .. status
    size = 70
    width = font:width(out, size)
    font:write(WIDTH / 2 - width / 2, HEIGHT / 2 - size / 2, out, size, 1,1,1,1)
    out = "Connected Clients: " .. total .. " (" .. wireless .. " wireless )"
    width = font:width(out, size)
    font:write(WIDTH / 2 - width / 2, HEIGHT / 2 + size / 2, out, size, 1,1,1,1)
    
end
