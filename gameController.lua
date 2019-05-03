grid = {}
grid.size = 5
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
      love.graphics.setColor(1,1,1)
      love.graphics.rectangle("fill", 575+i*(wh+space), 155+j*(wh+space), wh, wh)
      if checkSelected(i, j) == true then
        --in love 11, setColor uses 0-1 instead of 0-255
        love.graphics.setColor(0.3,0.8,0.3, pathTimer/pathTimerMax)
        love.graphics.rectangle("fill", 575+i*(wh+space), 155+j*(wh+space), wh, wh)
      end
    end
  end
end

function checkSelected(w, h)
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

function createPath()
  currentPathX = 0
  currentPathY = 0
  streakX = 0
  streakY = 0
  
  for i=0,(2*grid.size)-2,1 do
    table.insert(path.x, currentPathX)
    table.insert(path.y, currentPathY)
    --randomized direction
    dir = math.random(1,50)
    if dir <=25 and currentPathX < grid.size-1 and streakX < 4 then
      currentPathX = currentPathX + 1
      streakX = streakX + 1
      streakY = 0
    elseif dir >=26 and currentPathY < grid.size-1 and streakY < 4 then
      currentPathY = currentPathY + 1
      streakY = streakY + 1
      streakX = 0
    elseif currentPathY < grid.size-1 then
      currentPathY = currentPathY + 1
    elseif currentPathX < grid.size-1 then
      currentPathX = currentPathX + 1
    end
  end
end
