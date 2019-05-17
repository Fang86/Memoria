function love.keypressed(k)
  if k == 'escape' then
    love.event.quit()
  end
  
  if gamestate == 'playing' then
    if delayTimer <= 0 then
      if (k == 'right' or k == 'd') and path.selected.x < grid.size then
        table.insert(path.selected.prevX, path.selected.x)
        table.insert(path.selected.prevY, path.selected.y)
        path.selected.x = path.selected.x + 1
        moves = moves + 1
      elseif (k == 'down' or k == 's') and path.selected.y < grid.size then
        table.insert(path.selected.prevY, path.selected.y)
        table.insert(path.selected.prevX, path.selected.x)
        path.selected.y = path.selected.y + 1
      end
    end
  end
  
  --[[if gamestate == 'playing' then
    if (k == 'up' or k == 'w') and (getSelected("y") <= 1) then
      
    elseif (k == 'right' or k == 'd') then
      
    elseif (k == 'down' or k == 's') then
      
    elseif (k == 'left' or k == 'a') then
      
    end
  end]]
end