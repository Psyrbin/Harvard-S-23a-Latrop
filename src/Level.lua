Level = Class{}

function Level:init(params)
    self.number = params.number or 0
    self.tiles = params.tiles
    self.portals = params.portals or {}
    self.boxes = params.boxes or {}
    self.doors = params.doors or {}
    self.buttons = params.buttons or {}
    self.panels = params.panels or {}
    self.finish = params.finish or nil
end

function Level:update(dt)
    for k, box in pairs(self.boxes) do
        box:update(dt)
    end
    for k, door in pairs(self.doors) do
        door:update(dt)
    end
    for k, panel in pairs(self.panels) do
        panel:update(dt)
    end
end

function Level:addBoxes(boxes)
    for k, box in pairs(boxes) do
        table.insert(self.boxes, box)
    end
end

function Level:create_portal(color, tile, side)
    if tile.portalable then
        --remove previous portal of the same color and create new one
        for k, portal in pairs(self.portals) do
            if portal.color == color then
                for n, portal2 in pairs(portal.tile.portals) do
                    if portal2.color == color then
                        table.remove(portal.tile.portals, n)
                    end
                end
                table.remove(self.portals, k)
            end
        end
        local portal =  Portal({x = tile.x, y = tile.y, color = color, side = side, tile = tile, level = self})
        table.insert(tile.portals, portal)
        table.insert(self.portals, portal)
    end
end

function Level:render()
    for k, tile in pairs(self.tiles) do
        tile:render()
    end
    for k, portal in pairs(self.portals) do
        portal:render()
    end
    for k, box in pairs(self.boxes) do
        box:render()
    end
    for k, door in pairs(self.doors) do
        door:render()
    end
    for k, button in pairs(self.buttons) do
        button:render()
    end
    for k, panel in pairs(self.panels) do
        panel:render()
    end
    self.finish:render()
end
