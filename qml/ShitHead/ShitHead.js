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
        playerHandArea: game.player1CardsArea,
        threeTopArea: game.player1ThreeTop,
        threeBottomArea: game.player1ThreeBottom
    }
    game.players.push(player1);
    game.playerTurn = game.players.indexOf(player1);
    
    player2.areas = {
        playerHandArea: game.player2CardsArea,
        threeTopArea: game.player2ThreeTop,
        threeBottomArea: game.player2ThreeBottom
    }
    game.players.push(player2);
    
    dealHiddenCards(player1);
    dealHiddenCards(player2);
    
    // Deals cards to players
    dealCards(player1, 6);
    dealCards(player2, 6);

    game.cardsAreDealt = true;
}

function dealHiddenCards(player) {
    for (var i = 0; i < 3; i++) {
        
        var card = stackOfCards.pop();
        
        card.state = "PlayerThreeBottom";
        card.player = player;
        
        player.bottomCards.push(card)
    }
}

function dealCards(player, numberOfCards) {
    if (stackOfCards.length > 0)
        for (var i = 0; i < numberOfCards; i++) {

            var card = stackOfCards.pop();
            card.player = player;
            card.state = "PlayerHand";

            player.handCards.push(card);
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
            card.state = "Stack";
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

    if (player.topCards.length < 3) {
        card.state = "PlayerThreeTop";

        var cardIndex = player.handCards.indexOf(card);
        removeIndex(player.handCards, cardIndex);
        player.topCards.push(card);
    }
}

function removeTopCard(card) {
    var player = card.player;
    card.state = "PlayerHand";

    var cardIndex = player.topCards.indexOf(card);
    removeIndex(player.topCards, cardIndex);
    player.handCards.push(card);
}

function playCard(card) {
    
    if (card.playable) {
        
        // Remove card from player's hand
        var player = card.player;
        var cardIndex = player.handCards.indexOf(card);
        removeIndex(player.handCards, cardIndex);
        
        // Add it to the played cards stack
        game.playedCards.push(card);
        
        // Remove player's info from card
        card.state = "Played";
        //        card.player = null;
        
        // Invoke card played signal
        game.cardPlayed();
        
        // Deal player new cards if possible or necessary
        dealCards(player, 3 - player.handCards.length);
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
    } else {
        cardValue = game.topCard.cardObject.number;
    }

    // Burn played cards
    if (cardValue === "10") {
        for (var i = 0; i < game.playedCards.length; i++) {
            var playedCard = playedCards[i];
            playedCard.state = "Burned";

            removeFromPlayedCards(playedCard);
        }
        
        numberOfTurnsToSkip = 0;
    }
    
    // Skip next player
    if (cardValue === "8") {
        numberOfTurnsToSkip = 2;
    }

    switchPlayerTurn(numberOfTurnsToSkip);

    var currentPlayer = game.players[game.playerTurn];

    // If the next player does not have a possible play
    if (!isPlayPossible(currentPlayer)) {

        console.log("player: " + currentPlayer.id)

        // Return cards to player's hand
        for (var i = 0; i < game.playedCards.length; i++) {
            var currentCard = game.playedCards.pop();

            // Change card from owner
            currentCard.player = currentPlayer;
            currentCard.state = "PlayerHand";
            currentPlayer.handCards.push(currentCard);

            removeFromPlayedCards(currentCard);
        }

        // Reset the play area
        game.topCard = undefined;

        switchPlayerTurn();
    }
}

function removeFromPlayedCards(card) {
    var cardIndex = playedCards.indexOf(card);
    removeIndex(playedCards, cardIndex);
    game.stackLevel--;
}

function isPlayPossible(player) {
    var cards = player.handCards;
    
    for (var i = 0; i < cards.length; i++) {
        if (cards[i].playable) {
            return true;
        }
    }
    
    return false;
}

function areTopCardsChosen() {
    for (var player in game.players) {
        var topCards = game.players[player].topCards;

        if (topCards.length < 3) return false;

        for (var card in topCards) {
            if (!topCards[card].chosen) {
                //                console.log("false");
                return false;
            }
        }
    }

    //    console.log("true");
    return true;
}

function switchPlayerTurn(numberOfTimes) {
    if (typeof(numberOfTimes) === 'undefined') numberOfTimes = 1; // Default parameter value
    
    // Choose the next player in the array
    game.playerTurn = (game.playerTurn + numberOfTimes) % game.players.length;
    


    //    var currentPlayer = game.players[game.playerTurn];
    
    //    // If the next player does not have a possible play
    //    if (!isPlayPossible(currentPlayer)) {
    //        for (var i = 0; game.playedCards.length; i++) {
    //            var currentCard = game.playedCards.pop();

    //            // Change card from owner
    //            currentCard.state = currentPlayer.handState;
    //            currentCard.player = currentPlayer;
    //            currentPlayer.handCards.push(currentCard);
    //        }

    //        // Reset the play area
    //        game.stackLevel = 0;
    //        game.topCard = undefined;

    //        game.playerTurn = (game.playerTurn + 1) % game.players.length;
    //    }
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

    // If it's the phase to choose the top cards
    if (game.state === "chooseCards") {

        // And the card is in a player's hand
        if (card.state === "PlayerHand" || card.state === "PlayerThreeTop")
            return true;
        else
            return false;
    }

    // If it's the play phase
    else if (game.state === "playCards") {

        //        if (stackOfCards.length === 0 && player.handCards.length === 0)

        // If card is not owned by any player or it's not this player's turn
        if (typeof(player) === 'undefined' ||
                game.players.indexOf(player) !== game.playerTurn) return false;

        //         If card is part of top three and there are still cards in the hand/stack
        if (player.topCards.indexOf(card) > -1
                && player.handCards.length > 0  && stackOfCards.length > 0) {
            return false;
        }

        //         If card is part of bottom three and there are still top three cards
        if (player.bottomCards.indexOf(card) > -1 && player.topCards.length !== 0)
            return false;

        // If the player has no cards in his hand and there are no cards in the stack
        //        if (player.handCards.length === 0  && stackOfCards.length === 0) {

        //            // If player has top hidden cards and this card is not one of them
        //            if (findCardState(player.cardsHidden, player.hiddenTopState)
        //                    && card.state === player.hiddenBottomState)
        //                return false;
        //        }

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
