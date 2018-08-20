Tile = Class{}

function Tile:init(params)
    self.x = params.x
    self.y = params.y
    self.portalable = params.portalable or false

    self.portals = {}

    self.texture = gTextures['tiles']
end

function Tile:update(dt)

end

function Tile:render()
    if self.portalable then
        self.frame = gFrames['tiles'][1]
    else
        self.frame = gFrames['tiles'][2]
    end
    love.graphics.draw(self.texture, self.frame, self.x, self.y, 0, 1, 1, 0, 0, 0, 0)
end
