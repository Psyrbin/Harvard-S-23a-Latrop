Portal = Class{}

function Portal:init(params)
    self.color = params.color
    self.side = params.side
    self.tile = params.tile or nil
    self.level = params.level

    --create portal on the tile
    if self.side == 'left' then
        self.texture = gTextures['portal_lr']
        if self.color == 'blue' then
            self.frame = gFrames['portal_lr'][1]
        else
            self.frame = gFrames['portal_lr'][3]
        end

        self.x = params.x - PORTAL_THICKNESS
        self.y = params.y
    elseif self.side == 'right' then
        self.texture = gTextures['portal_lr']
        if self.color == 'blue' then
            self.frame = gFrames['portal_lr'][2]
        else
            self.frame = gFrames['portal_lr'][4]
        end

        self.x = params.x + TILE_SIZE
        self.y = params.y
    elseif self.side == 'bot' then
        self.texture = gTextures['portal_bt']
        if self.color == 'blue' then
            self.frame = gFrames['portal_bt'][1]
        else
            self.frame = gFrames['portal_bt'][3]
        end

        self.x = params.x
        self.y = params.y + TILE_SIZE
    elseif self.side == 'top' then
        self.texture = gTextures['portal_bt']
        if self.color == 'blue' then
            self.frame = gFrames['portal_bt'][2]
        else
            self.frame = gFrames['portal_bt'][4]
        end

        self.x = params.x
        self.y = params.y - PORTAL_THICKNESS
    end
end

function Portal:teleport(object)
    for k, portal in pairs(self.level.portals) do
        if not (portal.color == self.color) then
            if portal.side == 'left' then
                object.x = portal.x - 10
                object.y = portal.y
            elseif portal.side == 'right' then
                object.x = portal.x + 5
                object.y = portal.y
            elseif portal.side == 'top' then
                object.x = portal.x
                object.y = portal.y - 20
            elseif portal.side == 'bot' then
                object.x = portal.x
                object.y = portal.y + 5
            end
            return true
        end
    end
    return false
end

function Portal:render()
    love.graphics.draw(self.texture, self.frame, self.x, self.y, 0, 1, 1, 0, 0, 0, 0)
end
