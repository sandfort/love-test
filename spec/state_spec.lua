local state = require("../lib/state")
local command = require("../lib/command")

describe("state", function()
  describe("standing", function()
    describe(".enter", function()
      it("sets the player animation to standing", function()
        local standingAnim = mock()
        local player = mock{
          animations = {
            standing = standingAnim
          }
        }
        state.standing.enter(player)
        assert.are.equal(standingAnim, player.animation)
      end)
    end)

    describe(".handleInput", function()
      local player

      setup(function()
        player = mock{
          moveRight = function() end,
          moveLeft = function() end,
          jump = function() end
        }
      end)
      
      describe("when right is pressed", function()
        setup(function()
          state.standing.handleInput(player, {command.moveRight})
        end)

        it("moves the player right", function()
          assert.spy(player.moveRight).was.called_with(player, dt)
        end)
      end)

      describe("when left is pressed", function()
        setup(function()
          state.standing.handleInput(player, {command.moveLeft})
        end)

        it("moves the player left", function()
          assert.spy(player.moveLeft).was.called_with(player, dt)
        end)
      end)

      describe("when jump is pressed", function()
        setup(function()
          cmd = state.standing.handleInput(player, {command.jump})
        end)

        it("makes the player jump", function()
          assert.spy(player.jump).was.called_with(player, dt)
        end)
      end)
    end)
  end)
end)
