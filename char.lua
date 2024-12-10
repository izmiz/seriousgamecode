-- // Services
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')
local Workspace = game:GetService('Workspace')

-- //
local RemoteEvents = ReplicatedStorage:WaitForChild('Remotes')
local RemoteEvent = RemoteEvents:WaitForChild('RemoteEvent')

-- //
local Templates = ReplicatedStorage:WaitForChild('Templates')
local CardTemplate = Templates:WaitForChild('Card')

-- //
local Player = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Calculate the card's position and orientation
local function calculateCardCFrame(card, distance)
	-- Position in front of the camera
	local cameraCFrame = Camera.CFrame
	local position = cameraCFrame.Position + (cameraCFrame.LookVector * distance)

	-- Use lookAt for dynamic facing
	local lookAt = CFrame.lookAt(position, cameraCFrame.Position)

	-- Z-axis rotation correction for the card's orientation
	local rotationCorrection = CFrame.Angles(0, math.rad(90), math.rad(90))

	-- Combine position and rotation
	return lookAt * rotationCorrection
end

-- Display card dynamically in front of the player's camera
local function displayCardToCamera(card)
	local distance = 0.5 -- Distance from the camera

	-- Set the card's initial position and orientation
	card.CFrame = calculateCardCFrame(card, distance)

	-- Function to update the card's position dynamically
	local function updateCardPosition()
		card.CFrame = calculateCardCFrame(card, distance)
	end

	-- Connect to RenderStepped for real-time updates
	local updateConnection
	updateConnection = RunService.RenderStepped:Connect(function()
		if card.Parent then
			updateCardPosition()
		else
			if updateConnection then
				updateConnection:Disconnect()
			end
		end
	end)

	-- Wait for 5 seconds and then tween the card away
	task.wait(5)

	-- Tween to move the card away
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local moveAway = TweenService:Create(card, tweenInfo, {CFrame = card.CFrame * CFrame.new(0, 0, -10)})
	moveAway:Play()

	-- Destroy the card after the tween completes
	moveAway.Completed:Connect(function()
		card:Destroy()
	end)
end

-- Handle remote event to display the card
RemoteEvent.OnClientEvent:Connect(function(cardName)
	-- Find the card instance in Workspace
	local card = Workspace:FindFirstChild(cardName)
	if card then
		displayCardToCamera(card)
	else
		warn("Card not found: " .. tostring(cardName))
	end
end)
