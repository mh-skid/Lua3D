
local deltaTime = 0
function love.load()
    love.window.setMode(1400, 800, {resizable=true, vsync=0, minwidth=400, minheight=300})
end
 
local width = love.graphics.getWidth( )
local height = love.graphics.getHeight( )
 
--//shit fuck library
local  obj =  require("OBJLoader")
local _3D  =  require("VectorMath")

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




--[[
debug.setmetatable(true, {__len = function (value) return value and 1 or 0 end})
ok like WHAT the ACTUAL FUCK IS THAT??? WHY??? '__len' SHOULDNT BE USED YOU FUCKING IDIOT

]]

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

function DrawPoint(data,c)
    love.graphics.setColor(c[1]/255,c[2]/255,c[3]/255,1)
   -- pcall(function()
        love.graphics.rectangle("fill",(data[1]+(width/2))-1,(data[2]+(height/2))-1,1,1) --//no way love2d has "fill" as an arg like the engine isnt coded by gay twink femboys
    --end)                                                                                --// TODO: Write a graphics lib that isnt outright homosexual in every way
end


function love.draw()
    width = love.graphics.getWidth( )
    height = love.graphics.getHeight( )
    --[[
    love.graphics.setColor(255,255,255,1)
    love.graphics.print("FPS: "..math.floor (1/deltaTime))
    ]]

    local Color = {255,50,50}

    for i,v in pairs(Monkey) do
        local pos = _3D.project(v.x,v.y,v.z,Cam.XDIR,Cam.YDIR,Cam.ZDIR,0)
        DrawPoint(pos,Color)
    end

    --//TODO: --make less ass--
    --//it has been made less ass 👍
end
 
 

