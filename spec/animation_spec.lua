local Animation = require("../lib/animation")

describe("Animation", function()
  describe(":new", function()
    it("should set the fields", function()
      local image = "arbitrary image"
      local quads = "arbitrary quads"
      local delay = 1
      local frame = 1
      local timer = 0

      local anim = Animation:new{
        image = image,
        quads = quads,
        delay = delay
      }

      assert.are.same(image, anim.image)
      assert.are.same(quads, anim.quads)
      assert.are.same(delay, anim.delay)
      assert.are.same(frame, anim.frame)
      assert.are.same(timer, anim.timer)
    end)
  end)

  describe(":update", function()
    local image = "image"
    local quads = {"quad1", "quad2"}
    local anim

    before_each(function()
        anim = Animation:new{
          image = image,
          quads = quads,
          delay = delay
        }
    end)

    it("should increase the time since last frame", function()
      anim:update(0.1)

      assert.are.same(0.1, anim.timer)
    end)

    describe("when the timer has not passed the delay", function()

      it("should not advance the animation", function()
        assert.are.same(1, anim.frame)

        anim:update(0.1)
        assert.are.same(1, anim.frame)
      end)
    end)

    describe("when the timer has passed the delay", function()

      it("should advance the animation one frame", function()
        assert.are.same(1, anim.frame)

        anim:update(1.1)
        assert.are.same(2, anim.frame)
      end)
    end)

    it("should wrap", function()
      anim:update(0.1)
      anim:update(0.1)
      assert.are.same(1, anim.frame)
    end)
  end)

  describe(":draw", function()

    it("should call the draw function", function()
      local image = {}
      local quads = {"quad1", "quad2"}
      local drawFn = spy.new(function() end)
      anim = Animation:new{image = image, quads = quads}

      anim:draw(5, 10, drawFn)

      assert.spy(drawFn).was_called_with(image, quads[1], 5, 10)
    end)
  end)
end)
