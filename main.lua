debug=true

function love.load ()
  --setup
  love.window.setFullscreen(true)
  backround=love.graphics.newImage('imgs/backround/space.png')
  --load player
  playerImg=love.graphics.newImage('imgs/player/playerShip.png')
  player={x=300,y=400,r=0,img=playerImg,shootTimer=0}
  --lasers
  lasers={}
  laserImg=love.graphics.newImage('imgs/player/playerLaser.png')
end
function love.update(dt)
  --quit
  if love.keyboard.isDown('escape')then
    love.event.quit()
  end
  --player movement
  if love.keyboard.isDown('right')then
    if player.r<360 then
      player.r=player.r+5
    else player.r=1
    end
  end
  if love.keyboard.isDown('left')then
    if player.r>0 then
      player.r=player.r-5
    else player.r=360
    end
  end
  if love.keyboard.isDown('up')then
    player.x=player.x+math.cos(math.rad(player.r-90))*10
    player.y=player.y+math.sin(math.rad(player.r-90))*10
  end
  --lasers
  player.shootTimer=player.shootTimer-1
  if love.keyboard.isDown('space')and
  player.shootTimer<=0 then
    table.insert(lasers,{x=player.x,y=player.y,r=player.r,img=laserImg})
    player.shootTimer=10
  end
  for l=1,#lasers do
    lasers[l].x=lasers[l].x+math.cos(math.rad(lasers[l].r-90))*25
    lasers[l].y=lasers[l].y+math.sin(math.rad(lasers[l].r-90))*25
  end
  for l=#lasers,1,-1 do
    if lasers[l].x>love.graphics.getWidth()+25 or
    lasers[l].x<-25 or
    lasers[l].y>love.graphics.getHeight()+25 or
    lasers[l].y<-25 then
      table.remove(lasers,l)
    end
  end
end
function love.draw()
  love.graphics.draw(backround,0,0,math.rad(1),love.graphics.getWidth()/backround:getWidth(),love.graphics.getHeight()/backround:getHeight())
  love.graphics.draw(player.img,player.x,player.y,math.rad(player.r), 1, 1, player.img:getWidth()/2,player.img:getHeight()/2)
for l=1,#lasers do
  love.graphics.draw(lasers[l].img, lasers[l].x, lasers[l].y,math.rad(lasers[l].r),1,1)
end
end
