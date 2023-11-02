function onCreate()
	-- background shit
	makeLuaSprite('hombre_room', 'hombre_room', -600, -300);
	setLuaSpriteScrollFactor('stageback', 0.9, 0.9);
	
	makeLuaSprite('no', 'no', -650, 600);
	setLuaSpriteScrollFactor('hombre_roomf', 0.9, 0.9);
	scaleObject('hombre_roomf', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('no', 'stage_light', -125, -100);
		setLuaSpriteScrollFactor('no', 0.9, 0.9);
		scaleObject('no', 1.1, 1.1);
		
		makeLuaSprite('no', 'stage_light', 1225, -100);
		setLuaSpriteScrollFactor('no', 0.9, 0.9);
		scaleObject('no', 1.1, 1.1);
		setPropertyLuaSprite('no', 'flipX', true); --mirror sprite horizontally

		makeLuaSprite('no', 'no', -500, -300);
		setLuaSpriteScrollFactor('no', 1.3, 1.3);
		scaleObject('no', 0.9, 0.9);
	end

	addLuaSprite('hombre_room', false);
	addLuaSprite('hombre_roomf', false);
	addLuaSprite('no', false);
	addLuaSprite('no', false);
	addLuaSprite('no', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end