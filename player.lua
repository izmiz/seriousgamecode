-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- // Player and GUI
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Interface = PlayerGui:WaitForChild("Interface")
local Selection = Interface.Container.Selection
local CardUI = Interface.Container.Card
local CardContainer = CardUI.CardContainer
local Templates = Interface.Templates
local CardTemplate = Templates.CardTemplate

-- // Remotes
local RemoteEvents = ReplicatedStorage:WaitForChild("Remotes")
local RemoteEvent = RemoteEvents:WaitForChild("RemoteEvent")

-- // Camera and Sounds
local Camera = Workspace.CurrentCamera
local Sounds = ReplicatedStorage:WaitForChild("Sounds")
local SuccessSFX = Sounds:WaitForChild("Success")
local FailedSFX = Sounds:WaitForChild("Failed")

-- Variables
local gameCard, gameCardData = nil, nil
local myCard, myCardData = nil, nil

-- Handle Yes Button Click
Selection.Bar.Yes.MouseButton1Click:Connect(function()
	Selection.Visible = false
	RemoteEvent:FireServer({ "Guess", true })
end)

-- Handle No Button Click
Selection.Bar.No.MouseButton1Click:Connect(function()
	Selection.Visible = false
	RemoteEvent:FireServer({ "Guess", false })
end)

-- Update Card UI
local function updateCardUI(cardData, container)
	local newCard = CardTemplate:Clone()
	newCard.CardName.Text = cardData.Name
	newCard.Visible = true
	newCard.Parent = container
	return newCard
end

-- Remote Event Handling
RemoteEvent.OnClientEvent:Connect(function(action, arg1)
	if action == "yourCard" then
		myCard, myCardData = updateCardUI(arg1, CardContainer), arg1
		myCard.Type.Text = 'Psychedelic Card'
	elseif action == "gameCard" then
		gameCard, gameCardData = updateCardUI(arg1, CardContainer), arg1
		gameCard.Type.Text = 'Condition Card'
	elseif action == "pickIfMatch" then
		CardUI.Header.Visible = true
		Selection.Visible = true
	elseif action == "correctMatch" then
		SuccessSFX:Play()
		CardUI.Header.Header.Text = "Correct!"
		CardUI.Header.Header.TextColor3 = Color3.fromRGB(85, 255, 0)

		local function formatCardInfo(cardData)
			local cardInfo = ""
			for index, value in pairs(cardData.Data or {}) do
				cardInfo = cardInfo .. index .. ": " .. tostring(value) .. "\n"
			end
			return cardInfo
		end

		if gameCard then gameCard.CardName.Text = formatCardInfo(gameCardData) end
		if myCard then myCard.CardName.Text = formatCardInfo(myCardData) end
	elseif action == "incorrectMatch" then
		FailedSFX:Play()
		CardUI.Header.Header.Text = "Sorry, that is incorrect!"
		CardUI.Header.Header.TextColor3 = Color3.fromRGB(255, 0, 0)
	elseif action == "clearUI" then
		for _, card in pairs(CardContainer:GetChildren()) do
			if card:IsA("Frame") then
				card:Destroy()
			end
		end
		CardUI.Header.Header.Text = "Does the psychedelic help the condition?"
		CardUI.Header.Header.TextColor3 = Color3.fromRGB(255, 255, 255)
		CardUI.Header.Visible = false
		Selection.Visible = false
	end
end)
