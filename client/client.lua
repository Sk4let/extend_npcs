Citizen.CreateThread(function()
    for k, v in pairs(Config.Npcs) do
      local model = requestNpcModel(v.Model, 100)
      local NPC = CreatePed(4, model, v.Position.x, v.Position.y, v.Position.z, v.Heading, v.NetWork, false)
      FreezeEntityPosition(NPC, v.Freeze)
      SetEntityInvincible(NPC, true)
      SetBlockingOfNonTemporaryEvents(NPC, v.Event)
      TaskStartScenarioInPlace(NPC, v.scenario, true, true)
  end
end)


function requestNpcModel(model, timeout)
	if not tonumber(model) then model = joaat(model) end
	if HasModelLoaded(model) then return model end

	if not IsModelValid(model) then
		return error(("Attempted to load invalid model (%s)"):format(model))
	end

	return request(model)
end

local function request(modelName)

	RequestModel(modelName)

	if coroutine.running() then
			timeout = 500
		for i = 1, timeout do
			Wait(0)
			if HasModelLoaded(modelName) then
				return modelName
			end
		end

	end

	return modelName
end