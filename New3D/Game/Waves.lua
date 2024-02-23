local  Vectors =  require("Vectors")
local  Gerstner =  require("Gerstner")

local Waves = {
	Vectors.createV4(1,1,0.3,100),
	Vectors.createV4(0,1,0.25,120)
}


local mod={}
function mod.doshit()
    local p = Gerstner.GetTransform(Waves, Vectors.createV3(0,1,0), _G.RunTime)
    print(p)
end
return mod