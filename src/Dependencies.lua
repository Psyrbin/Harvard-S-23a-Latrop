
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'


require 'src/constants'
require 'src/StateMachine'
require 'src/Util'


require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/StartState'
require 'src/states/EndState'
require 'src/states/PlayerWalkState'
require 'src/states/PlayerFallState'

require 'src/Player'
require 'src/Tile'
require 'src/Level'
require 'src/Portal'
require 'src/Box'
require 'src/Door'
require 'src/Button'
require 'src/Panel'
require 'src/Projectile'
require 'src/Finish'
require 'src/Levels'
require 'src/geometry'


gTextures = {
    ['player'] = love.graphics.newImage('graphics/player.png'),
    ['tiles'] = love.graphics.newImage('graphics/tiles.png'),
    ['portal_lr'] = love.graphics.newImage('graphics/portal_lr.png'),
    ['portal_bt'] = love.graphics.newImage('graphics/portal_bt.png'),
    ['box'] = love.graphics.newImage('graphics/box.png'),
    ['door'] = love.graphics.newImage('graphics/door.png'),
    ['button'] = love.graphics.newImage('graphics/button.png'),
    ['panel'] = love.graphics.newImage('graphics/panel.png'),
    ['finish'] = love.graphics.newImage('graphics/finish.png')
}

gFrames = {
    ['player'] = GenerateQuads(gTextures['player'], PLAYER_WIDTH, TILE_SIZE),
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),
    ['portal_lr'] = GenerateQuads(gTextures['portal_lr'], PORTAL_THICKNESS, TILE_SIZE),
    ['portal_bt'] = GenerateQuads(gTextures['portal_bt'], TILE_SIZE, PORTAL_THICKNESS),
    ['box'] = GenerateQuads(gTextures['box'], BOX_SIZE, BOX_SIZE),
    ['door'] = GenerateQuads(gTextures['door'], DOOR_WIDTH, TILE_SIZE),
    ['button'] = GenerateQuads(gTextures['button'], BUTTON_WIDTH, BUTTON_HEIGHT),
    ['panel'] = GenerateQuads(gTextures['panel'], TILE_SIZE, PANEL_HEIGHT),
    ['finish'] = GenerateQuads(gTextures['finish'], TILE_SIZE, 3)
}
