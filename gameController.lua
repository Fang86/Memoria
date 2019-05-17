grid = {}
grid.size = 3
grid.wh = 150
grid.border = 10
grid.space = 4

function initGrid(size)
  --grid = {}
  grid.w = {}
  grid.h = {}
  
  
  path = {}
  path.x = {}
  path.y = {}
  path.selected = {}
  path.selected.x = 0
  path.selected.y = 0
  path.selected.prevX = 0
  path.selected.prevY = 0
  moves = 1
  movesMax = (grid.size*2)
  
  --This prepares system for creating randomized numbers. 
  --First few numbers are not randomized normally when using one without using random before it. 
  --Don't know why yet
  math.randomseed(os.time())
  math.random(); math.random(); math.random()
  
  createPath()
  
  for i=0,size-1,1 do
    table.insert(grid.w, i)
    for j=0,size-1,1 do
      table.insert(grid.h, j)
    end
  end
end

function updateGrid()
end

function drawGrid (size, wh, border, space)
  --60 ticks/second
  if gamestate == 'playing' then
    if pathTimer > 0 then
      pathTimer = pathTimer - 1
    end
    
    if delayTimer > 0 then
      delayTimer = delayTimer - 1
    end
    
    --Double for loop which creates a grid -- i = horizontal  j = vertical
    for i=0,size-1,1 do
      for j=0,size-1,1 do
        --[[Creates grid squares
        border = space outside of grid
        i and j = value on the current iteration of the loop
        space = space between each square
        wh = width height -- since they are squares, the width and height are the same]]
        love.graphics.setColor(.4,.6,.6)
        love.graphics.rectangle("fill", 575+i*(wh+space), 155+j*(wh+space), wh, wh)
        if checkActive(i, j) == true then
          --in love 11, setColor uses 0-1 instead of 0-255
          love.graphics.setColor(0,0.4,0, pathTimer/pathTimerMax)
          love.graphics.rectangle("fill", 575+i*(wh+space), 155+j*(wh+space), wh, wh)
        end
        for k in pairs(path.selected.prevX) do
          love.graphics.setColor(0,.4,0)
          love.graphics.rectangle("fill", 575+path.selected.prevX[k]*(wh+space), 155+path.selected.prevY[k]*(wh+space), wh, wh)
        end
      end
    end
    
    love.graphics.setColor(0,0.45,0)
    love.graphics.rectangle("fill", 575+path.selected.x*(wh+space), 155+path.selected.y*(wh+space), wh, wh)
    love.graphics.setColor(1,1,1)
    
    love.graphics.print(path.selected.x.."/"..(grid.size-1).."  "..path.selected.y.."/"..(grid.size-1), 100, 100)
  end
  
  if gamestate == 'lost' then
    love.graphics.setColor(1,0,0)
    love.graphics.print("Game Over!", 500, 500)
    love.graphics.setColor(1,1,1)
    if currentTimer == nil then
      currentTimer = getTimer()
    end
    if timer-60 == currentTimer then
      gameReset()
      currentTimer = nil
    end
  end
end

function checkActive(w, h)
  for i in pairs(path.x) do
    --i is the number of variables in the path tables(5x5 grid has 9 length path)
    --The number of variable the for loop is on is used below
    --Path.x,path.y uses a pseudo-coordinate system based on i
    --This checks the input coordinates with the active coordinates
    if w == path.x[i] and h == path.y[i] then
      return true
    end
  end
end

--[[function getSelected(xy)
  if xy == 'y' then
    return path.selected.y
  elseif xy == 'x' then
    return path.selected.x
  end
end]]

function createPath()
  currentPathX = 0
  currentPathY = 0
  streakX = 0
  streakY = 0
  
  for i=0,movesMax-1,1 do
    table.insert(path.x, currentPathX)
    table.insert(path.y, currentPathY)
    --randomized direction
    dir = math.random(1,50)
    if dir <=25 and currentPathX < grid.size-1 and streakX < grid.size/2 then
      currentPathX = currentPathX + 1
      streakX = streakX + 1
      streakY = 0
    elseif dir >=26 and currentPathY < grid.size-1 and streakY < grid.size/2 then
      currentPathY = currentPathY + 1
      streakY = streakY + 1
      streakX = 0
    elseif currentPathY < grid.size-1 then
      currentPathY = currentPathY + 1
    elseif currentPathX < grid.size-1 then
      currentPathX = currentPathX + 1
    end
  end
  currentPathX = 0
  currentPathY = 0
  streakX = 0
  streakY = 0
end

function gameReset() 
  moves = 1
  path.selected.y = 0
  path.selected.x = 0
  pathTimer = pathTimerMax
  
  delayTimer = delayTimerMax
  --[[for k in pairs (path.selected.prevX) do
    path.selected.prevX[k] = nil
  end
  for k in pairs (path.selected.prevY) do
    path.selected.prevY[k] = nil
  end]]
  
  for k in pairs (path.x) do
    path.x[k] = nil
  end
  for k in pairs (path.y) do
    path.y[k] = nil
  end
  
  if gamestate == 'won' then
    grid.size = grid.size + 1
    movesMax = (grid.size*2)
    createPath()
    grid.wh = 750/grid.size
    gamestate = 'playing'
  elseif gamestate == 'lost' then
    grid.size = grid.sizeDiff
    grid.size = grid.sizeDiff
    movesMax = (grid.size*2)
    createPath()
    grid.wh = 750/grid.size
    gamestate = 'playing'
  end
end

function checkLost()
  if moves and movesMax then
    if moves <= movesMax then
      if path.selected.y ~= path.y[moves] or path.selected.x ~= path.x[moves] then
      end
    else
    gamestate = 'lost'
    end
  end
  end

function checkWin()
  if gamestate == "playing" then
  --if path.selected.x == grid.size-1 and path.selected.y == grid.size-1 then
    gamestate = 'won'
    gameReset()
  end
  end
