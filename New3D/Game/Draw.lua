local Draw = {}

function Draw.DrawPoint(data,c)
    love.graphics.setColor(c[1]/255,c[2]/255,c[3]/255,1)
    love.graphics.rectangle("fill",(data[1]+(_G.width/2))-1,(data[2]+(_G.height/2))-1,1,1) --//no way love2d has "fill" as an arg like the engine isnt coded by gay twink femboys
end                                                                       --// TODO: Write a graphics lib that isnt outright homosexual in every way

function Draw.DrawLine(data,c)
    -- data 1-2 == point a, data 3-4 == point b
    love.graphics.setColor(c[1]/255,c[2]/255,c[3]/255,1)
    love.graphics.line({data[1]+(_G.width/2), data[2]+(_G.height/2), data[3]+(_G.width/2), data[4]+(_G.height/2)})
end


return Draw