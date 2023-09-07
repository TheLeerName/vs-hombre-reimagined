local lastBeat = 0

local defaultY = 0

function onCreatePost() defaultY = getCharacterY('dad') end

function onUpdate(elapsed)
	if getSongPosition() - lastBeat > crochet then
		setProperty('iconP2.flipX', curBeat % 2 == 0) 

		if getProperty('dad.animation.curAnim.name') == 'idle' then
			setProperty('dad.flipX', curBeat % 2 == 0) 

			setCharacterY('dad', getCharacterY('dad') + 20)
		end

		lastBeat = getSongPosition() 
	end

	setCharacterY('dad', lerp(defaultY, getCharacterY('dad'), boundTo(1 - (elapsed * 3), 0, 1)))

	setProperty('iconP2.angle', (getProperty('healthBar.percent') > 80) and getRandomFloat(-5, 5) or 0)
end

function boundTo(number, min, max)
	return math.max(min, math.min(max, number))
end
 
function lerp(a, b, c)
	return a + (b - a) * c
end