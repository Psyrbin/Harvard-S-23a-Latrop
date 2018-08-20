Projectile = Class{}

function Projectile:init(params)
    self.x = params.x
    self.y = params.y
    self.color = params.color
end

function Projectile:render()
    if self.color == 'blue' then
        love.graphics.setColor(0, 76, 115, 255)
    else
        love.graphics.setColor(229, 145, 49, 255)
    end
    love.graphics.rectangle('fill', self.x, self.y, 3, 3)
    love.graphics.setColor(255, 255, 255, 255)
end
