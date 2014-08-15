Qt.include("GameProperties.js");

//var player1;
//var player2;

function startNewGame() {
    
    
    //  Initialize Board
    createStackOfCards();
    
    // Shuffle cards
    shuffle(stackOfCards);
    
    // Create players
    player1.areas = {
        playerHandArea: gameArea.player1Area,
        threeTopArea: gameArea.player1ThreeTop,
        threeBottomArea: gameArea.player1ThreeBottom
    }
    game.players.push(player1);
    game.playerTurn = game.players.indexOf(player1);
    
    player2.areas = {
        playerHandArea: gameArea.player2Area,
        threeTopArea: gameArea.player2ThreeTop,
        threeBottomArea: gameArea.player2ThreeBottom
    }
    game.players.push(player2);
    
    dealHiddenCards(player1);
    dealHiddenCards(player2);
    
    // Deals cards to players
    dealCards(player1, 6);
    dealCards(player2, 6);

    //    gameArea.state = "chooseCards";
    gameArea.cardsAreDealt = true;
}

function dealHiddenCards(player) {
    for (var i = 0; i < 3; i++) {
        
        var card = stackOfCards.pop();
        
        card.state = "PlayerThreeBottom";
        card.player = player;
        
        player.cardsHidden.push(card)
    }
}

function dealCards(player, numberOfCards) {
    if (stackOfCards.length > 0)
        for (var i = 0; i < numberOfCards; i++) {

            var card = stackOfCards.pop();
            card.player = player;
            card.state = "PlayerHand";

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
            var card = component.createObject(stackOfCardsArea, {cardObject: cardsInfo[i]});
            
            if (card === null) {
                console.log("error creating block");
                console.log(component.errorString());
                
                return false;
            }

            
            stackOfCards.push(card);
            //            console.log(pageLoader.item.children.contains("stackOfCardsArea"))
            //            card.parent = stackOfCardsArea;

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

function chooseTopCard(card) {
    var player = card.player;
    if (player.cardsHidden.length < 6) {
        card.state = player.hiddenTopState;

        var cardIndex = player.cardsHand.indexOf(card);
        removeIndex(player.cardsHand, cardIndex);
        player.cardsHidden.push(card);
    }
}

function removeTopCard(card) {
    var player = card.player;
    card.state = player.handState;

    var cardIndex = player.cardsHidden.indexOf(card);
    removeIndex(player.cardsHidden, cardIndex);
    player.cardsHand.push(card);
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

    // If it's the game phase to choose the top cards
    if (gameArea.state === "chooseCards"
            && card.state === "Player1Hand" || card.state === "Player2Hand")
        return true;

    // If it's the game phase to play
    else if (gameArea.state === "playCards") {
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

    }

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
