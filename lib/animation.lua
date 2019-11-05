local Animation = {frame = 1, timer = 0, delay = 1}

function Animation:new(o)
  o = o or {}
  self.__index = self
  setmetatable(o, self)
  return o
end

function Animation:update(dt)
  self.timer = self.timer + dt

  if self.timer > self.delay then
    self.frame = (self.frame % #self.quads) + 1
    self.timer = 0
  end
end

function Animation:draw(x, y, drawFn)
  drawFn(self.image, self.quads[self.frame], x, y)
end

return Animation
