local Player = require("lib/player")
local Animation = require("lib/animation")

local player

function love.load()
  local image = love.graphics.newImage("assets/spritesheet.png")
  local spriteQuads = sheetz.make(2, 21, 692)

  local walk1 = love.graphics.newQuad(unpack(spriteQuads[29]))
  local walk2 = love.graphics.newQuad(unpack(spriteQuads[30]))
  local stand = love.graphics.newQuad(unpack(spriteQuads[20]))
  local jump = love.graphics.newQuad(unpack(spriteQuads[22]))

  local animations = {}

  animations.walking = Animation:new{
    image = image,
    quads = {walk1, walk2},
    delay = 0.1
  }

  animations.standing = Animation:new{
    image = image,
    quads = {stand}
  }

  animations.jumping = Animation:new{
    image = image,
    quads = {jump}
  }

  player = Player:new{
    animations = animations,
    
    -- player starts in center of screen
    x = love.graphics.getWidth() / 2,
    y = love.graphics.getHeight() / 2,
    
    -- set "origin" to middle bottom of sprite
    xOffset = 11,
    yOffset = 21
  }

  player.state.enter(player)

  player.ground = player.y
end

function love.update(dt)
  local input = {}

  for _, key in ipairs{"escape", "left", "right", "k"} do
    if love.keyboard.isDown(key) then
      table.insert(input, key)
    end
  end

  -- move the player horizontally
  player.x = player.x + player.xVelocity

  -- TODO: this really needs to be handled in player, command, or state code!
  -- Alternatively, this might be physics code if I implement friction
  -- slow down when not pressing a directional button
  if not (input["left"] or input["right"]) then
    player.xVelocity = player.xVelocity * 0.8
  end

  local cmd = player:handleInput(input)
  if cmd then cmd(player, dt) end

  -- jump physics
  if player.yVelocity ~= 0 then
    player.y = player.y + player.yVelocity * dt
    player.yVelocity = player.yVelocity - player.gravity * dt
  end

  -- jump landing
  if player.y > player.ground then
    player:land()
  end

  player.animation:update(dt)
end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  
  love.graphics.rectangle(
    'fill',
    0,
    love.graphics.getHeight() / 2,
    love.graphics.getWidth(),
    love.graphics.getHeight() / 2
  )

  player.animation:draw(
    (player.x - player.xOffset),
    (player.y - player.yOffset),
    love.graphics.draw
  )

  love.graphics.print(player.state.name)
end
