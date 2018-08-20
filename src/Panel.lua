Panel = Class{}

function Panel:init(params)
    self.x = params.x
    self.y = params.y
    self.object = params.object or nil
    self.object_type = params.object_type or nil
    self.pressed = false
    self.player_pressed = false
    self.texture = gTextures['panel']
    self.frame = gFrames['panel'][1]
end

function Panel:update(dt)
    if not self.player_pressed and not self.pressed then
        self.frame = gFrames['panel'][1]
    else
        self.frame = gFrames['panel'][2]
    end
end

function Panel:press()
    if not self.player_pressed and not self.pressed then
        if self.object_type == 'door' then
            self.object.button_count = self.object.button_count - 1
        end
        self.pressed = true
    end
end

function Panel:player_press()
    if not self.player_pressed and not self.pressed then
        if self.object_type == 'door' then
            self.object.button_count = self.object.button_count - 1
        end
        self.player_pressed = true
    end
end


function Panel:unpress()
    if self.pressed and not self.player_pressed then
        if self.object_type == 'door' then
            self.object.button_count = self.object.button_count + 1
        end
        self.pressed = false
    end
end

function Panel:player_unpress()
    if self.player_pressed and not self.pressed then
        if self.object_type == 'door' then
            self.object.button_count = self.object.button_count + 1
        end
        self.player_pressed = false
    end
end

function Panel:render()
    love.graphics.draw(self.texture, self.frame, self.x, self.y, 0, 1, 1, 0, 0, 0, 0)
end
