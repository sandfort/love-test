local Player = require("lib/player")
local state = require("lib/state")

describe("Player", function()

  describe(":handleInput", function()

    it("delegates to the current state", function()
      local player = Player:new()
      local mockState = mock{handleInput = function() end}
      local input = "whatever"
      player.state = mockState

      player:handleInput(input)

      assert.spy(mockState.handleInput).was.called_with(player, input)
    end)
  end)

  describe("movement", function()
    local player
    local dt = 0.1

    local function resetPlayer()
      player.x = 0
      player.y = 0
      player.xVelocity = 0
      player.yVelocity = 0
      player.acceleration = 10
      player.maxXVelocity = 10
    end

    setup(function()
      player = Player:new{
        speed = 10
      }
    end)

    describe(":moveRight", function()
      setup(function()
        resetPlayer()
        
        player:moveRight(dt)
      end)
      
      it("increases the player's x velocity", function()
        assert.are.equal(1, player.xVelocity)
      end)

      it("sets the state to walking", function()
        assert.are_same(state.walking, player.state)
      end)

      describe("max velocity", function()
        setup(function()
          resetPlayer()
          player.maxXVelocity = 50
          player.xVelocity = 50

          player:moveRight(dt)
        end)
        
        it("doesn't set the velocity higher than max speed", function()
          assert.are.equal(player.maxXVelocity, player.xVelocity)
        end)
      end)
    end)

    describe(":moveLeft", function()
      setup(function()
        resetPlayer()
        
        player:moveLeft(dt)
      end)
      
      it("moves the player to the left", function()
        assert.are.equal(-1, player.xVelocity)
      end)

      it("sets the state to walking", function()
        assert.are_same(state.walking, player.state)
      end)

      describe("max velocity", function()
        setup(function()
          resetPlayer()
          player.maxXVelocity = 50
          player.xVelocity = -50

          player:moveLeft(dt)
        end)
        
        it("doesn't set the velocity lower than negative max speed", function()
          assert.are.equal(-player.maxXVelocity, player.xVelocity)
        end)
      end)
    end)
  end)
end)
