return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("menu/menuArt/sunnat_menu")),
    	-- Automatically generated from sunnat_menu.xml
	{
		{x = 10, y = 10, width = 830, height = 488, offsetX = -171, offsetY = 0, offsetWidth = 1178, offsetHeight = 584}, -- 1: sunday right0000
		{x = 850, y = 10, width = 830, height = 513, offsetX = -171, offsetY = 0, offsetWidth = 1178, offsetHeight = 584}, -- 2: sunday right0001
		{x = 1690, y = 10, width = 826, height = 513, offsetX = -171, offsetY = 0, offsetWidth = 1178, offsetHeight = 584}, -- 3: sunday right0002
		{x = 2526, y = 10, width = 994, height = 556, offsetX = -92, offsetY = 0, offsetWidth = 1178, offsetHeight = 584}, -- 4: sunday right0003
		{x = 10, y = 576, width = 994, height = 556, offsetX = -92, offsetY = 0, offsetWidth = 1178, offsetHeight = 584}, -- 5: sunday right0004
		{x = 1014, y = 576, width = 1178, height = 584, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 6: sunday right0005
	},
    {
        ["anim"] = {start = 1, stop = 6, speed = 24, offsetX = 0, offsetY = 0}
    },
    "anim",
    true
)