function create_levels()
    local levels = {}
    local player_x = {}
    local player_y = {}
    local level = nil
    local player = nil
    local tiles = {}
    local doors = {}
    local buttons = {}


    --LEVEL 1
    finish = Finish({x = 50, y = 197})
    tiles = {}

    for i = 1, VIRTUAL_WIDTH / 16 do
        table.insert(tiles, Tile({x = 16 * (i - 1), y = 0, portalable =false}))
        table.insert(tiles, Tile({x = 16 * (i - 1), y = (VIRTUAL_HEIGHT / 16 - 1) * TILE_SIZE, portalable =false}))
    end
    for i = 2, VIRTUAL_HEIGHT / 16 do
        table.insert(tiles, Tile({x = 0, y = 16 * (i - 1), portalable =false}))
        table.insert(tiles, Tile({x = (VIRTUAL_WIDTH / 16 - 1) * TILE_SIZE, y = 16 * (i - 1), portalable =false}))
    end
    level = Level({tiles = tiles, finish = finish, number = 1})

    table.insert(levels, level)
    table.insert(player_x, 20)
    table.insert(player_y, 80)


    --LEVEL 2
    finish = Finish({x = 342, y = 197})
    tiles = {}

    for i = 1, VIRTUAL_WIDTH / 16 do
        table.insert(tiles, Tile({x = 16 * (i - 1), y = 0, portalable =true}))
        table.insert(tiles, Tile({x = 16 * (i - 1), y = (VIRTUAL_HEIGHT / 16 - 1) * TILE_SIZE, portalable =false}))
    end
    for i = 2, VIRTUAL_HEIGHT / 16 do
        table.insert(tiles, Tile({x = 0, y = 16 * (i - 1), portalable =false}))
        table.insert(tiles, Tile({x = (VIRTUAL_WIDTH / 16 - 1) * TILE_SIZE, y = 16 * (i - 1), portalable =false}))
    end

    for i = 1, 6 do
        table.insert(tiles, Tile({x = 200, y = (VIRTUAL_HEIGHT / 16 - 1 - i) * TILE_SIZE, portalable = true}))
    end
    level = Level({tiles = tiles, finish = finish, number = 2})


    table.insert(levels, level)
    table.insert(player_x, 20)
    table.insert(player_y, 180)

    --LEVEL 3
    finish = Finish({x = 342, y = 197})
    tiles = {}

    for i = 1, VIRTUAL_WIDTH / 16 do
        table.insert(tiles, Tile({x = 16 * (i - 1), y = 0, portalable = false}))
        table.insert(tiles, Tile({x = 16 * (i - 1), y = (VIRTUAL_HEIGHT / 16 - 1) * TILE_SIZE, portalable =false}))
    end
    for i = 2, VIRTUAL_HEIGHT / 16 do
        table.insert(tiles, Tile({x = 0, y = 16 * (i - 1), portalable =false}))
        table.insert(tiles, Tile({x = (VIRTUAL_WIDTH / 16 - 1) * TILE_SIZE, y = 16 * (i - 1), portalable =false}))
    end

    for i = 2, 6 do
        table.insert(tiles, Tile({x = 200, y = (VIRTUAL_HEIGHT / 16 - 1 - i) * TILE_SIZE, portalable = false}))
    end

    doors = {Door({x = 200, y = (VIRTUAL_HEIGHT / 16 - 2) * TILE_SIZE, button_count = 1})}

    buttons = {Button({x = 35, y = (VIRTUAL_HEIGHT / 16 - 2) * TILE_SIZE + 6, object = doors[1], object_type = 'door'})}

    level = Level({tiles = tiles, finish = finish, doors = doors, buttons = buttons, number = 3})


    table.insert(levels, level)
    table.insert(player_x, 20)
    table.insert(player_y, 180)


    --LEVEL 4
    finish = Finish({x = 342, y = 197})
    tiles = {}
    doors = {}
    buttons = {}
    panels = {}
    boxes = {}

    for i = 1, VIRTUAL_WIDTH / 16 do
        table.insert(tiles, Tile({x = 16 * (i - 1), y = 0, portalable = false}))
        table.insert(tiles, Tile({x = 16 * (i - 1), y = (VIRTUAL_HEIGHT / 16 - 1) * TILE_SIZE, portalable =false}))
    end
    for i = 2, VIRTUAL_HEIGHT / 16 do
        table.insert(tiles, Tile({x = 0, y = 16 * (i - 1), portalable =false}))
        table.insert(tiles, Tile({x = (VIRTUAL_WIDTH / 16 - 1) * TILE_SIZE, y = 16 * (i - 1), portalable =false}))
    end

    for i = 2, 6 do
        table.insert(tiles, Tile({x = 200, y = (VIRTUAL_HEIGHT / 16 - 1 - i) * TILE_SIZE, portalable = false}))
    end

    doors = {Door({x = 200, y = (VIRTUAL_HEIGHT / 16 - 2) * TILE_SIZE, button_count = 1})}

    panels = {Panel({x = 35, y = (VIRTUAL_HEIGHT / 16 - 2) * TILE_SIZE + 14, object = doors[1], object_type = 'door'})}

    level = Level({tiles = tiles, finish = finish, doors = doors, buttons = buttons, panels = panels, number = 4})

    box = Box({x = 150, y = 40, level = level})
    level:addBoxes({box})

    table.insert(levels, level)
    table.insert(player_x, 20)
    table.insert(player_y, 180)




    --LEVEL 5
    finish = Finish({x = 342, y = 197})
    tiles = {}
    doors = {}
    buttons = {}
    panels = {}
    boxes = {}

    for i = 1, VIRTUAL_WIDTH / 16 do
        if i < 10 and i > 1 then
            table.insert(tiles, Tile({x = 16 * (i - 1), y = 0, portalable = true}))
            table.insert(tiles, Tile({x = 16 * (i - 1), y = (VIRTUAL_HEIGHT / 16 - 1) * TILE_SIZE, portalable = true}))
        else
            table.insert(tiles, Tile({x = 16 * (i - 1), y = 0, portalable = false}))
            table.insert(tiles, Tile({x = 16 * (i - 1), y = (VIRTUAL_HEIGHT / 16 - 1) * TILE_SIZE, portalable = false}))
        end
    end
    for i = 2, VIRTUAL_HEIGHT / 16 do
        table.insert(tiles, Tile({x = 0, y = 16 * (i - 1), portalable =false}))
        table.insert(tiles, Tile({x = (VIRTUAL_WIDTH / 16 - 1) * TILE_SIZE, y = 16 * (i - 1), portalable =false}))
    end

    for i = 1, 6 do
        table.insert(tiles, Tile({x = 50, y = (VIRTUAL_HEIGHT / 16 - 1 - i) * TILE_SIZE, portalable = false}))
    end

    for i = 2, 12 do
        table.insert(tiles, Tile({x = 200, y = (VIRTUAL_HEIGHT / 16 - 1 - i) * TILE_SIZE, portalable = false}))
    end

    doors = {Door({x = 200, y = (VIRTUAL_HEIGHT / 16 - 2) * TILE_SIZE, button_count = 1})}

    panels = {Panel({x = 20, y = (VIRTUAL_HEIGHT / 16 - 2) * TILE_SIZE + 14, object = doors[1], object_type = 'door'})}

    level = Level({tiles = tiles, finish = finish, doors = doors, buttons = buttons, panels = panels, number = 5})

    box = Box({x = 150, y = 40, level = level})
    level:addBoxes({box})

    table.insert(levels, level)
    table.insert(player_x, 120)
    table.insert(player_y, 180)




    --LEVEL 6
    finish = Finish({x = 342, y = 197})
    tiles = {}
    doors = {}
    buttons = {}
    panels = {}
    boxes = {}

    for i = 1, VIRTUAL_WIDTH / 16 do
        table.insert(tiles, Tile({x = 16 * (i - 1), y = 0, portalable = false}))
        table.insert(tiles, Tile({x = 16 * (i - 1), y = (VIRTUAL_HEIGHT / 16 - 1) * TILE_SIZE, portalable =false}))
    end
    for i = 2, VIRTUAL_HEIGHT / 16 do
        if i < VIRTUAL_HEIGHT / 16 - 1 and i > 8 then
            table.insert(tiles, Tile({x = 0, y = 16 * (i - 1), portalable = true}))
            table.insert(tiles, Tile({x = (VIRTUAL_WIDTH / 16 - 1) * TILE_SIZE, y = 16 * (i - 1), portalable =true}))
        else
            table.insert(tiles, Tile({x = 0, y = 16 * (i - 1), portalable = false}))
            table.insert(tiles, Tile({x = (VIRTUAL_WIDTH / 16 - 1) * TILE_SIZE, y = 16 * (i - 1), portalable = false}))
        end
    end

    for i = 2, 6 do
        table.insert(tiles, Tile({x = 200, y = (VIRTUAL_HEIGHT / 16 - 1 - i) * TILE_SIZE, portalable = false}))
    end

    doors = {Door({x = 200, y = (VIRTUAL_HEIGHT / 16 - 2) * TILE_SIZE, button_count = 1})}

    panels = {Panel({x = 35, y = (VIRTUAL_HEIGHT / 16 - 2) * TILE_SIZE + 14, object = doors[1], object_type = 'door'})}

    level = Level({tiles = tiles, finish = finish, doors = doors, buttons = buttons, panels = panels, number = 6})


    table.insert(levels, level)
    table.insert(player_x, 20)
    table.insert(player_y, 180)

    -- levels = {levels[5]}
    -- player_x = {player_x[5]}
    return levels, player_x, player_y
end
