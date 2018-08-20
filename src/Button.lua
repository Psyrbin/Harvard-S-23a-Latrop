Button = Class{}

function Button:init(params)
    self.x = params.x
    self.y = params.y
    self.object = params.object or nil
    self.object_type = params.object_type or nil
    self.pressed = false
    self.texture = gTextures['button']
    self.frame = gFrames['button'][1]
end

function Button:press()
    --if pressed, reduce buttons needed to open the door
    if not self.pressed then
        if self.object_type == 'door' then
            self.object.button_count = self.object.button_count - 1
        end
        self.pressed = true
    end
end

function Button:render()
    love.graphics.draw(self.texture, self.frame, self.x, self.y, 0, 1, 1, 0, 0, 0, 0)
end
