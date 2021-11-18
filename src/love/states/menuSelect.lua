--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

Copyright (C) 2021  HTV04

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------]]

local leftFunc, rightFunc, confirmFunc, backFunc, drawFunc

local menuState

local logo = love.filesystem.load("sprites/menu/logoBump.lua")()

local pinkDots = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/pinkDots")))

local sideMenu = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/Credits_LeftSide")))

local options = love.filesystem.load("sprites/menu/menuButtons.lua")()
local story = love.filesystem.load("sprites/menu/menuButtons.lua")()
local freeplay = love.filesystem.load("sprites/menu/menuButtons.lua")()

local menuButton = 1

local menuNum = 1

local weekNum = 1
local songNum, songAppend
local songDifficulty = 2

local menuArtRandon

local menuArt

local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

--local music = love.audio.newSource("music/menu/menu.ogg", "stream")

local function switchMenu(menu)
	if menu == 4 then
		love.window.showMessageBox("lol", "Not implemented yet :P")

		return switchMenu(1)
	elseif menu == 3 then
		function leftFunc()
			if menuState == 3 then
				songDifficulty = (songDifficulty > 1) and songDifficulty - 1 or 3
			elseif menuState == 2 then
				songNum = (songNum > 1) and songNum - 1 or #weekMeta[weekNum][2]
			else
				weekNum = (weekNum > 1) and weekNum - 1 or #weekMeta
			end
		end
		function rightFunc()
			if menuState == 3 then
				songDifficulty = (songDifficulty < 3) and songDifficulty + 1 or 1
			elseif menuState == 2 then
				songNum = (songNum < #weekMeta[weekNum][2]) and songNum + 1 or 1
			else
				weekNum = (weekNum < #weekMeta) and weekNum + 1 or 1
			end
		end
		function confirmFunc()
			if menuState == 3 then
				--music:stop()

				status.setLoading(true)

				graphics.fadeOut(
					0.5,
					function()
						songAppend = difficultyStrs[songDifficulty]

						storyMode = false

						Gamestate.switch(weekData[weekNum], songNum, songAppend)

						status.setLoading(false)
					end
				)
			else
				if menuState == 1 then
					songNum = 1
				end

				menuState = menuState + 1
			end
		end
		function backFunc()
			if menuState == 1 then
				switchMenu(1)
			else
				menuState = menuState - 1
			end
		end
		function drawFunc()
			graphics.setColor(1, 1, 1)

			if input:getActiveDevice() == "joy" then
				love.graphics.printf("Left Stick/D-Pad: Select | A: Confirm | B: Back", -640, 350, 1280, "center", nil, 1, 1)
			else
				love.graphics.printf("Arrow Keys: Select | Enter: Confirm | Escape: Back", -640, 350, 1280, "center", nil, 1, 1)
			end
		end
	elseif menu == 2 then
		weekNum = 1
		songNum = 1

		function confirmFunc()
			
		end
		function backFunc()
			if menuState == 1 then
				switchMenu(1)
			else
				menuState = menuState - 1
			end
		end
		function drawFunc()
			graphics.setColor(1, 1, 1)

			if input:getActiveDevice() == "joy" then
				love.graphics.printf("Left Stick/D-Pad: Select | A: Confirm | B: Back", -640, 350, 1280, "center", nil, 1, 1)
			else
				love.graphics.printf("Arrow Keys: Select | Enter: Confirm | Escape: Back", -640, 350, 1280, "center", nil, 1, 1)
			end
		end
	else
		function confirmFunc()
			switchMenu(menuNum + 1)
		end
		function backFunc()
			graphics.fadeOut(0.5, love.event.quit)
		end
		function drawFunc()
			graphics.setColor(1, 1, 1)

			if input:getActiveDevice() == "joy" then
				love.graphics.printf("Left Stick/D-Pad: Select | A: Confirm | B: Exit", -640, 350, 1280, "center", nil, 1, 1)
			else
				love.graphics.printf("Arrow Keys: Select | Enter: Confirm | Escape: Exit", -640, 350, 1280, "center", nil, 1, 1)
			end
		end
	end

	menuState = 1
end

story.y = 125
freeplay.y = 200
options.y = 275

story.sizeX, story.sizeY, freeplay.sizeX, freeplay.sizeY, options.sizeX, options.sizeY = 1.5, 1.5, 1.5, 1.5, 1.5, 1.5

sideMenu.x = -375

logo.sizeX, logo.sizeY = 0.55, 0.55

story.x, freeplay.x, options.x = -250, -250, -250

logo.x, logo.y = -345, -210

pinkDots.sizeX, pinkDots.sizeY = 1.2, 1.2



--music:setLooping(true)

return { 
	enter = function(self, previous)
		menuArtRandom = love.math.random(1, 16)
		menuButton = 1
		songNum = 0
        story:animate("story hover", true)
        freeplay:animate("freeplay", true)
        options:animate("options", true)
		logo:animate("anim", true)
		if menuArtRandom == 1 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/pixelmonika.lua")()
		elseif menuArtRandom == 2 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/senpai.lua")()
		elseif menuArtRandom == 3 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/dokitogether.lua")()
			menuArt.sizeX, menuArt.sizeY = 0.55, 0.55
		elseif menuArtRandom == 4 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/dokitogetheralt.lua")()
		elseif menuArtRandom == 5 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/monika.lua")()
		elseif menuArtRandom == 6 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/akihamoniduo.lua")()
		elseif menuArtRandom == 7 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/cyrixstatic.lua")()
		elseif menuArtRandom == 8 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/minusmonikapixel.lua")()
		elseif menuArtRandom == 9 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/fumo.lua")()
		elseif menuArtRandom == 10 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/natsuki.lua")()
		elseif menuArtRandom == 11 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/sayori.lua")()
		elseif menuArtRandom == 12 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/yuri.lua")()
		elseif menuArtRandom == 13 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/protag.lua")()
		elseif menuArtRandom == 14 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/sayozip.lua")()
		elseif menuArtRandom == 15 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/sunnat.lua")()
		elseif menuArtRandom == 16 then
			menuArt = love.filesystem.load("sprites/menu/menuArt/tabiandyuri.lua")()
		end

		menuArt.x, menuArt.y = 235, 50
		if menuArtRandom ~= 3 then
			menuArt.sizeX, menuArt.sizeY = 0.7, 0.7
		end


		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9

		switchMenu(1)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

		--music:play()
	end,

	update = function(self, dt)
        options:update(dt)
        story:update(dt)
        freeplay:update(dt)
		logo:update(dt)
		menuArt:update(dt)

		if not graphics.isFading() then
			if input:pressed("up") then
				audio.playSound(selectSound)

                if menuButton ~= 1 then
                    menuButton = menuButton - 1
                else
                    menuButton = 3
                end

                if menuButton == 1 then
                    story:animate("story hover", true)
                    freeplay:animate("freeplay", true)
                    options:animate("options", true)
                elseif menuButton == 2 then
                    story:animate("story", true)
                    freeplay:animate("freeplay hover", true)
                    options:animate("options", true)
                elseif menuButton == 3 then
                    story:animate("story", true)
                    freeplay:animate("freeplay", true)
                    options:animate("options hover", true)
                end

			elseif input:pressed("down") then
				audio.playSound(selectSound)

                if menuButton ~= 3 then
                    menuButton = menuButton + 1
                else
                    menuButton = 1
                end

                if menuButton == 1 then
                    story:animate("story hover", true)
                    freeplay:animate("freeplay", true)
                    options:animate("options", true)
                elseif menuButton == 2 then
                    story:animate("story", true)
                    freeplay:animate("freeplay hover", true)
                    options:animate("options", true)
                elseif menuButton == 3 then
                    story:animate("story", true)
                    freeplay:animate("freeplay", true)
                    options:animate("options hover", true)
                end

			elseif input:pressed("confirm") then
				audio.playSound(confirmSound)

				--confirmFunc()
                if menuButton == 1 then
                    status.setLoading(true)
					menuArt = nil
                    Gamestate.switch(menuWeek)
                    status.setLoading(false)
                elseif menuButton == 2 then
                    status.setLoading(true)
					menuArt = nil
                    Gamestate.switch(menuFreeplay)
                    status.setLoading(false)
                elseif menuButton == 3 then
                    love.window.showMessageBox("lol", "Not implemented yet :P")
                end
			elseif input:pressed("back") then
				audio.playSound(selectSound)

				Gamestate.switch(menu)
			end
		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			pinkDots:draw()
			sideMenu:draw()
			logo:draw()
			menuArt:draw()

            story:draw()
            options:draw()
            freeplay:draw()

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)
			love.graphics.pop()
		love.graphics.pop()
	end,

	leave = function(self)
		--music:stop()

		Timer.clear()
	end
}
