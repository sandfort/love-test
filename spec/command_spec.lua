local command = require("../lib/command")

describe("command", function()
  local player
  local dt = "arbitrary value"

  describe(".jump", function()
    setup(function()
      player = mock{jump = function() end}
      command.jump(player, dt)
    end)

    it("calls Player:jump", function()
      assert.spy(player.jump).was.called_with(player, dt)
    end)
  end)

  describe(".moveRight", function()
    setup(function()
      player = mock{moveRight = function() end}
      command.moveRight(player, dt)
    end)

    it("calls Player:moveRight", function()
      assert.spy(player.moveRight).was.called_with(player, dt)
    end)
  end)

  describe(".moveLeft", function()
    setup(function()
      player = mock{moveLeft = function() end}
      command.moveLeft(player, dt)
    end)

    it("calls Player:moveLeft", function()
      assert.spy(player.moveLeft).was.called_with(player, dt)
    end)
  end)

  describe(".stop", function()
    setup(function()
      player = mock{stop = function() end}
      command.stop(player, dt)
    end)
    it("calls Player:stop", function()
      assert.spy(player.stop).was.called_with(player, dt)
    end)
  end)
end)
