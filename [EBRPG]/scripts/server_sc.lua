----цвета----
local color_mes = {
	color_tips = {168,228,160},--бабушкины яблоки
	yellow = {255,255,0},--желтый
	red = {255,0,0},--красный
	red_try = {200,0,0},--красный
	blue = {0,150,255},--синий
	white = {255,255,255},--белый
	green = {0,255,0},--зеленый
	green_try = {0,200,0},--зеленый
	turquoise = {0,255,255},--бирюзовый
	orange = {255,100,0},--оранжевый
	orange_do = {255,150,0},--оранжевый do
	pink = {255,100,255},--розовый
	lyme = {130,255,0},--лайм админский цвет
	svetlo_zolotoy = {255,255,130},--светло-золотой
	crimson = {220,20,60},--малиновый
	purple = {175,0,255},--фиолетовый
	gray = {150,150,150},--серый
	green_rc = {115,180,97},--темно зеленый
}

function isPointInCircle3D(x, y, z, x1, y1, z1, radius)
	if getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) <= radius then
		return true
	else
		return false
	end
end

function sendMessage(playerid, text, color)
	local time = getRealTime()
	local hour = time["hour"]
	local minute = time["minute"]
	local second = time["second"]

	if time["hour"] < 10 then
		hour = "0"..hour
	end

	if time["minute"] < 10 then
		minute = "0"..minute
	end

	if time["second"] < 10 then
		second = "0"..second
	end

	outputChatBox("["..hour..":"..minute..":"..second.."] "..text, playerid, color[1], color[2], color[3])
end

function me_chat(playerid, text)
	local x,y,z = getElementPosition(playerid)

	for k,player in pairs(getElementsByType("player")) do
		local x1,y1,z1 = getElementPosition(player)

		if isPointInCircle3D(x,y,z, x1,y1,z1, 10 ) then
			sendMessage(player, text, color_mes.pink)
		end
	end
end

addEvent("event_server_attach", true)
addEventHandler ( "event_server_attach", root,
function ( playerid, state )
	local playername = getPlayerName ( playerid )
	local vehicleid = getPedOccupiedVehicle(playerid)

	if vehicleid then
		local x,y,z = getElementPosition(vehicleid)
		if getElementModel(vehicleid) == 548 then
			for k,vehicle in pairs(getElementsByType("vehicle")) do
				local x1,y1,z1 = getElementPosition(vehicle)
				if isPointInCircle3D(x1,y1,z1, x,y,z, 10) then

					if not isElementAttached ( vehicle ) and state == "true" then
						local car_attach = attachElements ( vehicle, vehicleid, 0, 0, -4 )
						if car_attach then
							sendMessage(playerid, "т/с прикреплен", color_mes.yellow)
						end
					elseif isElementAttached ( vehicle ) and state == "false" then
						detachElements  ( vehicle, vehicleid )
						sendMessage(playerid, "т/с откреплен", color_mes.yellow)
					end

					return
				end
			end
		end
	end
end)

addEvent("event_server_car_door", true)
addEventHandler("event_server_car_door", root,
function ( playerid, state )
	local x,y,z = getElementPosition(playerid)
	local playername = getPlayerName ( playerid )

	for k,vehicle in pairs(getElementsByType("vehicle")) do
		local x1,y1,z1 = getElementPosition(vehicle)
		local plate = getVehiclePlateText ( vehicle )

		if isPointInCircle3D(x,y,z, x1,y1,z1, 10) then
			if state == "true" then
				setVehicleLocked ( vehicle, true )
				me_chat(playerid, playername.." закрыл(а) двери")
			else
				setVehicleLocked ( vehicle, false )
				me_chat(playerid, playername.." открыл(а) двери")
			end
			return
		end
	end
end)

addEvent("event_server_car_light", true)
addEventHandler("event_server_car_light", root,
function ( playerid, state )
	local x,y,z = getElementPosition(playerid)
	local playername = getPlayerName ( playerid )

	for k,vehicle in pairs(getElementsByType("vehicle")) do
		local x1,y1,z1 = getElementPosition(vehicle)
		local plate = getVehiclePlateText ( vehicle )

		if isPointInCircle3D(x,y,z, x1,y1,z1, 10) then
			if state == "true" then
				setVehicleOverrideLights ( vehicle, 2 )
			else
				setVehicleOverrideLights ( vehicle, 1 )
			end
			return
		end
	end
end)

addEvent("event_server_car_engine", true)
addEventHandler ( "event_server_car_engine", root,
function ( playerid, state )
	local playername = getPlayerName ( playerid )
	local x,y,z = getElementPosition(playerid)
	
	for k,vehicleid in pairs(getElementsByType("vehicle")) do
		local x1,y1,z1 = getElementPosition(vehicleid)
		local plate = getVehiclePlateText ( vehicleid )

		if isPointInCircle3D(x,y,z, x1,y1,z1, 10) then
			if state == "true" then
				setVehicleEngineState(vehicleid, true)
				me_chat(playerid, playername.." завел(а) двигатель")
			else
				setVehicleEngineState(vehicleid, false)
				me_chat(playerid, playername.." заглушил(а) двигатель")
			end
			return
		end
	end
end)

addEvent("event_server_anim_player", true)
addEventHandler("event_server_anim_player", root,
function ( playerid, state )
	local x,y,z = getElementPosition(playerid)
	local playername = getPlayerName ( playerid )
	local spl = split(state, ",")

	if spl[1] ~= "nil" then
		if spl[3] == "true" then
			setPedAnimation(playerid, tostring(spl[1]), tostring(spl[2]), -1, true, false, false, false)
		elseif spl[3] == "one" then
			setPedAnimation(playerid, tostring(spl[1]), tostring(spl[2]), -1, false, false, false, false)
		elseif spl[3] == "walk" then
			setPedAnimation(playerid, tostring(spl[1]), tostring(spl[2]), -1, true, true, false, false)
		elseif spl[3] == "false" then
			setPedAnimation(playerid, tostring(spl[1]), tostring(spl[2]), -1, false, false, false, true)
		end
	else
		setPedAnimation(playerid, nil, nil)
	end
end)