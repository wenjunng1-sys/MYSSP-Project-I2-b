local CW = peripheral.wrap("Create_RotationSpeedController_5")
local CCW = peripheral.wrap("Create_RotationSpeedController_4")
local interval = 500
local lines = 80

redstone.setAnalogOutput("back", 15)

local text = fs.open("random-input.txt", "r")

for i = 1,lines,1 do


local nextTrigger = os.epoch("utc") + interval
local output = tonumber(text.readLine())

if output >= 0 then

CW.setTargetSpeed(0)
CCW.setTargetSpeed(output)

else

CW.setTargetSpeed(-output)
CCW.setTargetSpeed(0)

end

local sleeptime = nextTrigger - os.epoch("utc")
sleep((sleeptime/1000))
print(sleeptime)
end

redstone.setAnalogOutput("back", 0)

CW.setTargetSpeed(0)
CCW.setTargetSpeed(0)
text.close()

    
