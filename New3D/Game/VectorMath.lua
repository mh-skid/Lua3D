local _3D={}

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
        return {
            (math.abs(finlv1[1])/finlv1[1]) * width,
            (math.abs(finlv1[2])/finlv1[2]) * height,
            false
        }

       --return {nil} --//TODO: Find a way to get all poly points w/out just pcalling it
                   --// ok 7:05 pm idk if pcalling is efficient but READ INTO IT SOON ENOUGH
                
    end


    return {finlv1[1]*m1,finlv1[2]*m1,true}
 
end

return _3D