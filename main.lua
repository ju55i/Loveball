function love.load()
	love.graphics.setLine(10)
	love.graphics.setCaption("Löveball")
	windowheight = love.graphics.getHeight()
	windowwidth = love.graphics.getWidth()
	math.randomseed(os.time())
	ballx = math.random(100,300)
	bally = math.random(100,300)
	balldx = 5
	balldy = -5
	paddlewidth = 100
	paddleheight = 10
	paddlerect = {0, windowheight-20, paddlewidth, paddleheight}

	love.graphics.setColor(0,0,0,255)
	love.graphics.setBackgroundColor(255,255,255)
end

function draw_paddle()
	mousex, mousey = love.mouse.getPosition()
	paddlerect = {mousex - 30, windowheight-20, paddlewidth, paddleheight }
	love.graphics.rectangle("fill", paddlerect[1], paddlerect[2], paddlewidth, paddleheight)
	-- Rounded edges for the paddle
	love.graphics.circle("fill", paddlerect[1], paddlerect[2]+5, 5)
	love.graphics.circle("fill", paddlerect[1]+paddlewidth, paddlerect[2]+5, 5)
end
	
function draw_ball()	
	love.graphics.circle("fill", ballx, bally, 10)
end

-- Collision detection function.
-- Checks if box1 and box2 overlap.
-- w and h mean width and height.
function check_collision(box1x, box1y, box1w, box1h, box2x, box2y, box2w, box2h)
    if box1x > box2x + box2w - 1 or -- Is box1 on the right side of box2?
       box1y > box2y + box2h - 1 or -- Is box1 under box2?
       box2x > box1x + box1w - 1 or -- Is box2 on the right side of box1?
       box2y > box1y + box1h - 1    -- Is b2 under b1?
    then
        return false                -- No collision. Yay!
    else
        return true                 -- Yes collision. Ouch!
    end
end

-- Animates the ball and handles collisions
function animate_ball()
	-- Check ball and border collisions
	if bally > windowheight-5 or bally < 5 then 
		balldy = -balldy
	end
	if ballx > windowwidth-5 or ballx < 5 then 
		balldx = -balldx
	end

	-- Create ball rect for collision check
	ballrect = {ballx-5, bally-5, 10, 10}
	
	-- Check for ball and paddle collision
	if check_collision(paddlerect[1], paddlerect[2], paddlerect[3], paddlerect[4],
		ballrect[1], ballrect[2], ballrect[3], ballrect[4]) then
		balldy = -balldy - 1
	end
	
	-- Move the ball
	bally = bally + balldy
	ballx = ballx + balldx
end

function love.update()
	animate_ball()
end

function love.draw()
	draw_paddle()
	draw_ball()
	--love.graphics.draw(myimage, mousex, mousey, 0, 1, 1, 100, 100)
    --love.graphics.print("Hello World", 400, 300)
end

