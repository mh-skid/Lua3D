
local deltaTime = 0
function love.load()
    love.window.setMode(1400, 800, {resizable=true, vsync=0, minwidth=400, minheight=300})
end
 
_G.width = love.graphics.getWidth( )
_G.height = love.graphics.getHeight( )
 
--//shit fuck library
local  obj =  require("OBJLoader")
local _3D  =  require("VectorMath")
local Draw =  require("Draw")


Monkey = obj.load("Monkey.obj")

_G.Cam = {
    X = 5;
    Y = 0;
    Z = 0;
 
    XDIR = 0;
    YDIR = -90;
    ZDIR = 0;
 
    FOV = 70;

    SPEED = 5;
}
 
 --//INPUTS
local INP_data = {}
function love.keypressed( key, scancode, isrepeat )
    --//scancode = string of input

    if not (INP_data[string.upper(scancode)]) then
        table.insert(INP_data,string.upper(scancode))
    end
    INP_data[string.upper(scancode)] = true

    --print("KEY DOWN: "..string.upper(scancode))
end
function love.keyreleased( key, scancode, isrepeat )
    INP_data[string.upper(scancode)] = false
end


--//DRAW GRAPHICS
 
function love.update(dt)
    deltaTime = dt

    --//Holy mother of fuck
    Cam.X = Cam.X + (((math.sin(Cam.YDIR)*dt) * (INP_data.W and 1 or 0) + (math.cos(Cam.YDIR)*dt) * (INP_data.D and 1 or 0)) - ((math.sin(Cam.YDIR)*dt) * (INP_data.S and 1 or 0)) - ((math.cos(Cam.YDIR)*dt) * (INP_data.A and 1 or 0))) * Cam.SPEED
    Cam.Z = Cam.Z + (((math.cos(-Cam.YDIR)*dt) * (INP_data.W and 1 or 0) + (math.sin(-Cam.YDIR)*dt) * (INP_data.D and 1 or 0)) - ((math.sin(-Cam.YDIR)*dt) * (INP_data.A and 1 or 0) + (math.cos(-Cam.YDIR)*dt) * (INP_data.S and 1 or 0))) * Cam.SPEED
    Cam.Y = Cam.Y - ((dt) * Cam.SPEED) * ((INP_data.E and 1 or 0)+(INP_data.Q and -1 or 0))

    Cam.YDIR = Cam.YDIR + (((100/180)*math.pi)*(dt) * (INP_data.RIGHT and 1 or 0))  - ((100/180)*math.pi*(dt) * (INP_data.LEFT and 1 or 0))
    Cam.XDIR = Cam.XDIR + ((100/180)*math.pi*(dt) * (INP_data.UP and -1 or 0)) + ((100/180)*math.pi*(dt) * (INP_data.DOWN and 1 or 0))
 
end



function love.draw()
    _G.width = love.graphics.getWidth( )
    _G.height = love.graphics.getHeight( )
    --[[
    love.graphics.setColor(255,255,255,1)
    love.graphics.print("FPS: "..math.floor (1/deltaTime))
    ]]

    local Color = {255,255,255}

<<<<<<< HEAD
=======

>>>>>>> d333a061f24d0ad43955a7fc2dc63366113f6140
    for i,v in pairs(Monkey) do
        local pos = _3D.project(v.x,v.y,v.z,Cam.XDIR,Cam.YDIR,Cam.ZDIR,0)
        Draw.DrawPoint(pos,Color)
    end
<<<<<<< HEAD
=======

>>>>>>> d333a061f24d0ad43955a7fc2dc63366113f6140
end
 
 

