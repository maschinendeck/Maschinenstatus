gl.setup(1920, 1080)

function node.render()
    gl.clear(0, 0, 0, 1) -- green


    -- render an draw without creating an intermediate variable
    --resource.render_child("mpd"):draw(0, 0, 900, 100)
    resource.render_child("clock"):draw(0, 0, 1920, 100)
    resource.render_child("cycler"):draw(0, 100, 1920, 1080)
end
