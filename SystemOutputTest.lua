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
redstone.setAnalogOutput("right", 15)

for i = 1, 400, 1 do

local pitch, roll = table.unpack(gimbal.getAngles())
file.writeLine(roll)
print(i)
sleep(0)

end
redstone.setAnalogOutput("right", 0)
print("program ended")
file.close()


