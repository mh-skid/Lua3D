
local deltaTime = 0
function love.load()
    love.window.setMode(1400, 800, {resizable=true, vsync=0, minwidth=400, minheight=300})
end
 
local width = love.graphics.getWidth( )
local height = love.graphics.getHeight( )
 
--//shit fuck library
obj = require("objdata")



local Cam = {
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
--//less gay inputs

local _3D={}
_3D.__index = _3D

function _3D.CalcVectors(x,y,dir)
    return {((x*math.cos(dir))+(y*math.sin(dir))), ((y*math.cos(dir))-(x*math.sin(dir)))}
end
function _3D.getAngles(x,y,z,xdir,ydir,zdir)
    local x3,y3,z3 , v1,v2,v3 = 0
   
    local v1 = _3D.CalcVectors(x,y,0-zdir)
    x3 = v1[1]
    y3 = v1[2]
    local v2 = _3D.CalcVectors(x3,z,0-ydir)
    x3 = v2[1]
    z3 = v2[2]
    local v3 = _3D.CalcVectors(z3,y3,xdir)
    z3 = v3[1]
    y3 = v3[2]
 
    return {x3,y3,z3}
end
function _3D.project(rX,rY,rZ,xdir,ydir,zdir,dist)
    local X = rX + Cam.X
    local Y = rY + Cam.Y
    local Z = rZ + Cam.Z
 
    local finlv1 = _3D.getAngles(X,Y,Z,xdir,ydir,zdir)
    local m1 = 240 / ((finlv1[3] + dist) * math.tan(Cam.FOV/2))
    
    if (m1 > 0) then
        return nil --//TODO: Find a way to get all poly points w/out just pcalling it
                   --// ok 7:05 pm idk if pcalling is efficient but READ INTO IT SOON ENOUGH
    end


    return {finlv1[1]*m1,finlv1[2]*m1,true}
 
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
    pcall(function()
        love.graphics.rectangle("fill",(data[1]+(width/2))-2,(data[2]+(height/2))-2,4,4) --//no way love2d has "fill" as an arg like the engine isnt coded by gay twink femboys
    end)                                                                                --// TODO: Write a graphics lib that isnt outright homosexual in every way
end
 
 
function love.draw()
    width = love.graphics.getWidth( )
    height = love.graphics.getHeight( )
    --[[
    love.graphics.setColor(255,255,255,1)
    love.graphics.print("FPS: "..math.floor (1/deltaTime))
    ]]


    local Color = {255,50,50}
    local pos = _3D.project(0,0,0,Cam.XDIR,Cam.YDIR,Cam.ZDIR,0)
    DrawPoint(pos,Color)

    local pos = _3D.project(0,1,0,Cam.XDIR,Cam.YDIR,Cam.ZDIR,0)
    DrawPoint(pos,Color)

    local pos = _3D.project(1,0,0,Cam.XDIR,Cam.YDIR,Cam.ZDIR,0)
    DrawPoint(pos,Color)

    local pos = _3D.project(0,0,1,Cam.XDIR,Cam.YDIR,Cam.ZDIR,0)
    DrawPoint(pos,Color)
    --//TODO: make less ass
end
 
 

