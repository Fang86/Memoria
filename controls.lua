function love.keypressed(k)
  if k == 'escape' then
    love.event.quit()
  end
  
  --[[
  if gamestate == 'playing' then
    if (k == 'up' or k == 'w') and (getSelected("y") <= 1) then
      
    elseif (k == 'right' or k == 'd') then
      
    elseif (k == 'down' or k == 's') then
      
    elseif (k == 'left' or k == 'a') then
      
    end
  end]]
end