local stop_countdown = true

function onCreatePost()
	if isStoryMode and not seenCutscene then
		callScript("scripts/neocam", "set_target", {"intro", 400, 400})
		callScript("scripts/neocam", "snap_target", {"intro"})
		
		callScript("scripts/neocam", "snap_zoom", {"game", 1.6})
		
		setProperty("camHUD.alpha", 0.0001)
	else
		setGlobalFromScript("scripts/neocam", "position_locked", true)
	end
end
-- Gameplay interactions

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer("move_cam", 0.25)
		runTimer("stop", 3)
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

local timer_stuff = {
	move_cam = function()
		callScript("scripts/neocam", "focus", {"center", 3, "cubeinout", true})
		callScript("scripts/neocam", "zoom", {"game", 0.9, 4, "cubeinout"})
	end,
	
	stop = function()
		doTweenAlpha("hud_fadein", "camHUD", 1, 3, "cubeout")
		setProperty("inCutscene", false)
		runHaxeCode("game.startCountdown();")
	end
}
function onTimerCompleted(tag) if timer_stuff[tag] then timer_stuff[tag]() end end

function onTimerCompleted(tag, loops, loopsLeft)
	if timer_stuff[tag] then 
		timer_stuff[tag]()
	end
end

