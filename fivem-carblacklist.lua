-- CONFIG --

-- Blacklisted vehicle models
carblacklist = {
	"RHINO",
	"APC",
	"TITAN",
	"AVENGER",
	"DIRIGEABLE",
	"JET",
	"BOMBUSHKA",
	"VIGILENTE",
	"HYDRA"
	// możesz tutaj dodać pojazdy które mają być zablokowane na serwerze
	// Here you can add to be on the server

}

-- CODE --

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))

			x, y, z = table.unpack(GetEntityCoords(playerPed, true))
			for _, blacklistedCar in pairs(carblacklist) do
				checkCar(GetClosestVehicle(x, y, z, 100.0, GetHashKey(blacklistedCar), 70))
			end
		end
	end
end)

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			_DeleteEntity(car)
			sendForbiddenMessage("This vehicle is blacklisted!")
		end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end
