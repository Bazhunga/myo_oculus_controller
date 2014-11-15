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

	--Message Sending
    if unlocked and pose ~= "rest" then
    	if edge == "off" then
    		sendMsg (pose, edge) 
    	end
    end
    -- Unlock
    if pose == "fist" then
    	if unlocked == false then
    		myo.debug("Unlocked!")
    	end
        if edge == "off" then
            -- Actually unlock when pose is released in case the user holds it for a
            -- while.
            unlock()
        elseif edge == "on" and not unlocked then
            -- Vibrate twice on unlock.
            -- We do this when the pose is made for better feedback.
            myo.vibrate("short")
            myo.vibrate("short")
            extendUnlock()
        end
    end

    
   	
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
	unlockedSince = myo.getTimeMilliseconds()

	if pose == "fist" then
		myo.debug("You see this pose? It's the screw you pose!")
		myo.keyboard("a", "press")
		myo.keyboard("return","press")
	end

	--[[if pose == "fingersSpread" then
		myo.debug("This pose is extremely apologetic! I'm so sorry...")
		myo.keyboard("c", "press")
		myo.keyboard("return","press")
	end	]]

	if pose == "waveIn" then
		--if myo.getArm() == "left" then
			--myo.debug ("I WANN TURN RIGHT YO BEEP BEEP")
			--myo.keyboard("b", "press")
			--myo.keyboard("return","press")
		--else
			--myo.debug("This pose indicates that I want to turn left :)")
			--extendUnlock()
		--end
		myo.debug("This pose indicates that I want to turn left :)")
		myo.keyboard("b", "press")
		myo.keyboard("return","press")

	end

	if pose == "waveOut" then
		--if myo.getArm() == "left" then
			--myo.debug("This pose indicates that I want to turn left :)")
			--myo.keyboard("b", "press")
			--myo.keyboard("return","press")


		--else
			--myo.debug ("I WANN TURN RIGHT YO BEEP BEEP")

		--end
		myo.debug("This pose indicates that I want to turn left :)")
		myo.keyboard("b", "press")
		myo.keyboard("return","press")

	end

	myo.vibrate("short")
end

