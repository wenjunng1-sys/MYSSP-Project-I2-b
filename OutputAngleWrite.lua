local gimbal = peripheral.wrap("left")
local file = fs.open("log.txt","w")
local i = 0
print("awaiting start signal")

while true do

if redstone.getAnalogInput("right") == 14 then

break

end

sleep(0)

end

print("start signal detected")
redstone.setAnalogOutput("back", 15)

while true do

if redstone.getAnalogInput("right") == 0 then

break

else

local pitch, roll = table.unpack(gimbal.getAngles())
file.writeLine(roll)
sleep(0)

end
end

print("program ended")
redstone.setAnalogOutput("back", 0)
file.close()


