PlayState = Class{__includes = BaseState}

function PlayState:init()

end

function PlayState:enter(lvl_num)
    self.level = levels[lvl_num]
    self.player = Player({
        x = player_x[lvl_num],
        y = player_y[lvl_num],
        stateMachine = StateMachine {
            ['walk'] = function() return PlayerWalkState(self.player) end,
            ['fall'] = function() return PlayerFallState(self.player) end
        },
        level = self.level
    })

    self.player.stateMachine:change('walk', {player = self.player})
    self.intersections = {}
end

function PlayState:update(dt)
    if love.mouse.wasPressed(1) or love.mouse.wasPressed(2) then
        local color = ''
        if love.mouse.wasPressed(1) then
            color = 'blue'
        else
            color = 'orange'
        end

        --next 100 lines find first object that portal hits and creates portal there if possible
        self.intersections = {}
        self.door_intersections = {}

        local player_middle_x, player_middle_y = self.player.x + PLAYER_WIDTH / 2, self.player.y + TILE_SIZE / 3
        local x, y = push:toGame(love.mouse.getPosition())

        local direction_x, direction_y = x - player_middle_x, y - player_middle_y
        direction_x, direction_y = normalize(direction_x, direction_y)


        local inters_p_x, inters_p_y = player_middle_x + 10000 * direction_x, player_middle_y + 10000 * direction_y

        for k, tile in pairs(self.level.tiles) do
           if intersects(player_middle_x, player_middle_y, direction_x, direction_y, tile, TILE_SIZE, TILE_SIZE) then
               table.insert(self.intersections, tile)
           end
        end

        for k, door in pairs(self.level.doors) do
           if intersects(player_middle_x, player_middle_y, direction_x, direction_y, door, TILE_SIZE, DOOR_WIDTH) then
               table.insert(self.door_intersections, door)
           end
        end

        if #self.intersections >= 0 then
           local nearest_tile = self.intersections[1]
           local smallest_dist = distance(player_middle_x, player_middle_y, nearest_tile.x, nearest_tile.y)
           for i = 2, #self.intersections do
               local dist = distance(player_middle_x, player_middle_y, self.intersections[i].x, self.intersections[i].y)
               if dist < smallest_dist then
                   smallest_dist = dist
                   nearest_tile = self.intersections[i]
               end
           end

           local smallest_door_dist = 1000000
           local nearest_door = nil
           if #self.door_intersections > 0 then
               nearest_door = self.door_intersections[1]
               if nearest_door.button_count > 0 then
                   smallest_door_dist = distance(player_middle_x, player_middle_y, nearest_door.x, nearest_door.y)
               end
               for i = 2, #self.door_intersections do
                   local dist = distance(player_middle_x, player_middle_y, self.door_intersections[i].x, self.door_intersections[i].y)
                   if dist < smallest_door_dist and door.button_count > 0 then
                       smallest_door_dist = dist
                       nearest_door = self.intersections[i]
                   end
               end
           end

           if smallest_door_dist < smallest_dist then
                self.projectile = Projectile({x = player_middle_x, y = player_middle_y, color = color})
                Timer.tween(0.3, {[self.projectile] = {x = nearest_door.x, y = nearest_door.y + 8}}):finish(function()
                  self.projectile = nil
                end)
           else

               local intersect_point_left_x, ipl_y = intersectionPoint(player_middle_x, player_middle_y, direction_x, direction_y, nearest_tile.x, nearest_tile.y, 0, 1)
               local intersect_point_right_x, ipr_y = intersectionPoint(player_middle_x, player_middle_y, direction_x, direction_y, nearest_tile.x + TILE_SIZE, nearest_tile.y, 0, 1)
               local intersect_point_top_x, ipt_y = intersectionPoint(player_middle_x, player_middle_y, direction_x, direction_y, nearest_tile.x, nearest_tile.y, 1, 0)
               local intersect_point_bot_x, ipb_y = intersectionPoint(player_middle_x, player_middle_y, direction_x, direction_y, nearest_tile.x, nearest_tile.y + TILE_SIZE, 1, 0)

               --ipt может быть фолс, учитывай это, ниарест сайд - хуйня, переделай
               local dist_left, dist_right, dist_top, dist_bot = 100000, 100000, 100000, 100000
               if ipl_y then
                   dist_left = distance(player_middle_x, player_middle_y, intersect_point_left_x, ipl_y)
               end
               if ipr_y then
                   dist_right = distance(player_middle_x, player_middle_y, intersect_point_right_x, ipr_y)
               end
               if ipt_y then
                   dist_top = distance(player_middle_x, player_middle_y, intersect_point_top_x, ipt_y)
               end
               if ipb_y then
                   dist_bot = distance(player_middle_x, player_middle_y, intersect_point_bot_x, ipb_y)
               end

               local nearest_side = math.min(dist_left, dist_right, dist_top, dist_bot)

               local side = ''
               if nearest_side == dist_left then
                   side = 'left'
                   inters_p_x, inters_p_y = intersect_point_left_x, ipl_y
               elseif nearest_side == dist_right then
                   side = 'right'
                   inters_p_x, inters_p_y = intersect_point_right_x, ipr_y
               elseif nearest_side == dist_top then
                   side = 'top'
                   inters_p_x, inters_p_y = intersect_point_top_x, ipt_y
               elseif nearest_side == dist_bot then
                   side = 'bot'
                   inters_p_x, inters_p_y = intersect_point_bot_x, ipb_y
               end

               self.projectile = Projectile({x = player_middle_x, y = player_middle_y, color = color})
               Timer.tween(0.3, {[self.projectile] = {x = inters_p_x, y = inters_p_y}}):finish(function()
                   self.level:create_portal(color, nearest_tile, side)
                   self.projectile = nil
                end)
           end
       end
    end

    self.level:update(dt)
    self.player:update(dt)
    Timer.update(dt)
end

function PlayState:render()
    love.graphics.setColor(95, 80, 10, 255)
    love.graphics.rectangle('fill', 0, 0, 400, 400)
    love.graphics.setColor(255, 255, 255, 255)
    self.player:render()
    self.level:render()

    --draw aiming line
    local cur_x, cur_y  = self.player.x + PLAYER_WIDTH / 2, self.player.y + TILE_SIZE / 3
    local x, y = push:toGame(love.mouse.getPosition())

    local direction_x, direction_y = x - cur_x, y - cur_y
    direction_x, direction_y = normalize(direction_x, direction_y)

    love.graphics.setColor(150, 150, 150, 255)
    for i = 1, 40 do
        if i % 2 == 0 then
            love.graphics.line(cur_x, cur_y, cur_x + 3 * direction_x, cur_y + 3 * direction_y)
        end
        cur_x, cur_y = cur_x + 3 * direction_x, cur_y + 3 * direction_y
    end

    
    if self.projectile then
        self.projectile:render()
    end
end
