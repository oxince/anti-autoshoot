local latestKills = {};

AddEventHandler(GetCurrentResourceName() .. ':onPlayerDeath', function(killerServerId)
  if not killerServerId then
    return;
  end
  
  if not latestKills[killerServerId] then
    latestKills[killerServerId] = {};
  end

  table.insert(latestKills[killerServerId], os.time());

  local lastKills = {};

  for i = 1, #latestKills[killerServerId] do
    if latestKills[killerServerId][i] < os.time() - Config.killsInterval then
      table.insert(lastKills, latestKills[killerServerId][i]);
    end
  end

  if #lastKills > Config.killsLimit then
    return DropPlayer(killerServerId, string.format('You killed %s players in %s seconds', #lastKills, Config.killsInterval));
  end
end);