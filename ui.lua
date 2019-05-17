ui = {}



function ui:load()
  --(X1, Y1), (X2, Y2), (X3, Y3)
  easyVerts1 = {823,415, 823,375, 863,395}
  easyVerts2 = {1096,415, 1096,375, 1056,395}
  normalVerts1 = {823,512, 823,472, 863,492}
  normalVerts2 = {1096,512, 1096,472, 1056,492}
  hardVerts1 = {823,610, 823,570, 863,590}
  hardVerts2 = {1096,610, 1096,570, 1056,590}
  selectedVerts1 = easyVerts1
  selectedVerts2 = easyVerts2
  
  wGui = 12*gui.style.unit
  hGui = 4*gui.style.unit
  yGui = hGui + 2*gui.style.unit
  xGui = 1920/2-wGui/2
  
  playButton = gui:button('Play', {x = xGui, y = 540-yGui-hGui/2, w = wGui, h = hGui}) -- a button(label, pos, optional parent) gui.style.unit is a standard gui unit (default 16), used to keep the interface tidy
	playButton.click = function(this, x, y) -- set element:click() to make it respond to gui's click event
    initGrid(grid.size)
    gamestate = 'playing'
	end
  
  difficultyButton = gui:button('Difficulty', {x = xGui, y = 540-hGui/2, w = wGui, h = hGui})
	difficultyButton.click = function(this, x, y) 
		gamestate = 'difficultyMenu'
	end
    
    easyButton = gui:button('Easy', {x = xGui, y = 540-hGui/2-9*gui.style.unit, w = wGui, h = hGui})
    easyButton.click = function(this, x, y) 
      difficulty = "easy"
      grid.size = 3
      pathTimerMax = 60
      selectedVerts1 = easyVerts1
      selectedVerts2 = easyVerts2
      grid.wh = 750/grid.size
    end
    
    normalButton = gui:button('Normal', {x = xGui, y = 540-hGui/2-3*gui.style.unit, w = wGui, h = hGui})
    normalButton.click = function(this, x, y) 
      difficulty = "normal"
      grid.size = 4
      pathTimerMax = 45
      selectedVerts1 = normalVerts1
      selectedVerts2 = normalVerts2
      grid.wh = 750/grid.size
    end
    
    hardButton = gui:button('Hard', {x = xGui, y = 540-hGui/2+3*gui.style.unit, w = wGui, h = hGui})
    hardButton.click = function(this, x, y) 
      difficulty = "hard"
      grid.size = 5
      pathTimerMax = 30
      selectedVerts1 = hardVerts1
      selectedVerts2 = hardVerts2
      grid.wh = 750/grid.size
    end
    
    difficultyBackButton = gui:button('Back', {x = xGui, y = 540-hGui/2+9*gui.style.unit, w = wGui, h = hGui})
    difficultyBackButton.click = function(this, x, y) 
      gamestate = 'mainmenu'
    end
  
  exitButton = gui:button('Exit', {x = xGui, y = 540+yGui-hGui/2, w = wGui, h = hGui})
	exitButton.click = function(this, x, y)
		love.event.quit()
	end
  
  --[[continueButton = gui:button('Play', {x = xGui, y = 540-yGui-hGui/2, w = wGui, h = hGui}) -- a button(label, pos, optional parent) gui.style.unit is a standard gui unit (default 16), used to keep the interface tidy
	continueButton.click = function(this, x, y) -- set element:click() to make it respond to gui's click event
		gamestate = 'playing'
	end]]
  
end
function ui:update()
  
  if gamestate == 'mainmenu' then
    playButton:show()
    difficultyButton:show()
    exitButton:show()
  else
    playButton:hide()
    difficultyButton:hide()
    exitButton:hide()
	end
  
  if gamestate == 'difficultyMenu' then
    easyButton:show()
    normalButton:show()
    hardButton:show()
    difficultyBackButton:show()
  else
    easyButton:hide()
    normalButton:hide()
    hardButton:hide()
    difficultyBackButton:hide()
  end
end
function ui:draw()
  
  if gamestate == 'difficultyMenu' then
    love.graphics.setColor(1,1,1)
    love.graphics.polygon('fill', selectedVerts1)
    love.graphics.polygon('fill', selectedVerts2)
  end
end

--ui needs to be completed, then scoring/difficulties