-- // Services
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- // Remote Events
local RemoteEvents = ReplicatedStorage:WaitForChild('Remotes')
local RemoteEvent = RemoteEvents:WaitForChild('RemoteEvent')

-- // Modules
local Modules = ReplicatedStorage:WaitForChild('Modules')
local Decks = require(Modules.Client.Info.Decks)

-- // Workspace
local CardsFolder = workspace.Cards
local Chair = workspace.Chair
local seat = Chair.Seat.Seat
local Table = workspace:WaitForChild("Table")
local TableTop = Table:WaitForChild("Top")
local Templates = ReplicatedStorage:WaitForChild("Templates")
local CardTemplate = Templates:WaitForChild("Card")

-- Variables
--local PrimaryDeck = Decks.Primary
local PsychedelicDeck = Decks.PsychedelicDeck
local ConditionsDeck = Decks.ConditionDeck
local activeGame = false -- Track if a game is active
local currentPlayer = nil -- Store the current player
local activeCards = {} -- Store active cloned cards for cleanup

local picked, pickedYes = nil, false

-- Shuffle Function
local function shuffleDeck(deck)
	-- Create a copy of the deck to avoid modifying the original
	local shuffledDeck = table.create(#deck)
	for i, card in ipairs(deck) do
		shuffledDeck[i] = card
	end

	-- Perform the Fisher-Yates shuffle
	for i = #shuffledDeck, 2, -1 do
		local j = math.random(1, i)
		shuffledDeck[i], shuffledDeck[j] = shuffledDeck[j], shuffledDeck[i]
	end

	return shuffledDeck
end

-- Start Game
local function startGame(player)
	activeGame = true
	currentPlayer = player
	print("Starting game for " .. player.Name .. "!")

	-- Start with Psychedelics
	print("Shuffling decks...")
	local myDeck = shuffleDeck(PsychedelicDeck)
	local gameDeck = shuffleDeck(ConditionsDeck)
	print("Decks shuffled successfully.")

	while activeGame and #myDeck > 0 do
		print("Drawing cards...")
	
		print('There is '..#myDeck..' left in my deck')
		
		-- Draw random cards from each deck
		local myCardIndex = math.random(1, #myDeck)
		local gameCardIndex = math.random(1, #gameDeck)
		local myCard = myDeck[myCardIndex]
		local gameCard = gameDeck[gameCardIndex]

		print("Player card: " .. myCard.Name .. ", Game card: " .. gameCard.Name)

		-- Show the player's card
		print("Sending player's card to client: " .. myCard.Name)
		RemoteEvent:FireClient(player, 'yourCard', myCard)
		task.wait(3)

		-- Show the game's condition card
		print("Sending game's card to client: " .. gameCard.Name)
		RemoteEvent:FireClient(player, 'gameCard', gameCard)
		task.wait(3)

		-- Prompt the player to decide if it's a match
		print("Prompting player to decide if it's a match...")
		RemoteEvent:FireClient(player, 'pickIfMatch')

		repeat
			task.wait(1)
		until picked

		print("Player made a choice: " .. (pickedYes and "Yes" or "No"))

		-- Process the player's choice
		local wonRound = false
		if picked then
			if pickedYes then
				if table.find(myCard.Conditions, gameCard.Name) then
					wonRound = true
					print("Correct match! Card matched successfully.")
					-- Inform the player about the correct match
					RemoteEvent:FireClient(player, 'correctMatch')
					task.wait(5)
				else
					print("Incorrect match. Cards do not match.")
					-- Inform the player about the incorrect match
					RemoteEvent:FireClient(player, 'incorrectMatch')
					task.wait(3)
				end
			else
				print("Player chose 'No match.'")
			end
		end

		-- Update the decks if the round was won
		if wonRound then
			print("Removing matched card from player's deck: " .. myCard.Name)
			table.remove(myDeck, myCardIndex)
		else
			print("No changes to the player's deck.")
		end
		
		-- Cleanup
		picked, pickedYes = false, false
		RemoteEvent:FireClient(player, 'clearUI')
		wonRound = false
	end

	-- End the game
	print("Game over for " .. player.Name)
	activeGame = false
	currentPlayer = nil
end

-- Stop Game
local function stopGame()
	if currentPlayer then
		print("Ending game for " .. currentPlayer.Name)
	end
	activeGame = false
	currentPlayer = nil
end

-- Seat Occupancy Detection
local currentSeatOccupant = nil
seat:GetPropertyChangedSignal("Occupant"):Connect(function()
	if seat.Occupant then
		-- Player has sat down
		local character = seat.Occupant.Parent
		local player = Players:GetPlayerFromCharacter(character)

		if player and not activeGame then
			currentSeatOccupant = player
			print(player.Name .. " has sat down!")
			startGame(player)
		end
	else
		if currentSeatOccupant and Players:FindFirstChild(currentSeatOccupant.Name) then
			RemoteEvent:FireClient(currentSeatOccupant, 'gameEnded')
		end
		
		-- Player has gotten up
		print("The seat is now empty!")
		currentSeatOccupant = nil
		stopGame()
	end
end)

RemoteEvent.OnServerEvent:Connect(function(Player, Args)
	if Args[1] == 'Guess' then
		if typeof(Args[2]) == 'boolean' then 
			picked, pickedYes = true, Args[2]
		end
	end
end)
