local module = {}

local Vectors = require("Vectors")

function getUnit(v2)
	local mag=(math.abs(v2.x)+math.abs(v2.y))
	return Vectors.createV2(v2.x/mag,v2.y/mag)
end
function getDot(v1, v2)
    return (v1.x * v2.x) + (v1.y * v2.y)
end



function module.GetTransform(WaveData, GridP, RunTime)
	local p = Vectors.createV3()
	for i,Wave in pairs(WaveData) do
		p = p + module.Calculate(Wave, GridP, RunTime)
	end
	
	return p
end

function module.GetHeightAndNormal(WaveData, GridP, RunTime)
	local p = Vectors.createV3()
	local tan = Vectors.createV3(1,0,0)
	local bi = Vectors.createV3(0,0,1)
	
	for i,Wave in pairs(WaveData) do
		local _p, _tan, _bi = module.Calculate(Wave, GridP, RunTime, true)
		p = p + _p
		tan = tan + _tan
		bi = bi + _bi
	end
	
	return p, tan, bi
end

function module.Calculate(Wave, GridP, RunTime, Ret)
	local steepness = Wave.z
	local wavelength = Wave.w
	local k = (math.pi/2)/wavelength
	local c = math.sqrt(9.8/k)
	local d = getUnit(Vectors.createV2(Wave.x, Wave.y))
	local f = k*getDot(d,Vectors.createV2(GridP.x-(c * _G.RunTime),GridP.z-(c * _G.RunTime)))
	--//This stupid fucking "local f = " line has literally made me want to paint the wall with my brains
	
	local a = steepness/k
	
	local cosf = math.cos(f)
	local sinf = math.sin(f)
	local tangent, binormal


	if Ret then
		tangent = Vectors.createV3(-d.x*d.x*(steepness*sinf), d.x*(steepness*cosf), -d.x*d.y*(steepness*sinf))
		binormal = Vectors.createV3(-d.x*d.y*(steepness*sinf), d.y*(steepness*cosf), -d.y*d.y*(steepness*sinf))
	end

	return Vectors.createV3(d.x*(a*cosf), a*sinf, d.y*(a*cosf)), tangent, binormal
end

return module
