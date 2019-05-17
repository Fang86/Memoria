require 'lib'

function love.load()
  timer = 0
  currentTimer = nil
  setsize = love.window.setMode(1920, 1080)
  gamestate = 'mainmenu'
  
  --initGrid(grid.size)
  
  pathTimerMax = 75
  pathTimer = pathTimerMax
  delayTimerMax = 150
  delayTimer = delayTimerMax
  
  difficulty = 'easy'
  
  bg = {}
  bg.mainmenu = love.graphics.newImage('assets/memoria.png')
  bg.difficulty = love.graphics.newImage('assets/difficulty.png')
  
  ui:load()
end

function love.update(dt)
  timer = timer + 1
  
  if gamestate == 'playing' then
    checkLost()
    checkWin() 
  end

  updateGrid()
  gui:update(dt)
  ui:update()
end

function love.draw()
  
  --Backgrounds
  if gamestate == 'mainmenu' then
    love.graphics.draw(bg.mainmenu, 0, 0)
  elseif gamestate == 'difficultyMenu' then
    love.graphics.draw(bg.difficulty, 0, 0)
  end
  
  if gamestate == 'playing' then
    --background
    love.graphics.setColor(.5,.5,.5)
    love.graphics.rectangle('fill', 0, 0, 1920, 1080)
    love.graphics.setColor(.7,.7,.7)
    love.graphics.rectangle('fill', 500, 100, 900, 880)
    love.graphics.setColor(1,1,1)
    
    --Delay bar
    love.graphics.rectangle("fill", 0, 15, 250*(delayTimer/delayTimerMax), 15)
  end
  
  --Horizontal Center
  --love.graphics.rectangle("fill", 0, 1080/2, 2000, 1)
  
  drawGrid(grid.size, grid.wh, grid.border, grid.space)
  gui:draw()
  ui:draw()
  love.graphics.print("Mouse X: " .. love.mouse.getX() .. ", Mouse Y: " .. love.mouse.getY(), 50, 50)
end

function getTimer()
  return timer
end

function love.mousepressed(x, y, button)
	gui:mousepress(x, y, button) -- pretty sure you want to register mouse events
end

function love.mousereleased(x, y, button)
	gui:mouserelease(x, y, button)
end