local Weather = {}

local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local CloudsModule = workspace.Terrain
local clouds = CloudsModule:FindFirstChild("Clouds")

local WeatherActive = false
local WeatherEnabled = false

function GetRandomPercentage()
	return math.random(0, 100)
end

function GetWeatherProbability()
	if WeatherEnabled then
		return math.random(0, 100)
	else
		warn("Не удалось получить погоду, так как WeatherEnabled не равно true")
		return 101 -- Возвращаем значение вне диапазона, чтобы не начать дождь
	end
end

function GetRainDuration()
	return math.random(300, 1200)
end

if not clouds then
	error("Облака не найдены в CloudsModule")
end

function Weather.Start(rainEffect, rain, thunder)
	clouds.Cover = 0.5
	clouds.Color = Color3.fromRGB(255, 255, 255)
	while true do
		local randomPercentage = GetRandomPercentage()

		if not WeatherActive then
			if randomPercentage <= 20 then
				print("Акт 1 пройден")
				WeatherEnabled = true
				local weatherProbability = GetWeatherProbability()
				wait(20)

				if weatherProbability <= 50 then
					print("Акт 2 включен")
					WeatherActive = true
					rain:Play()
					thunder:Play()
					rainEffect.Parent = workspace

					-- Плавное изменение свойств облаков с помощью TweenService
					local coverTween = TweenService:Create(clouds, TweenInfo.new(5), {Cover = 0.85})
					local colorTween = TweenService:Create(clouds, TweenInfo.new(5), {Color = Color3.fromRGB(49, 49, 49)})

					coverTween:Play()
					colorTween:Play()

					wait(GetRainDuration()) -- Ждем случайное время окончания дождя

					local resetCoverTween = TweenService:Create(clouds, TweenInfo.new(5), {Cover = 0.5})
					local resetColorTween = TweenService:Create(clouds, TweenInfo.new(5), {Color = Color3.fromRGB(255, 255, 255)})

					resetCoverTween:Play()
					resetColorTween:Play()

					WeatherActive = false
					WeatherEnabled = false
					thunder:Stop()
					rain:Stop()
					rainEffect.Parent = RS
					print("Дождь закончился")
				else
					print("Дождь прошел")
					WeatherEnabled = false
				end
			else
				print("Случайный процент не попал в диапазон для создание дождя: " .. randomPercentage)
			end 
		else
			print("Дождь уже идет!")
		end

		wait(math.random(60, 120)) -- Ждем случайное время перед следующим обновлением
	end
end

return Weather
