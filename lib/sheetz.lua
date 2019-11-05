sheetz = {}

function sheetz.make(gutter, spriteWidth, sheetWidth)
  function position(n)
    return gutter + ((n - 1) * (spriteWidth + gutter))
  end

  function quad(i, j)
    return {position(i), position(j), spriteWidth, spriteWidth, sheetWidth, sheetWidth}
  end

  quads = {}

  local max = (sheetWidth - gutter) / (spriteWidth + gutter)

  for i = 1, max do
    for j = 1, max do
      quads[i + ((j - 1) * max)] = quad(i, j)
    end
  end

  return quads
end

return sheetz
