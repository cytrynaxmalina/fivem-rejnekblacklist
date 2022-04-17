-- CONFIG --

-- Blacklisted weapons
weaponblacklist = {
	"WEAPON_MINIGUN",
	"WEAPON_RAILGUN",
	"WEAPON_RAYMINIGUN",
	"WEAPON_RAYCARBINE",
	"WEAPON_STICKYBOMB",
	"WEAPON_GRENADE",
	"WEAPON_RPG",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_SNIPERRIFLE"


}

-- W ogóle nie zezwalaj na żadną broń (overrides the blacklist)
disableallweapons = false

-- CODE --

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)

			if disableallweapons then
				RemoveAllPedWeapons(playerPed, true)
			else
				if isWeaponBlacklisted(weapon) then
					RemoveWeaponFromPed(playerPed, weapon)
					sendForbiddenMessage("Broń jest na blackliscie!")
				end
			end
		end
	end
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) then
			return true
		end
	end

	return false
end
