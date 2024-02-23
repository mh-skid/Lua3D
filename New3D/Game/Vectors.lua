local Vectors = {}
Vectors.__index = Vector4

--// this is SUCH A PIECE OF SHIT CODE OH MY GU FUCKING GOD!!!!!!!!! AHHH RAHGHH 🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️

function Vectors.createV2(x,y)
	local self = setmetatable({}, Vector4)

	self.x = x or 0
	self.y = y or 0

	return self
end

function Vectors.createV3(x,y,z)
	local self = setmetatable({}, Vector4)

	self.x = x or 0
	self.y = y or 0
	self.z = z or 0

	return self
end

function Vectors.createV4(x,y,z,w)
	local self = setmetatable({}, Vector4)

	self.x = x or 0
	self.y = y or 0
	self.z = z or 0
	self.w = w or 0

	return self
end

return Vectors