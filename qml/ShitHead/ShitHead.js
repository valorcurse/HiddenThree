var cardsInfo = [
            {number: "2", type: "clover", source: "textures/cards/c_02.png"},
            {number: "3", type: "clover", source: "textures/cards/c_03.png"},
            {number: "4", type: "clover", source: "textures/cards/c_04.png"},
            {number: "5", type: "clover", source: "textures/cards/c_05.png"},
            {number: "6", type: "clover", source: "textures/cards/c_06.png"},
            {number: "7", type: "clover", source: "textures/cards/c_07.png"},
            {number: "8", type: "clover", source: "textures/cards/c_08.png"},
            {number: "9", type: "clover", source: "textures/cards/c_09.png"},
            {number: "10", type: "clover", source: "textures/cards/c_10.png"},
            {number: "j", type: "clover", source: "textures/cards/c_j.png"},
            {number: "q", type: "clover", source: "textures/cards/c_q.png"},
            {number: "k", type: "clover", source: "textures/cards/c_k.png"},
            {number: "a", type: "clover", source: "textures/cards/c_a.png"},
            
            {number: "2", type: "diamonds", source: "textures/cards/d_02.png"},
            {number: "3", type: "diamonds", source: "textures/cards/d_03.png"},
            {number: "4", type: "diamonds", source: "textures/cards/d_04.png"},
            {number: "5", type: "diamonds", source: "textures/cards/d_05.png"},
            {number: "6", type: "diamonds", source: "textures/cards/d_06.png"},
            {number: "7", type: "diamonds", source: "textures/cards/d_07.png"},
            {number: "8", type: "diamonds", source: "textures/cards/d_08.png"},
            {number: "9", type: "diamonds", source: "textures/cards/d_09.png"},
            {number: "10", type: "diamonds", source: "textures/cards/d_10.png"},
            {number: "j", type: "diamonds", source: "textures/cards/d_j.png"},
            {number: "q", type: "diamonds", source: "textures/cards/d_q.png"},
            {number: "k", type: "diamonds", source: "textures/cards/d_k.png"},
            {number: "a", type: "diamonds", source: "textures/cards/d_a.png"},
            
            {number: "2", type: "spades", source: "textures/cards/s_02.png"},
            {number: "3", type: "spades", source: "textures/cards/s_03.png"},
            {number: "4", type: "spades", source: "textures/cards/s_04.png"},
            {number: "5", type: "spades", source: "textures/cards/s_05.png"},
            {number: "6", type: "spades", source: "textures/cards/s_06.png"},
            {number: "7", type: "spades", source: "textures/cards/s_07.png"},
            {number: "8", type: "spades", source: "textures/cards/s_08.png"},
            {number: "9", type: "spades", source: "textures/cards/s_09.png"},
            {number: "10", type: "spades", source: "textures/cards/s_10.png"},
            {number: "j", type: "spades", source: "textures/cards/s_j.png"},
            {number: "q", type: "spades", source: "textures/cards/s_q.png"},
            {number: "k", type: "spades", source: "textures/cards/s_k.png"},
            {number: "a", type: "spades", source: "textures/cards/s_a.png"},
            
            {number: "2", type: "hearts", source: "textures/cards/h_02.png"},
            {number: "3", type: "hearts", source: "textures/cards/h_03.png"},
            {number: "4", type: "hearts", source: "textures/cards/h_04.png"},
            {number: "5", type: "hearts", source: "textures/cards/h_05.png"},
            {number: "6", type: "hearts", source: "textures/cards/h_06.png"},
            {number: "7", type: "hearts", source: "textures/cards/h_07.png"},
            {number: "8", type: "hearts", source: "textures/cards/h_08.png"},
            {number: "9", type: "hearts", source: "textures/cards/h_09.png"},
            {number: "10", type: "hearts", source: "textures/cards/h_10.png"},
            {number: "j", type: "hearts", source: "textures/cards/h_j.png"},
            {number: "q", type: "hearts", source: "textures/cards/h_q.png"},
            {number: "k", type: "hearts", source: "textures/cards/h_k.png"},
            {number: "a", type: "hearts", source: "textures/cards/h_a.png"}
        ];

var cardsRules = {
    "2"	: 	[],
    "3"	: 	[],
    "4"	: 	[],
    "5"	: 	["4"],
    "6"	: 	["4", "5"],
    "7"	: 	["8", "9", "j", "q", "k", "a"],
    "8"	: 	["4", "5", "6", "7"],
    "9"	: 	["4", "5", "6", "7", "8"],
    "10": 	[],
    "j"	: 	["4", "5", "6", "7", "8", "9"],
    "q"	: 	["4", "5", "6", "7", "8", "9", "j"],
    "k"	: 	["4", "5", "6", "7", "8", "9", "j", "q"],
    "a"	: 	["4", "5", "6", "7", "8", "9", "j", "q", "k"]
};

var player1;
var player2;

function startNewGame(p1Area, p2Area) {
    
    
    //  Initialize Board
    createStackOfCards();
    
    // Shuffle cards
    shuffle(stackOfCards);
    
    // Create players
    player1 = {
        cardsHand: [],
        cardsHidden: [],
        playerArea: player1Area,
        handState: "Player1Hand",
        hiddenTopState: "Player1HiddenTop",
        hiddenBottomState: "Player1HiddenBottom"
    };
    game.players.push(player1);
    game.playerTurn = game.players.indexOf(player1);
    
    player2 = {
        cardsHand: [],
        cardsHidden: [],
        playerArea: player2Area,
        handState: "Player2Hand",
        hiddenTopState: "Player2HiddenTop",
        hiddenBottomState: "Player2HiddenBottom"
    };
    game.players.push(player2);
    
    dealHiddenCards(player1);
    dealHiddenCards(player2);
    
    // Deals cards to players
    dealCards(player1, 3);
    dealCards(player2, 3);
}

function dealHiddenCards(player) {
    for (var i = 0; i < 6; i++) {
        
        var card = stackOfCards.pop();
        
        // Deal bottom cards
        if (i < 3) {
            card.state = player.hiddenBottomState;
        }
        // Deal top cards
        else {
            card.state = player.hiddenTopState;
        }
        
        card.player = player;
        
        player.cardsHidden.push(card)
    }
}

function dealCards(player, numberOfCards) {
    if (stackOfCards.length > 0)
        for (var i = 0; i < numberOfCards; i++) {

            var card = stackOfCards.pop();
            card.state = player.handState;
            card.player = player;

            player.cardsHand.push(card);
        }
}

function removeIndex(array, index) {
    if (index !== -1)
        array.splice(index, 1);
}

function createStackOfCards() {
    var component = Qt.createComponent("Card.qml");
    
    if (component.status === Component.Ready) {
        
        for (var i = 0; i < cardsInfo.length; i++) {
            var card = component.createObject(background, {cardObject: cardsInfo[i]});
            
            if (card === null) {
                console.log("error creating block");
                console.log(component.errorString());
                
                return false;
            }

            
            stackOfCards.push(card);
            card.state = "Stack";
//            console.log(stackOfCards);
        }
    } else {
        console.log("error loading block component");
        console.log(component.errorString());
        
        return false;
    }
    
    return true;
}

function playCard(card) {
    
    if (card.playable) {
        
        // Remove card from player's hand
        var player = card.player;
        var cardIndex = player.cardsHand.indexOf(card);
        removeIndex(player.cardsHand, cardIndex);
        
        // Add it to the played cards stack
        game.playedCards.push(card);
        
        // Remove player's info from card
        card.player = null;
        card.state = "Played";
        
        // Invoke card played signal
        game.cardPlayed();
        
        // Deal player new cards if possible or necessary
        dealCards(player, 3 - player.cardsHand.length);
    }
}

function handlePlay() {
    // Get last played card
    var card = playedCards[playedCards.length - 1];
    var cardValue = card.cardObject.number;
    var numberOfTurnsToSkip = 1;
    
    // Don't set new topcard if the card played was 3
    if (cardValue !== "3") {
        game.stackLevel++;
        game.topCard = card;
    }
    
    // Burn played cards
    if (cardValue === "10") {
        for (var i = 0; i < game.playedCards.length; i++) {
            playedCards[i].state = "Burned";
        }
        
        numberOfTurnsToSkip = 0;
    }
    
    // Skip next player
    if (cardValue === "8") {
        numberOfTurnsToSkip = 2;
    }
    
    switchPlayerTurn(numberOfTurnsToSkip);
}

function isPlayPossible(player) {
    var cards = player.cardsHand;
    
    for (var i = 0; i < cards.length; i++) {
        if (cards[i].playable) {
            return true;
        }
    }
    
    return false;
}

function switchPlayerTurn(numberOfTimes) {
    if (typeof(numberOfTimes) === 'undefined') numberOfTimes = 1; // Default parameter value
    
    // Choose the next player in the array
    game.playerTurn = (game.playerTurn + numberOfTimes) % game.players.length;
    
    var currentPlayer = game.players[game.playerTurn];
    
    // If the next player does not have a possible play
    if (!isPlayPossible(currentPlayer)) {
        for (var i = 0; game.playedCards.length; i++) {
            var currentCard = game.playedCards.pop();
            
            // Change card from owner
            currentCard.state = currentPlayer.handState;
            currentCard.player = currentPlayer;
            currentPlayer.cardsHand.push(currentCard);
        }
        
        // Reset the play area
        game.stackLevel = 0;
        game.topCard = undefined;
        
        game.playerTurn = (game.playerTurn + 1) % game.players.length;
    }
}

function shuffle(array) {
    var currentIndex = array.length,
            temporaryValue,
            randomIndex;
    
    // While there remain elements to shuffle...
    while (0 !== currentIndex) {
        
        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;
        
        // And swap it with the current element.
        temporaryValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = temporaryValue;
    }
    
    return array;
}

function findCardState(cards, state) {
    for (var i = 0; i < cards.length; i++) {
        if (cards[i].state === state) return true;
    }

    return false;
}

function isPlayable(card) {
    var player = card.player;

    // If card is not owned by any player or it's not this player's turn
    if (typeof(player) === 'undefined' ||
            game.players.indexOf(player) !== game.playerTurn) return false;

    // If the player has no cards in his hand and there are no cards in the stack
    if (player.cardsHand.length === 0
            && stackOfCards.length === 0) {

        // If player has top hidden cards and this card is not one of them
        if (findCardState(player.cardsHidden, player.hiddenTopState)
                && card.state === player.hiddenBottomState)
            return false;
    }
    // If there are still cards in either the player's hand or the stack
    else {
        // And this card is one of the hidden cards
        if (card.state === player.hiddenTopState || card.state === player.hiddenBottomState)
            return false;
    }

    // If the play area is empty
    if (game.topCard === undefined) return true;
    
    // Get cards' values
    var topCardValue = game.topCard.cardObject.number;
    var playCardValue = card.cardObject.number;
    
    // Get rules for the top card
    var topCardRules = cardsRules[topCardValue];
    
    // Check if this card cannot be played
    if (topCardRules.indexOf(playCardValue) > -1) return false;
    
    // If none of the constraints above apply
    return true;
}

// TODO: Find a better algorithm
function calculateSpacing(area) {
    //    if (area === player2Area) return 0;

    var cardWidth = 100; // TODO: Fix this
    var widthOverflow = game.width / area.children.length;
    
    if (area.children.length * cardWidth > game.width)
        return -(cardWidth - widthOverflow / 1.5);
    else
        return 10;
}
