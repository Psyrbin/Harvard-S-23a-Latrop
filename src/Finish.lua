Finish = Class{}

function Finish:init(params)
    self.x = params.x
    self.y = params.y
    self.texture = gTextures['finish']
    self.frame = gFrames['finish'][1]
end

function Finish:render()
    love.graphics.draw(self.texture, self.frame, self.x, self.y, 0, 1, 1, 0, 0, 0, 0)
end
