function normalize(x,y)
    local l = math.sqrt(x * x + y * y)
     if l == 0 then
         return 0, 0
     else
         return x/l,y/l
     end
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function intersects(x, y, direction_x, direction_y, tile, height, width)
    while true do
        if x < tile.x and direction_x < 0 then
            return false
        elseif x > tile.x + width and direction_x > 0 then
            return false
        elseif y > tile.y + height and direction_y > 0 then
            return false
        elseif y < tile.y and direction_y < 0 then
            return false
        end

        if x > tile.x and x < tile.x + width and y > tile.y and y < tile.y + height then
            return true
        end
        x = x + direction_x
        y = y + direction_y
    end
end

function intersectionPoint(x0, y0, dir_x1, dir_y1, x2, y2, dir_x3, dir_y3)
    if dir_x3 * dir_y1 - dir_y3 * dir_x1 == 0 then
        return false, false
    else
        local k = (dir_x1 * y2 - dir_x1 * y0 - dir_y1 * x2 + dir_y1 * x0) / (dir_x3 * dir_y1 - dir_y3 * dir_x1)
        local point_x, point_y = x2 + k * dir_x3, y2 + k * dir_y3
        if point_x > x2 + TILE_SIZE or point_x < x2 or point_y > y2 + TILE_SIZE or point_y < y2 then
            return false, false
        end
        return point_x, point_y
    end
end
