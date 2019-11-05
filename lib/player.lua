local sheetz = require("lib/sheetz")
local command = require("lib/command")
local state = require("lib/state")

-- default values
Player = {
  x = 0,
  y = 0,
  xOffset = 0,
  yOffset = 0,
  yVelocity = 0,
  xVelocity = 0,
  maxXVelocity = 5,
  jumpHeight = -300,
  gravity = -500,
  acceleration = 20,
  animations = {}
}

function Player:new(o)
  
  -- set prototype
  local o = o or {}
  setmetatable(o, self)
  self.__index = self

  -- bind commands
  o.escape = command.quit
  o.right = command.moveRight
  o.left = command.moveLeft
  o.k = command.jump
  o.noop = command.noop

  -- set initial state
  o.state = state.standing

  return o
end

function Player:handleInput(input)
  
  return self.state.handleInput(self, input)
end

function Player:moveRight(dt)
  self.state = state.walking

  local newxv = self.xVelocity + (self.acceleration * dt)

  if newxv > self.maxXVelocity then
    self.xVelocity = self.maxXVelocity
  else
    self.xVelocity = newxv
  end
end

function Player:moveLeft(dt)
  self.state = state.walking

  local newxv = self.xVelocity - (self.acceleration * dt)

  if newxv < -self.maxXVelocity then
    self.xVelocity = -self.maxXVelocity
  else
    self.xVelocity = newxv
  end
end

function Player:jump(dt)
  self.state = state.jumping

  self.yVelocity = self.jumpHeight
end

function Player:land()
  self.state = state.standing
  
  self.yVelocity = 0
  self.y = self.ground
end

return Player
