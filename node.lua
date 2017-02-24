gl.setup(1920, 1080)

function node.render()
    gl.clear(0, 0, 0, 1) -- green


    -- render an draw without creating an intermediate variable
    resource.render_child("mpd"):draw(0, 0, 1920, 200)
    resource.render_child("beats"):draw(0, 200, 1920, 200)
end
