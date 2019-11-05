local state = {}

state.standing = {name = "standing"}

function state.standing.enter(player)
  player.animation = player.animations.standing
end

function state.standing.handleInput(player, input)
  if input.escape then return player.escape end
  if input.right then return player.right end
  if input.left then return player.left end
  if input.k then return player.k end
end

state.jumping = {name = "jumping"}

function state.jumping.handleInput(player, input)
  if input.escape then return player.escape end

  return player.noop
end

state.walking = {name = "walking"}

function state.walking.handleInput(player, input)
  if input.escape then return player.escape end
  if input.k then return player.k end
  if input.right then return player.right end
  if input.left then return player.left end
  return player.noop
end

return state
