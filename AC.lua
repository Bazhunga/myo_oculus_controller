--require "os"
scriptId = 'com.AutoComis.examples.myFirstScript'

function onForegroundWindowChange(app, title) --This is a callback defined by Myo Script
	return true
end
--Unlock Mechanism
function unlock()
	unlocked = true
	extendUnlock()
end

function extendUnlock()
	unlockedSince = myo.getTimeMilliseconds()
end

function onPoseEdge(pose, edge)
	myo.debug(pose .. ": " .. edge)	
    sendMsg (pose, edge) 
end

function onPeriodic()
	--Locking
	if unlockedSince ~= nil then
	    if myo.getTimeMilliseconds() - unlockedSince >= 2000 and unlocked == true then
	    	lock()
	    	myo.vibrate("short")
	    end
   	end
end
function lock ()
	myo.debug("Locked!")
	unlocked = false
end

function sendMsg (pose, edge)
	if pose == "fist" then
		myo.debug("Moving backwards")
		myo.keyboard("s", "press")
	end

	--[[if pose == "fingersSpread" then
		myo.debug("This pose is extremely apologetic! I'm so sorry...")
		myo.keyboard("c", "press")
		myo.keyboard("return","press")
	end	]]

	if pose == "waveIn" then
		if myo.getArm() == "left" then
			myo.debug ("Go right")
			myo.keyboard("d", "press")
		else
			myo.debug ("Go Left")
			myo.keyboard("a", "press")
		--else
			--myo.debug("This pose indicates that I want to turn left :)")
			--extendUnlock()
		end

	end

	if pose == "waveOut" then
		if myo.getArm() == "left" then
			myo.debug ("Go left")
			myo.keyboard("a", "press")
		else
			myo.debug ("Go right")
			myo.keyboard("d", "press")
		end

	end

	if pose == "fingersSpread" then
		myo.debug("Moving Forwards")
		myo.keyboard("w", "press")
	end

	myo.vibrate("short")
end

