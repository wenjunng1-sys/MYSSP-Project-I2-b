local gimbal = peripheral.wrap("right")
local CW = peripheral.wrap("Create_RotationSpeedController_5")
local CCW = peripheral.wrap("Create_RotationSpeedController_4")

local integral = 0
local lastError = 0
local lasttarget = 0
local Oldtime = 0

local Kp = 2.2
local Kd = 2.8
local Ki = 0

while true do
-- local Newtime = os.epoch('utc')
 local pitch, roll = table.unpack(gimbal.getAngles())

 local reference = 0
 
 local newError = reference - roll
 
	local point = (newError) * Kp

	local dt = (newError - lastError)

 derivative = (dt/0.05)*Kd
 
 integral = integral + (newError*0.05)*Ki

	correction = point + derivative + integral

 if correction > 0 then
 
 CW.setTargetSpeed(0)
 CCW.setTargetSpeed(correction)

else

 CW.setTargetSpeed(-correction)
 CCW.setTargetSpeed(0)

end

--print(correction)
--print(Newtime - Oldtime)

--Oldtime = Newtime
lastError = newError

sleep(0)
--might replace sleep function
--os.pullEvent("tick") 


end
