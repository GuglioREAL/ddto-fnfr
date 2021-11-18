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

local upFunc, downFunc, confirmFunc, backFunc, drawFunc

local menuState

local menuNum = 1

local menuNumberState

local weekNum = 1
local songNum, songAppend
local songDifficulty = 2

local logo = love.filesystem.load("sprites/menu/logoBump.lua")()

local pinkDots = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/pinkDots")))

local sideMenu = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/Credits_LeftSide")))

local tracks = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/storymenu/tracks")))

local cursor = graphics.newImage(love.graphics.newImage(graphics.imagePath("menu/dokistory/cursor")))

local moni_story, sayo_story, nat_story, yuri_story, monk_story, protag_story

local difficultyAnim = love.filesystem.load("sprites/menu/storymenu/difficulty.lua")()



local difficultyStrs = {
	"-easy",
	"",
	"-hard"
}


moni_story = love.filesystem.load("sprites/dokistory/moni_story.lua")()

sayo_story = love.filesystem.load("sprites/dokistory/sayo_story.lua")()

nat_story = love.filesystem.load("sprites/dokistory/nat_story.lua")()

yuri_story = love.filesystem.load("sprites/dokistory/yuri_story.lua")()

monk_story = love.filesystem.load("sprites/dokistory/monk_story.lua")()

protag_story = love.filesystem.load("sprites/dokistory/protag_story.lua")()


local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

--local music = love.audio.newSource("music/menu/menu.ogg", "stream")

local function switchMenu(menu)
	if menu == 4 then
		love.window.showMessageBox("lol", "Not implemented yet :P")

		return switchMenu(1)
	elseif menu == 3 then
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

		function backFunc()
			Gamestate.switch(menu)
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
		
		function drawFunc()
			graphics.setColor(1, 1, 1)
			if input:getActiveDevice() == "joy" then
				love.graphics.printf("Left Stick/D-Pad: Select | A: Confirm | B: Exit", -640, 350, 1280, "center", nil, 1, 1)
			else
				love.graphics.printf("Arrow Keys: Select | Enter: Confirm | Escape: Exit", -640, 350, 1280, "center", nil, 1, 1)
			end
		end
	end

	menuState = 2
end




tracks.x, tracks.y = -400, 0

sideMenu.x = -375

moni_story.x, moni_story.y = -150, -50

sayo_story.x, sayo_story.y = 150, -50

nat_story.x, nat_story.y = 470, -50

yuri_story.x, yuri_story.y = moni_story.x, 200

monk_story.x, monk_story.y = sayo_story.x, yuri_story.y

protag_story.x, protag_story.y = nat_story.x, yuri_story.y

logo.sizeX, logo.sizeY = 0.55, 0.55

logo.x, logo.y = -345, -210

pinkDots.sizeX, pinkDots.sizeY = 1.2, 1.2

cursor.sizeX, cursor.sizeY = 1.097, 1.097

difficultyAnim.x, difficultyAnim.y = 225, 350

--music:setLooping(true)

return {
	enter = function(self, previous)

		obsession = 1

		menuNumberState = 1
        
		songNum = 0

		cam.sizeX, cam.sizeY = 0.9, 0.9
		camScale.x, camScale.y = 0.9, 0.9

		switchMenu(1)

		graphics.setFade(0)
		graphics.fadeIn(0.5)

		

		--music:play()

		function confirmFunc()
			menu:musicStop()
			songNum = 1

			status.setLoading(true)

			graphics.fadeOut(
				0.5,
				function()
					songAppend = difficultyStrs[songDifficulty]

					storyMode = true

					Gamestate.switch(weekData[weekNum], songNum, songAppend)

					status.setLoading(false)
				end
			)
		end
		
	end,




	update = function(self, dt)
		
		logo:update(dt)
		
		
		

		if not graphics.isFading() then
			if input:pressed("down") then
				audio.playSound(selectSound)

				
				weekNum = weekNum + 3
				
				if weekNum == 7 then
					weekNum = 1
				elseif weekNum == 8 then
					weekNum = 2
				elseif weekNum == 9 then
					weekNum = 3
				end

				if weekNum ~= 1 then
					moni_story:animate("moni static", true)
				elseif weekNum ~= 2 then
					sayo_story:animate("static", true)
				elseif weekNum ~= 3 then
					nat_story:animate("static", true)
				elseif weekNum ~= 4 then
					yuri_story:animate("static", true)
				elseif weekNum ~= 5 then
					monk_story:animate("static", true)
				elseif weekNum ~= 6 then
					protag_story:animate("static", true)
				end
				if weekNum == 1 then
					moni_story:animate("moni idle", true)
				elseif weekNum == 2 then
					sayo_story:animate("idle", true)
				elseif weekNum == 3 then
					nat_story:animate("idle", true)
				elseif weekNum == 4 then
					yuri_story:animate("idle", true)
				elseif weekNum == 5 then
					monk_story:animate("idle", true)
				elseif weekNum == 6 then
					protag_story:animate("idle", true)
				end
			elseif input:pressed("up") then
				audio.playSound(selectSound)

				weekNum = weekNum - 3
				
				if weekNum == 0 then
					weekNum = 6
				elseif weekNum == -1 then
					weekNum = 5
				elseif weekNum == -2 then
					weekNum = 4
				end

				if weekNum ~= 1 then
					moni_story:animate("moni static", true)
				elseif weekNum ~= 2 then
					sayo_story:animate("static", true)
				elseif weekNum ~= 3 then
					nat_story:animate("static", true)
				elseif weekNum ~= 4 then
					yuri_story:animate("static", true)
				elseif weekNum ~= 5 then
					monk_story:animate("static", true)
				elseif weekNum ~= 6 then
					protag_story:animate("static", true)
				end
				if weekNum == 1 then
					moni_story:animate("moni idle", true)
				elseif weekNum == 2 then
					sayo_story:animate("idle", true)
				elseif weekNum == 3 then
					nat_story:animate("idle", true)
				elseif weekNum == 4 then
					yuri_story:animate("idle", true)
				elseif weekNum == 5 then
					monk_story:animate("idle", true)
				elseif weekNum == 6 then
					protag_story:animate("idle", true)
				end

				
			elseif input:pressed("left") then
				audio.playSound(selectSound)
				if menuNumberState == 2 then
					if songDifficulty ~= 1 then
						songDifficulty = songDifficulty - 1
					else
						songDifficulty = 3 
					end
					if songDifficulty == 1 then
						difficultyAnim:animate("easy", true)
					elseif songDifficulty == 2 then
						difficultyAnim:animate("normal", true)
					elseif songDifficulty == 3 then
						difficultyAnim:animate("hard", true)
					end
				else
					if weekNum ~= 1 then
						weekNum = weekNum - 1
					elseif weekNum == 1 then
						weekNum = 6
					end
				end
					
			elseif input:pressed("right") then
				audio.playSound(selectSound)
				
				if menuNumberState == 2 then
					if songDifficulty ~= 3 then
						songDifficulty = songDifficulty + 1
					else
						songDifficulty = 1
					end
					if songDifficulty == 1 then
						difficultyAnim:animate("easy", true)
					elseif songDifficulty == 2 then
						difficultyAnim:animate("normal", true)
					elseif songDifficulty == 3 then
						difficultyAnim:animate("hard", true)
					end
				else
					if weekNum ~= 6 then
						weekNum = weekNum + 1
					elseif weekNum == 6 then
						weekNum = 1
					end
					
				end
			elseif input:pressed("confirm") then
				audio.playSound(confirmSound)
				if menuNumberState == 2 then
					menu:musicStop()
					songNum = 1
			
					status.setLoading(true)
			
					graphics.fadeOut(
						0.5,
						function()
							songAppend = difficultyStrs[songDifficulty]
			
							storyMode = true
			
							Gamestate.switch(weekData[weekNum], songNum, songAppend)
			
							status.setLoading(false)
						end
					)
				elseif menuNumberState ~= 2 then
					function confirmFunc()
						menu:musicStop()
						songNum = 1
			
						status.setLoading(true)
			
						graphics.fadeOut(
							0.5,
							function()
								songAppend = difficultyStrs[songDifficulty]
			
								storyMode = true
			
								Gamestate.switch(weekData[weekNum], songNum, songAppend)
			
								status.setLoading(false)
							end
						)
					end
					menuNumberState = 2
				end
			elseif input:pressed("back") then
				audio.playSound(selectSound)
				if menuNumberState ~= 2 then
					Gamestate.switch(menuSelect)
				elseif menuNumberState == 2 then 
					menuNumberState = 1
				end
			end

			moni_story:update(dt)
			sayo_story:update(dt)
			difficultyAnim:update(dt)
			nat_story:update(dt)
			yuri_story:update(dt)

			if weekNum == 1 then
				cursor.x, cursor.y = moni_story.x - 18, moni_story.y - 6
			elseif weekNum == 2 then
				cursor.x, cursor.y = sayo_story.x + 18, sayo_story.y - 6
			elseif weekNum == 3 then
				cursor.x, cursor.y = nat_story.x + 50, nat_story.y - 6
			elseif weekNum == 4 then
				cursor.x, cursor.y = yuri_story.x - 18, yuri_story.y + 23
			elseif weekNum == 5 then
				cursor.x, cursor.y = monk_story.x + 17, monk_story.y + 23
			elseif weekNum == 6 then
				cursor.x, cursor.y = protag_story.x + 53, protag_story.y + 23
			end

		end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			
			pinkDots:draw()
			sideMenu:draw()
			logo:draw()
			tracks:draw()
			moni_story:draw()
			sayo_story:draw()
			nat_story:draw()
			yuri_story:draw()
			monk_story:draw()
			protag_story:draw()

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)


				graphics.setColor(0, 0, 0)
				if weekNum == 1 then
					love.graphics.printf("High School Conflict\nBara No Yume\nYour Demise", -1125, 140, 853, "center", nil, 1.5, 1.5)
				elseif weekNum == 2 then
					love.graphics.printf("Rain Clouds\nMy Confession", -1125, 140, 853, "center", nil, 1.5, 1.5)
				elseif weekNum == 3 then
					love.graphics.printf("My Sweets\nBaka", -1125, 140, 853, "center", nil, 1.5, 1.5)
				elseif weekNum == 4 then
					love.graphics.printf("Deep Breaths\nObsession", -1125, 140, 853, "center", nil, 1.5, 1.5)
				elseif weekNum == 5 then
					love.graphics.printf("Reconciliation", -1125, 140, 853, "center", nil, 1.5, 1.5)
				elseif weekNum == 6 then
					love.graphics.printf("Crucify\nBeethoven\nIt's Complicated\nGlitcher", -1125, 140, 853, "center", nil, 1.5, 1.5)
				end
				graphics.setColor(1, 1, 1)

				if menuNumberState == 2 then
					difficultyAnim:draw()
				end
				
				cursor:draw()

				--drawFunc()
			love.graphics.pop()
		love.graphics.pop()
	end,

	leave = function(self)
		--music:stop()

		Timer.clear()
	end
}
