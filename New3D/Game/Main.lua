
local deltaTime = 0
function love.load()
    love.window.setMode(1400, 800, {resizable=true, vsync=0, minwidth=400, minheight=300})
end
 
local width = love.graphics.getWidth( )
local height = love.graphics.getHeight( )
 

 
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

    if INP_data[string.upper(scancode)]==nil then
        table.insert(INP_data,string.upper(scancode))
    end
    INP_data[string.upper(scancode)] = true

    --print("KEY DOWN: "..string.upper(scancode))
end
function love.keyreleased( key, scancode, isrepeat )
    INP_data[string.upper(scancode)] = false
end

 
function CalcVectors(x,y,dir)
    return {((x*math.cos(dir))+(y*math.sin(dir))), ((y*math.cos(dir))-(x*math.sin(dir)))}
end
function getAngles(x,y,z,xdir,ydir,zdir)
    local x3,y3,z3 , v1,v2,v3 = 0
   
    local v1 = CalcVectors(x,y,0-zdir)
    x3 = v1[1]
    y3 = v1[2]
    local v2 = CalcVectors(x3,z,0-ydir)
    x3 = v2[1]
    z3 = v2[2]
    local v3 = CalcVectors(z3,y3,xdir)
    z3 = v3[1]
    y3 = v3[2]
 
    return {x3,y3,z3}
end
function project(rX,rY,rZ,xdir,ydir,zdir,dist)
    local X = rX + Cam.X
    local Y = rY + Cam.Y
    local Z = rZ + Cam.Z
 
    local finlv1 = getAngles(X,Y,Z,xdir,ydir,zdir)
    local m1 = 240 / ((finlv1[3] + dist) * math.tan(Cam.FOV/2))
    local RRx = finlv1[1]*m1
    local RRy = finlv1[2]*m1
   
    if (m1 > 0) then
        return nil --//TODO: Find a way to get all poly points w/out just pcalling it
    end

    local Table = {RRx,RRy,m1}
    return Table
 
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


    if INP_data.RIGHT then
        Cam.YDIR = Cam.YDIR + ((100/180)*math.pi)*(dt)
    end
    if INP_data.LEFT then
        Cam.YDIR = Cam.YDIR - (100/180)*math.pi*(dt)
    end
   
    if INP_data.UP then
        Cam.XDIR = Cam.XDIR - (100/180)*math.pi*(dt)
    end
    if INP_data.DOWN then
        Cam.XDIR = Cam.XDIR + (100/180)*math.pi*(dt)
    end
 
end
 
 
function love.draw()
    width = love.graphics.getWidth( )
    height = love.graphics.getHeight( )
 
 
    love.graphics.setColor(255,255,255,1)
    love.graphics.print("FPS: "..math.floor (1/deltaTime))
 
    local pos = project(0,0,0,Cam.XDIR,Cam.YDIR,Cam.ZDIR,0)
    love.graphics.rectangle("fill",pos[1]+(width/2),pos[2]+(height/2),5,5)
    local pos = project(0,1,0,Cam.XDIR,Cam.YDIR,Cam.ZDIR,0)
    love.graphics.rectangle("fill",pos[1]+(width/2),pos[2]+(height/2),5,5)
    local pos = project(1,0,0,Cam.XDIR,Cam.YDIR,Cam.ZDIR,0)
    love.graphics.rectangle("fill",pos[1]+(width/2),pos[2]+(height/2),5,5)
    local pos = project(0,0,1,Cam.XDIR,Cam.YDIR,Cam.ZDIR,0)
    love.graphics.rectangle("fill",pos[1]+(width/2),pos[2]+(height/2),5,5)
 
end
 
 

