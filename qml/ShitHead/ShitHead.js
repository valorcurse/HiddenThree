Qt.include("GameProperties.js");

function startNewGame() {
    
    //  Initialize Board
    createStackOfCards();
    
    // Shuffle cards
    shuffle(stackOfCards);
    
    // Create players
    player1 = game.players[0];
    player1.hand.area = game.player1CardsArea;
    player1.threeTop.area = game.player1ThreeTop;
    player1.threeBottom.area = game.player1ThreeBottom;
    //    game.players.push(player1);
    game.currentPlayer = player1;

    console.log("id: " + game.players[0].playerID);
    
    player2 = game.players[1];
    player2.hand.area =  game.player2CardsArea;
    player2.threeTop.area =  game.player2ThreeTop;
    player2.threeBottom.area =  game.player2ThreeBottom;
    //    game.players.push(player2);
    
    dealHiddenCards(player1);
    dealHiddenCards(player2);
    
    // Deals cards to players
    dealCards(player1, 3);
    dealCards(player2, 3);

    console.log("Stack of cards: " + stackOfCards.length);

    game.cardsAreDealt = true;
}

function dealHiddenCards(player) {
    //    console.log(player.hand.area);

    for (var i = 0; i < 3; i++) {
        
        var card = stackOfCards.pop();
        
        //        console.log("Card sizes: " + card.width + "x" + card.height);

        card.player = player;
        card.state = "ThreeBottom";
        
        player.threeBottom.cards.append({"object": card})
    }
}

function dealCards(player, numberOfCards) {
    if (stackOfCards.length > 0)
        for (var i = 0; i < numberOfCards; i++) {

            var card = stackOfCards.pop();
            card.player = player;
            card.state = "Hand";

            player.hand.cards.append({"object": card});
        }
}

function removeIndex(array, index) {
    if (index !== -1)
        array.splice(index, 1);
}

function indexOfListModel(item, list) {
    for (var i = 0; i < list.count; i++) {
        if (item === list.get(i).object) {
            return i;
        }
    }

    return undefined;
}

function createStackOfCards() {
    var component = Qt.createComponent("Card.qml");
    
    if (component.status === Component.Ready) {
        
        //        for (var i = 0; i < cardsInfo.length; i++) {
        for (var i = 0; i < 12; i++) {
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

    //    console.log("Adding: " + playr.hand.cards[cardIndex]);

    if (player.threeTop.cards.count < 3) {
        card.state = "ThreeTop";

        var cardIndex = indexOfListModel(card, player.hand.cards);

        //        console.log("Choosing top cardIndex: " + cardIndex);

        player.hand.cards.remove(cardIndex);
        player.threeTop.cards.append({"object": card});
    }
}

function removeTopCard(card) {
    var player = card.player;
    card.state = "Hand";

    var cardIndex = indexOfListModel(card, player.threeTop.cards);

    console.log("Removing: " + player.threeTop.cards[cardIndex]);

    player.threeTop.cards.remove(cardIndex);
    player.hand.cards.append({"object": card});
}

function playCard(card) {
    
    if (card.playable) {

        // Remove card from player's hand
        var player = card.player;
        var cardContainer;

        if (card.state === "Hand") {
            cardContainer = player.hand.cards;
        }
        else if (card.state === "ThreeTop") {
            cardContainer = player.threeTop.cards;
        }
        else if (card.state === "ThreeBottom") {
            cardContainer = player.threeBottom.cards;
        }

        // Remove card from current container
        var cardIndex = indexOfListModel(card, cardContainer);
        cardContainer.remove(cardIndex);

        // Add it to the played cards stack
        game.playedCards.push(card);

        // Remove player's info from card
        card.state = "Played";
        card.player = undefined;

        // Invoke card played signal
        game.cardPlayed();
    }
}

function handlePreTurn() {

    console.log("Handling preturn");

    // If the next player does not have a possible play
    if (!isPlayPossible(game.currentPlayer)) {

        console.log("Player " + game.currentPlayer.playerID + " cannot play.");

        // Return cards to player's hand
        while (game.playedCards.length > 0) {
            var currentCard = playedCards.pop();

            currentCard.player = game.currentPlayer;
            currentCard.state = "Hand";
            game.currentPlayer.hand.cards.append({"object": currentCard});
        }

        // Reset the play area
        game.topCard = undefined;

        switchPlayerTurn();
    }
    else {
        game.currentTurn = turn.playTurn;
        console.log("Play is possible for Player " + game.currentPlayer.playerID);
    }
}

function handlePlay() {

    // Get last played card
    var card = playedCards[playedCards.length - 1];
    var cardValue = card.cardObject.number;

    var numberOfTurnsToSkip = 1;
    
    if (isCardPlayable(card)) {

        // Don't set new topcard
        if (cardValue === "3") {
            card = game.topCard;
        }

        // Burn played cards
        else if (cardValue === "10" || quartetPlayed()) {

            console.log("Burning cards");

            while (game.playedCards.length > 0) {
                var playedCard = playedCards.pop();
                playedCard.state = "Burned";
            }

            numberOfTurnsToSkip = 0;
        }

        // Skip next player
        else if (cardValue === "8") {
            numberOfTurnsToSkip = 2;
        }

        game.topCard = card;
    }

    else {
        playedCards.pop();
        card.player = game.currentPlayer;
        card.state = "Hand";
        game.currentPlayer.hand.cards.append({"object": card});
    }

    // Deal player new cards if possible or necessary
    dealCards(currentPlayer, 3 - currentPlayer.hand.cards.length);

    switchPlayerTurn(numberOfTurnsToSkip);
}

function isPlayable(card) {
    var player = card.player;

    if (card.player === undefined) return false;

    // If it's the phase to choose the top cards
    if (game.state === "ChooseCards") {

        // And the card is in a player's hand
        if (card.state === "Hand" || card.state === "ThreeTop")
            return true;
        else
            return false;
    }

    // If it's the play phase
    else if (game.state === "Play") {

        console.log("Player: " + player.playerID +
                    " | Card: " + card.cardObject.number +
                    " | State: " + card.state);

        console.log("0");

        // If it's not this player's turn
        if (player !== game.currentPlayer) return false;

        console.log("1");

        // If card is part of top three and there are still cards in the hand/stack
        if (card.state === "ThreeTop"
                && (player.hand.cards.count > 0 || stackOfCards.length > 0)) {
            return false;
        }

        console.log("2");

        // If card is part of bottom three and there are still top three cards
        if (card.state === "ThreeBottom")
            if (player.threeTop.cards.count > 0)
                return false;
            else
                return true;

        console.log("3");

        // If the play area is empty
//        if (game.topCard === undefined) return true;

        console.log("4");

        // Get cards' values
//        var topCardValue = game.topCard.cardObject.number;
//        var playCardValue = card.cardObject.number;

//        // Get rules for the top card
//        var topCardRules = cardsRules[topCardValue];

//        // Check if this card cannot be played
//        if (topCardRules.indexOf(playCardValue) > -1) return false;

        return isCardPlayable(card);

//        console.log("5");

        // If none of the constraints above apply
//        return true;
    }

    return false;
}

function isCardPlayable(card) {

    // If the play area is empty
    if (game.topCard === undefined) return true;

    var topCardValue = game.topCard.cardObject.number;
    var playCardValue = card.cardObject.number;

    // Get rules for the top card
    var topCardRules = cardsRules[topCardValue];

    // Check if this card cannot be played
    if (topCardRules.indexOf(playCardValue) > -1)
        return false;

    else
        return true;
}

function switchPlayerTurn(numberOfTimes) {
    if (typeof(numberOfTimes) === 'undefined') numberOfTimes = 1; // Default parameter value

    // Choose the next player in the array
    var playerIndex = game.players.indexOf(game.currentPlayer);
    var nextPlayerIndex = (playerIndex + numberOfTimes) % game.players.length;

    console.log("----------------------- Switch turn: "
                + playerIndex + " -> " + nextPlayerIndex
                + " -----------------------");

    game.currentPlayer = players[nextPlayerIndex];

    game.currentTurn = turn.preTurn;
    handlePreTurn();
}

function quartetPlayed() {
    // Check if there are at least four cards played
    if (playedCards.length < 4) return false;

    // Slice the last four played cards
    var nrOfCardsPlayed = playedCards.length;
    var lastFourCards = playedCards.slice(nrOfCardsPlayed - 4,
                                          nrOfCardsPlayed);

    // Check if the last four cards make a quartet
    var lastCard = lastFourCards[0];
    for (var i = 1; i < lastFourCards.length; i++) {
        var currentCard = lastFourCards[i];

        if (currentCard.cardObject.number !== lastCard.cardObject.number)
            return false;
    }

    console.log("Found quartet");
    return true;
}

function isPlayPossible(player) {

    var cardContainer;

    if (player.state === "Hand") {
        cardContainer = player.hand.cards;
    }
    else if (player.state === "ThreeTop") {
        cardContainer = player.threeTop.cards;
    }
    else if (player.state === "ThreeBottom") {
        cardContainer = player.threeBottom.cards;
    }

    var cards = [];
    for (var i = 0; i < cardContainer.count; i++) {
        cards.push(cardContainer.get(i).object);
    }
    //    console.log("Number of cards in hand: " + cards.length);

    for (var i = 0; i < cards.length; i++) {
        //        console.log("looping hand cards - " + i);

        if (cards[i].playable) {
            //            console.log("Player: " + player.playerID +" | Card is playable: " + cards[i].cardObject.number);
            return true;
        }
    }
    
    //    console.log("Player is not able to play");
    return false;
}

function areTopCardsChosen() {
    for (var player in game.players) {
        var cards = game.players[player].threeTop.cards;

        console.log("Player " + game.players[player].playerID +  " - There are " + cards.count + " cards");

        if (cards.count < 3) return false;

        for (var i = 0; i < cards.count; i++) {
            console.log("card id: " + cards.get(i).object);
            console.log(cards.get(i).object.chosen);

            if (!cards.get(i).object.chosen) {
                return false;
            }
        }
    }

    return true;
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

// TODO: Find a better algorithm
function calculateSpacing(area) {
    //    if (area === player2Area) return 0;

    var cardWidth = cardHeight / 1.54; // TODO: Fix this
    var widthOverflow = game.width / area.children.length;
    
    if (area.children.length * cardWidth > game.width)
        return -(cardWidth - widthOverflow / 1.5);
    else
        return 10;
}
