Citizen.CreateThread(function()
  while true do
    local playerId = PlayerId();
    local playerPed = PlayerPedId();

    Citizen.Wait(500);

    if IsPedFatallyInjured(playerPed) then
      local killerPed = GetPedSourceOfDeath(playerPed);
      local killerId = NetworkGetPlayerIndexFromPed(killerPed);

      if killerId ~= -1 then
        TriggerServerEvent(GetCurrentResourceName() .. ':onPlayerDeath', killerId);
      end

      while IsPedFatallyInjured(playerPed) do
        Citizen.Wait(0);
      end
    end
  end
end);