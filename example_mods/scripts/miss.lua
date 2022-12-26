local enabled = true

if enabled then
	local default = 15
	local bias = default

	function opponentNoteMiss()
		bias = bias - 1
	end

	function oppoenntNoteHit()
		bias = (bias >= default) and (bias + 0.5) or default
	end

	function opponentNoteMissCheck(id, direction, note_type, sustained)
		if (sustained and getPropertyFromGroup("notes", id, "ignoreNote")) or (not sustained) then
			setPropertyFromGroup("notes", id, "ignoreNote", getRandomBool(bias))
		end
	end
end

-- crash prevention
function onUpdate() end
function onUpdatePost() end