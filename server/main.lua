local latestKills = {};

AddEventHandler(GetCurrentResourceName() .. ':onPlayerDeath', function(data)
  if not data.killerServerId then
    return;
  end

  if not latestKills[data.killerServerId] then
    latestKills[data.killerServerId] = {};
  end

  table.insert(latestKills[data.killerServerId], os.time());

  local lastKills = {};

  for i = 1, #latestKills[data.killerServerId] do
    if latestKills[data.killerServerId][i] < os.time() - Config.killsInterval then
      table.insert(lastKills, latestKills[data.killerServerId][i]);
    end
  end

  if #lastKills > Config.killsLimit then
    return DropPlayer(data.killerServerId, string.format('You killed %s players in %s seconds', #lastKills, Config.killsInterval));
  end
end);