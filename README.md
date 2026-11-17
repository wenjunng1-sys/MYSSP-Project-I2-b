# README
Below is the description of what each program does, including the steps that I used to analyse the system and produce results.

# MYSSPdrone.lua
This contains the PID controller loop, edit only Kp Kd Ki values for the system. For the peripherals, rename them to be exactly the peripheral names of the components used. eg, "Create_RotationalSpeedController_0"

# InputDataRead.lua
Reads a file called "random-input.txt" and reads through the lines and maps them to the propellers RPM. the contents of "random-input.txt" should be pseudo random generated from the MATLAB program "MATLAB data processes.txt"

# OutputAngleWrite.lua
Reads the system current angle and records into a file called "log.txt", this relies on the redstone signal generated from "#InputDataRead.lua" to determine start and stop times.

# SystemOutputTest.lua
Also uses the same redstone signal to start, but has its own internal timer to stop after some time, total time spent recording the system can be changed by editing the variable "time".

#MATLAB data processes.txt
Generates pseudo random numbers for the file "random-input.txt", and when a valid log file containing the systems angle are provided, it will also plot generate a iddata file with the pseudo random as input and the log file you provided as angle output. This iddata file can be used directly in System Identification Toolbox.

# MATLAB SystemOutputPlotter.txt
you import the log file containing the angles of the system recovering from a fixed angle e,g. 50 degrees. This is used to verify the behaviour of the final tuned system after Control System Designer.

# PIPELINE
Step one: run "MATLAB data processes.txt" and retrieve the file "random-input.txt", copy and paste it over into the file directory "...\saves\MYSSP I2-b\computercraft\computer\0". 

Step two: Inside Minecraft, go to the computer labeled "1" and inside its terminal type "OutputAngleWrite", it should start executing, but print out "awaiting start signal". It will only start when you start the program in Step three.

Step three: Inside Minecraft, go to the computer labeled "0" and inside its terminal type "InputDataread" to execute the program. This will start reading the file "random-input.txt" while sending the signal to computer 1 in step two to begin recording.

Step four: once the program in Step three has finished, go to "...\saves\MYSSP I2-b\computercraft\computer\1" and copy the file "log.txt" into MATLAB.

Step five: Inside MATLAB, run "MATLAB data processes.txt", make sure edit line 28 with the actual name of the file you copied over containing the system's data.

Step six: once a iddata file have been created, import it to System Identification Toolbox. Use "Transfer function model" and change the number of "poles" or "zeros" to find a best fit. Ideally, both values should only be in the range of 0-4, avoid the number of "zeros" being greater than the number of "poles". Model should be calculated using discrete timesteps of 0.05s instead of continuous.

Step seven: Once you obtained a satisfactory model, import it to Control System designer. Select "PID tuning" in "Tuning methods". The controller type for this specific system is a PD system. (integral gain is excluded as system is balanced at its target angle of 0 degrees). Change "Response time" and "Transient behaviour" until you achieved desired results based on the graph "Root locus editor for Looptransfer_C" and "Step response" graph.

Step eight: Extract the PD vales from step seven, open "...\saves\MYSSP I2-b\computercraft\computer\2", open "MYSSPdrone.lua" and copy your PD values into "MYSSPdrone.lua". You can now go back into Minecraft, and type "MYSSPdrone" into computer 2. If necessary, you can type "SystemOutputTest" into computer 1 to record the system behaviour.

Step nine: with the "log.txt" file now containing the behaviour of your system in Minecraft, copy it into MATLAB and run "MATLAB SystemOutputPlotter.txt" to plot a graph of the system's angle over time. Rename line 10 to the actual file name you have copied over.

# NOTES
the values generated from Control System Designer are not perfect and may not perform well on the actual system, it is common to require manual corrections to the PD values to fine tune the system. Throughout my own testings, the Kd value is frequently about 3 times larger than what it should be. However, this behaviour may not reflect the behavior your actual system.
