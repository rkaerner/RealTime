local metadata = {
"## Interface:FS15 1.1.0.0 RC12",
"## Title: RealTime",
"## Notes: Uhrzeit in Game",
"## Author: Marhu",
"## Version: 1.2.10",
"## Date: 01.11.2014",
"## Web: http://marhu.net",
"## Notes: Improvement by Bauer Hannsen"
}

RealTime = {};

function RealTime:loadMap(name)
	self.h = 0.015
end;

function RealTime:deleteMap()
end;

function RealTime:keyEvent(unicode, sym, modifier, isDown)
end;

function RealTime:mouseEvent(posX, posY, isDown, isUp, button)
end;

function RealTime:update(dt)
end;

function RealTime:draw()
	if g_currentMission.renderTime then
		setTextColor(0,0,0,1);
		setTextAlignment(RenderText.ALIGN_RIGHT);
		local WhatDay = string.format("%f", g_currentMission.environment.currentDay);
		local WeekDay = math.mod(WhatDay, 7);
		if WeekDay == 0 then
			setTextColor(1, 0, 0, 1);
		end;
		renderText(g_currentMission.weatherTimeBackgroundOverlay.x + g_currentMission.weatherTimeBackgroundWidth - g_currentMission.timeOffsetRight, g_currentMission.weatherTimeBackgroundOverlay.y + (self.h*3), self.h, g_i18n:getText("HUD_day") .. ": " .. g_currentMission.environment.currentDay .. " (" .. g_i18n:getText(tostring(WeekDay)) .. ")");
		setTextColor(0, 0, 0, 1);
		setTextAlignment(RenderText.ALIGN_RIGHT);
		renderText(g_currentMission.weatherTimeBackgroundOverlay.x + g_currentMission.weatherTimeBackgroundWidth - g_currentMission.timeOffsetRight, g_currentMission.weatherTimeBackgroundOverlay.y + (self.h/4), self.h, tostring(getDate("%H:%M:%S")).." ");
		setTextColor(1,1,1,1);
		setTextAlignment(RenderText.ALIGN_LEFT);
	end;
end;

addModEventListener(RealTime);