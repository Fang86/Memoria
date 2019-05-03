require 'lib'

function love.load()
  timer = 0
  setsize = love.window.setMode(1920, 1080)
  gamestate = 'playing'
  
  initGrid(5)
  
  pathTimerMax = 90
  pathTimer = pathTimerMax
  
  delayTimerMax = 600
  delayTimer = delayTimerMax
end

function love.update(dt)
  
end

function love.draw()
  --love.graphics.print("Mouse X: " .. love.mouse.getX() .. ", Mouse Y: " .. love.mouse.getY(), 50, 50)
  if gamestate == 'playing' then
    drawGrid(grid.size, grid.wh, grid.border, grid.space)
  end
end
