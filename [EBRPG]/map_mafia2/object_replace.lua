local eb_textures = {}
local weather = "summer" --summer,winter,autumn

addEventHandler( "onClientResourceStart", resourceRoot,
function ( startedRes )
	for k,v in ipairs(getElementData(root, "object")) do
		if weather == "summer" and not eb_textures[v[4]] and fileExists(":map_mafia2/textures/"..v[4].."_summer.txd") then
			eb_textures[v[4]] = engineLoadTXD ( ":map_mafia2/textures/"..v[4].."_summer.txd" )
			print(v[4].." load")
		elseif weather == "winter" and not eb_textures[v[4]] and fileExists(":map_mafia2/textures/"..v[4].."_winter.txd") then
			eb_textures[v[4]] = engineLoadTXD ( ":map_mafia2/textures/"..v[4].."_winter.txd" )
			print(v[4].." load")
		elseif weather == "autumn" and not eb_textures[v[4]] then
			--soon
		end

		if not eb_textures[v[4]] and fileExists(":map_mafia2/textures/"..v[4]..".txd") then
			eb_textures[v[4]] = engineLoadTXD ( ":map_mafia2/textures/"..v[4]..".txd" )
			print(v[4].." load")
		end

		if fileExists(":map_mafia2/"..v[4].."/"..v[1]..".dff") and fileExists(":map_mafia2/"..v[4].."/"..v[1]..".col") then
			engineImportTXD (eb_textures[v[4]], v[3])
			local dff = engineLoadDFF ( ":map_mafia2/"..v[4].."/"..v[1]..".dff" )
			if v[7] then
				engineReplaceModel ( dff, v[3], true )
			else
				engineReplaceModel ( dff, v[3], false )
			end
			local col = engineLoadCOL ( ":map_mafia2/"..v[4].."/"..v[1]..".col" )
			engineReplaceCOL ( col, v[3] )
			engineSetModelLODDistance(v[3], 30000)
			engineSetModelPhysicalPropertiesGroup(v[3], 0)
			engineSetModelVisibleTime(v[3], 0, 24)
		end
	end
	setTimer(function()
		triggerServerEvent("event_spawnplayer", localPlayer)
	end, 1000, 1)
end)

--{''; {{ ;0 ;0 ;0};}; 0};
--{"05_88_01", {{-575.04130,1664.06500,-18.71200,90,0,0}}, 0}, dipton

--greenfield
--{"03_teren203", {{-1877.168 ,1046.32 ,12.10801 ,0 ,0 ,0}}, 0},--большая кол-ия
--{"03_teren201", {{-1877.168 ,1046.32 ,12.10801 ,0 ,0 ,0}}, 0},
--{"03_30", {{-1803.381 ,1051.32 ,8.489138 ,0 ,0 ,-90}}, 0},
--{"03_29", {{-2000.435 ,1110.572 ,22.66821 ,0 ,0 ,70}}, 0},--большая кол-ия и далеко от игрока