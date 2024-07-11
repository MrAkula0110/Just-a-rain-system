local ModuleWeather = require(script.Parent)

local RS = game.ReplicatedStorage
local SS = game.SoundService

local rainEffect = RS.RainEffect
local rain = SS.AMB.WS.RainSoundEffect
local thunder = SS.AMB.WS.Thunders

ModuleWeather.Start(rainEffect,rain,thunder)
