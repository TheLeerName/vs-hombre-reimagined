--created with Super_Hugo's Stage Editor v1.6.3

function onCreate()

	makeLuaSprite('obj1', 'sky', -1600, -1278)
	setObjectOrder('obj1', 0)
	scaleObject('obj1', 3.4, 3.4)
	addLuaSprite('obj1', true)
	
	makeLuaSprite('obj2', 'clouds', -1640, -1005)
	setObjectOrder('obj2', 1)
	scaleObject('obj2', 3.4, 3.4)
	addLuaSprite('obj2', true)
	
	makeAnimatedLuaSprite('obj3', 'grass', -1523, 678)
	setObjectOrder('obj3', 2)
	scaleObject('obj3', 4.4, 4.4)
	addAnimationByPrefix('obj3', 'anim', 'grass0', 24, true)
	playAnim('obj3', 'anim', true)
	addLuaSprite('obj3', true)
	
	makeAnimatedLuaSprite('obj4', 'flag', -163, -232)
	setObjectOrder('obj4', 3)
	scaleObject('obj4', 4.4, 4.4)
	addAnimationByPrefix('obj4', 'anim', 'flag0', 24, true)
	playAnim('obj4', 'anim', true)
	addLuaSprite('obj4', true)
	
end