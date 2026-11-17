--make sure the gimbal sensor is to the right of the computer--
local gimbal = peripheral.wrap("right")
local CW = peripheral.wrap("Create_RotationSpeedController_number")
local CCW = peripheral.wrap("Create_RotationSpeedController_number")
--Rename 'Create_RotationSpeedController_number' exactly the peripheral name of the connected rotation speed controllers.
--CW means clockwise, and it must connect to the propeller that produces a counterclockwise moment, same for CCW which mean Counterclockwise.

local integral = 0
local lastError = 0
local lasttarget = 0
local Oldtime = 0

--This is where you enter your PID values.
local Kp = 2.2
local Kd = 2.8
local Ki = 0

--DO NOT TOUCH ANYTHING BELOW HERE, UNLESS YOU UNDERSTAND WHAT IT IS DOING.

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
lastError = newError
sleep(0)
end
