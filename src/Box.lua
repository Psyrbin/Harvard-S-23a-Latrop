Box = Class{}

function Box:init(params)
    self.x = params.x
    self.y = params.y
    self.texture = gTextures['box']
    self.frame = gFrames['box'][1]

    self.level = params.level

    self.binded = false
    self.player = nil
end

function Box:update(dt)
    --sometimes boxes fall under the floor, this gets them back on the screen
    if self.y > VIRTUAL_WIDTH then
        self.y = 30
    end

    --move, check collisions
    self.y = self.y + GRAVITY * dt
    for k, tile in pairs(self.level.tiles) do
        if self.x + BOX_SIZE > tile.x and self.x < tile.x + TILE_SIZE then
            if self.y + BOX_SIZE > tile.y and self.y < tile.y then
                self.y = tile.y - BOX_SIZE
                for k, portal in pairs(tile.portals) do
                    if portal.side == 'top' then
                        portal:teleport(self)
                    end
                end
            end
        end
    end

    --move with the player
    if self.binded then
        if self.player.direction == 'right' then
            self.x = self.player.x + 10
        else
            self.x = self.player.x - 9
        end
        self.y = self.player.y
    end

    --activate panel
    for k, panel in pairs(self.level.panels) do
        if self.x + BOX_SIZE > panel.x and self.x < panel.x + TILE_SIZE then
            if self.y + BOX_SIZE > panel.y and self.y < panel.y then
                panel:press()
            end
        end
    end
end

function Box:bind(player)
    self.binded = true
    self.player = player
end

function Box:unbind()
    self.binded = false
    self.falling = true
end

function Box:render()
    love.graphics.draw(self.texture, self.frame, self.x, self.y, 0, 1, 1, 0, 0, 0, 0)
end
