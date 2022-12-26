function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'TwitterNote' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'TWTNOTE_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0); --custom notesplash color, why not
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', -20);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 1);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
end

local shootAnims = {"singLEFTmiss", "singDOWNmiss", "singUPmiss", "singRIGHTmiss"}
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'TwitterNote' then
		playSound('shoot', 0.5);
		characterPlayAnim('dad', shootAnims[direction + 1], false);
		characterPlayAnim('boyfriend', 'dodge', true);
		setProperty('boyfriend.specialAnim', true);
		setProperty('dad.specialAnim', true);
		setPropertyFromGroup("notes", id, "ignoreNote", getRandomBool(bias))
		cameraShake('camGame', 0.01, 0.2)
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'TwitterNote' and difficulty == 2 then
		setProperty('health', -1);
		playSound('shoot', 0.5);
	elseif noteType == 'TwitterNote' and difficulty == 1 then
		setProperty('health', getProperty('health')-0.8);
		runTimer('bleed', 0.2, 20);
		playSound('hankded', 0.6);
		characterPlayAnim('boyfriend', 'hurt', true);
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
	if loopsLeft >= 1 then
		setProperty('health', getProperty('health')-0.001);
	end
end

-- crash prevention
function onUpdate() end
function onUpdatePost() end