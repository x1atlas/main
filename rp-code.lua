for i,v in next, require(game.ReplicatedStorage.Modules.MetaData.Code_Info) do
    game.Players.LocalPlayer.PlayerGui.Button.Setting_Frame["{}"].Event:FireServer(i)
end
