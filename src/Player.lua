Player = Class{}

function Player:init(def)
    self.x = def.x
    self.y = def.y

    self.dx = 0
    self.dy = 0

    self.level = def.level or nil
    self.stateMachine = def.stateMachine or nil
    self.nearBox = false
    self.box = nil
    self.carry = false
    self.nearButton = false
    self.button = nil
    self.direction = 'left'
end

function Player:update(dt)
    self.stateMachine:update(dt)
end

function Player:horisontalCollisions()
    for k, tile in pairs(self.level.tiles) do
        if self.y > tile.y - TILE_SIZE + 1 and self.y < tile.y + TILE_SIZE - 1 then
            if self.x > tile.x and self.x < tile.x + TILE_SIZE then
                return tile.x + TILE_SIZE, 'right', tile
            elseif self.x + PLAYER_WIDTH > tile.x and self.x + PLAYER_WIDTH < tile.x + TILE_SIZE then
                return tile.x - PLAYER_WIDTH, 'left', tile
            end
        end
    end

    for k, door in pairs(self.level.doors) do
        if door.button_count > 0 and self.y > door.y - TILE_SIZE + 1 and self.y < door.y + TILE_SIZE - 1 then
            if self.x > door.x and self.x < door.x + DOOR_WIDTH then
                return door.x + DOOR_WIDTH, false, nil
            elseif self.x + PLAYER_WIDTH > door.x and self.x + PLAYER_WIDTH < door.x + DOOR_WIDTH then
                return door.x - PLAYER_WIDTH, false, nil
            end
        end
    end
    return false
end

function Player:bottomCollisions()
    if self.x + PLAYER_WIDTH > self.level.finish.x and self.x < self.level.finish.x + TILE_SIZE then
        if self.y + TILE_SIZE > self.level.finish.y and self.y < self.level.finish.y then
            --gStateMachine:change('transition', self.level.number)
            if self.level.number == #levels then
                gStateMachine:change('end')
            else
                gStateMachine:change('play', self.level.number + 1)
            end
        end
    end
    for k, tile in pairs(self.level.tiles) do
        if self.x + PLAYER_WIDTH > tile.x and self.x < tile.x + TILE_SIZE then
            if self.y + TILE_SIZE > tile.y and self.y < tile.y then
                return tile.y - TILE_SIZE, tile
            end
        end
    end
    return false, false
end

function Player:topCollisions()
    for k, tile in pairs(self.level.tiles) do
        if self.x + PLAYER_WIDTH > tile.x and self.x < tile.x + TILE_SIZE then
            if self.y > tile.y and self.y < tile.y + TILE_SIZE then
                return tile.y + TILE_SIZE, tile
            end
        end
    end
    return false, false
end

function Player:render()
    self.stateMachine:render()
end
