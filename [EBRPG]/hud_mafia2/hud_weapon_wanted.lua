local screenWidth, screenHeight = guiGetScreenSize ( )
local wanted_img = {
	[1] = {479,131, 33,44},
	[2] = {54,212, 45,36},
	[3] = {351,425, 54,38},
	[4] = {0,265, 79,38},
	[5] = {0,265, 79,38},
	[6] = {0,265, 79,38},
}

addEventHandler( "onClientResourceStart", resourceRoot,
function ( startedRes )
	for k,v in pairs(getElementData(resourceRoot, "custom_weapon")) do
		local txd = engineLoadTXD ( "weapon/"..v[1]..".txd" )
		local dff = engineLoadDFF ( "weapon/"..v[1]..".dff" )
		engineImportTXD (txd, v[2])
		engineReplaceModel ( dff, v[2] )
	end

	setPlayerHudComponentVisible("ammo", false)
	setPlayerHudComponentVisible("weapon", false)
	setPlayerHudComponentVisible("wanted", false)
end)

function dxdrawtext(text, x, y, width, height, color, scale, font)
	dxDrawText ( text, x+1, y+1, width, height, tocolor ( 0, 0, 0, 255 ), scale, font )

	dxDrawText ( text, x, y, width, height, color, scale, font )
end

function createText ()
	local weaponpl = getPedWeapon(localPlayer)
	if weaponpl and getElementData(resourceRoot, "custom_weapon")[weaponpl] then
		local v = getElementData(resourceRoot, "custom_weapon")[weaponpl]
		dxDrawImageSection(50, screenHeight-50-v[6], v[5], v[6], v[3], v[4], v[5], v[6], 'hud/hud2.png')
		if weaponpl ~= 5 and weaponpl ~= 4 and weaponpl ~= 1 and weaponpl ~= 3 and weaponpl ~= 6 and weaponpl ~= 15 then
			dxdrawtext ( getPedAmmoInClip(localPlayer).." | "..(getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer)), 50+v[5], screenHeight-50-15, 0.0, 0.0, tocolor ( 255, 255, 255, 255 ), 1, "default-bold" )
		end
	end

	local wanted = getPlayerWantedLevel ( )
	if wanted ~= 0 then
		local v = wanted_img[wanted]
		dxDrawImageSection(screenWidth-(146/2)-(v[3]/2), screenHeight-161-v[4], v[3], v[4], v[1], v[2], v[3], v[4], 'hud/hud2.png')
	end
end
addEventHandler ( "onClientRender", root, createText )