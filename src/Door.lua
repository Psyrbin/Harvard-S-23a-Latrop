Door = Class{}

function Door:init(params)
    self.x = params.x
    self.y = params.y

    self.button_count = params.button_count or 0
    self.texture = gTextures['door']
    self.frame = gFrames['door'][2]
end

function Door:update(dt)
    if self.button_count <= 0 then
        self.frame = gFrames['door'][2]
    else
        self.frame = gFrames['door'][1]
    end
end

function Door:render()
    love.graphics.draw(self.texture, self.frame, self.x, self.y, 0, 1, 1, 0, 0, 0, 0)
end
