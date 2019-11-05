local sheetz = require("../lib/sheetz")

describe("sheetz", function()

  describe(".make", function()
    local quads

    setup(function()
      quads = sheetz.make(2, 21, 692)
    end)

    it("returns a table of quads indexed by position", function()
      local x, y, width, height, sw, sh = unpack(quads[1])

      assert.are_same(2, x)
      assert.are_same(2, y)
      assert.are_same(21, width)
      assert.are_same(21, height)
      assert.are_same(692, sw)
      assert.are_same(692, sh)

      x, y, width, height, sw, sh = unpack(quads[20])

      assert.are_same(439, x)
      assert.are_same(2, y)

      x, y, width, height, sw, sh = unpack(quads[50])

      assert.are_same(439, x)
      assert.are_same(25, y)
    end)
  end)
end)
