gl.setup(1920, 980)

util.auto_loader(_G)

function feeder()
    return {"Maschinendeck.org", "Hacker- & Makerspace Trier"}
end

text = util.running_text{
    font = silkscreen;
    size = 260;
    speed = 240;
    color = {0,1,0,1};
    generator = util.generator(feeder)
}

function node.render()
    text:draw(HEIGHT-260)
end
