PlayerWalkState = Class{__includes = BaseState}

function PlayerWalkState:init(player)
    self.player = player or nil
end

function PlayerWalkState:enter()
    self.player.dy = 0
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.player.direction = 'right'
        self.player.dx = PLAYER_WALK_SPEED
    elseif love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.player.direction = 'left'
        self.player.dx = -PLAYER_WALK_SPEED
    else
        self.player.dx = 0
    end

    --pick up box
    if love.keyboard.wasPressed('e') then
        if self.player.nearBox then
            self.player.carry = true
            self.player.box:bind(self.player)
        elseif self.player.carry then
            self.player.carry = false
            self.player.box:unbind()
        end
    end

    --press button
    if love.keyboard.wasPressed('q') then
        if self.player.nearButton then
            self.player.button:press()
        end
    end

    if love.keyboard.isDown('space') then
        self.player.dy = PLAYER_JUMP_VELOCITY
        self.player.stateMachine:change('fall', {player = self.player})
    end

    self.player.x = self.player.x + dt * self.player.dx

    local teleported = false

    --check collisions on left and right
    local collision_x, dir, tile = self.player:horisontalCollisions()
    if collision_x then
        if tile then
            for k, portal in pairs(tile.portals) do
                if portal.side == dir then
                    teleported = portal:teleport(self.player)
                end
            end
        end
        if not teleported then
            self.player.x = collision_x
        end
    end

    self.player.y = self.player.y + dt * self.player.dy

    --check collisions below
    local collided, tile = self.player:bottomCollisions()
    if collided then
        for k, portal in pairs(tile.portals) do
            if portal.side == 'top' then
                teleported = portal:teleport(self.player)
            end
        end
    else
        self.player.stateMachine:change('fall', {player = self.player})
    end

    --check if box is near
    self.player.nearBox = false
    for k, box in pairs(self.player.level.boxes) do
        if self.player.y > box.y - TILE_SIZE + 1 and self.player.y < box.y + BOX_SIZE - 1 then
            if box.x > self.player.x - BOX_SIZE and box.x < self.player.x + PLAYER_WIDTH then
                self.player.box = box
                self.player.nearBox = true
            end
        end
    end

    --check if button is near
    self.player.nearButton = false
    for k, button in pairs(self.player.level.buttons) do
        if self.player.y > button.y - TILE_SIZE + 1 and self.player.y < button.y + BUTTON_HEIGHT - 1 then
            if button.x > self.player.x - BUTTON_WIDTH and button.x < self.player.x + PLAYER_WIDTH then
                self.player.button = button
                self.player.nearButton = true
            end
        end
    end

    --activate panel
    for k, panel in pairs(self.player.level.panels) do
        panel:player_unpress()
        if self.player.x + PLAYER_WIDTH > panel.x and self.player.x < panel.x + TILE_SIZE then
            if self.player.y + TILE_SIZE > panel.y and self.player.y < panel.y then
                panel:player_press()
            end
        end
    end

end

function PlayerWalkState:render()
    love.graphics.draw(gTextures['player'], gFrames['player'][1], self.player.x, self.player.y, 0, 1, 1, 0, 0, 0, 0)
end
