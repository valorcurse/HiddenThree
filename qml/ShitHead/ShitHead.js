Qt.include("GameProperties.js");

function createNewGame(gameName, ip, uuid) {
    var component = Qt.createComponent("Game.qml");
    var game;
    if (component.status === Component.Ready) {

        game = component.createObject(null,
                                      {gameName: gameName,
                                          ip: ip,
                                          uuid: uuid});

        if (game === null) {
            console.log("error creating block");
            console.log(component.errorString());

            return undefined;
        }
    } else {
        console.log("error loading block component");
        console.log(component.errorString());

        return undefined;
    }

    return game;
}

function createNewPlayer(newPlayerID) {
    var component = Qt.createComponent("Player.qml");
    var newPlayer = component.createObject(null,
                                           {playerID: newPlayerID});
    game.players.push(newPlayer);
}

function startNewGame() {

    //  Initialize Board
    createStackOfCards();

    console.log("number of cards: " + game.stackOfCards.length);

    // Shuffle cards
    shuffle(game.stackOfCards);

    // Create players
    player1 = game.players[0];
    player1.hand.area = gameArea.player1CardsArea;
    player1.threeTop.area = gameArea.player1ThreeTop;
    player1.threeBottom.area = gameArea.player1ThreeBottom;
    game.currentPlayer = player1;

    console.log("current player: " + game.currentPlayer);

    player2 = game.players[1];
    player2.hand.area =  gameArea.player2CardsArea;
    player2.threeTop.area =  gameArea.player2ThreeTop;
    player2.threeBottom.area =  gameArea.player2ThreeBottom;

    dealBottomCards(player1);
    dealBottomCards(player2);

    // Deals cards to players
    dealCards(player1, 6);
    dealCards(player2, 6);

    console.log("Stack of cards: " + game.stackOfCards.length);

    game.cardsAreDealt = true;
}

function dealBottomCards(player) {
    if (game.stackOfCards.length >= 3) {
        for (var i = 0; i < 3; i++) {
            var card = game.stackOfCards.pop();
            player.addToThreeBottom(card);
        }
    }
}

function dealCards(player, numberOfCards) {
    if (game.stackOfCards.length >= numberOfCards)
        for (var i = 0; i < numberOfCards; i++) {
            var card = game.stackOfCards.pop();
            player.addToHand(card);
        }
}

function createStackOfCards() {
    var component = Qt.createComponent("Card.qml");

    for (var i = 0; i < cardsInfo.length; i++) {
        var card = component.createObject(gameArea.stackOfCardsArea, {cardObject: cardsInfo[i]});

        if (card === null) {
            console.log("error creating block");
            console.log(component.errorString());

            return false;
        }

        game.stackOfCards.push(card);
        card.state = "Stack";
    }

    return true;
}

function playCard(card) {

    if (card.playable) {

        // Remove card from player's hand
        var player = card.player;
        var cardContainer;

        if (card.state === "Hand") {
            cardContainer = player.hand;
        }
        else if (card.state === "ThreeTop") {
            cardContainer = player.threeTop;
        }
        else if (card.state === "ThreeBottom") {
            cardContainer = player.threeBottom;
        }

        // Remove card from current container
        var cardIndex = cardContainer.indexOf(card);
        cardContainer.cards.remove(cardIndex);

        // Add it to the played cards stack
        game.playedCards.push(card);

        // Remove player's info from card
        card.state = "Played";
        //        card.player = undefined;

        console.log("Card: " + typeof(card));

        // Invoke card played signal
        game.cardPlayed(card);
    }
}

function handlePreTurn() {

    console.log("Handling preturn");

    // If the next player does not have a possible play
    if (!isPlayPossible(game.currentPlayer)) {

        console.log("Player " + game.currentPlayer.playerID + " cannot play.");

        grabPlayedCards()

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
        grabPlayedCards();
    }

    // Deal player new cards if possible or necessary
    dealCards(currentPlayer, 3 - currentPlayer.hand.cards.count);

    switchPlayerTurn(numberOfTurnsToSkip);
}

function grabPlayedCards() {
    // Return cards to player's hand
    while (game.playedCards.length > 0) {
        var currentCard = playedCards.pop();

        currentCard.player = game.currentPlayer;
        currentCard.state = "Hand";
        game.currentPlayer.hand.cards.append({"object": currentCard});
    }
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

        console.log("isPlayable - Card " + card.cardObject.number
                    + " State: " + card.state);

        // If it's not this player's turn
        if (player !== game.currentPlayer) return false;

        console.log("Player's turn");

        if (card.state !== player.state) return false;

        console.log("Player's state");

        // If card is part of top three and there are still cards in the hand/stack
        if (card.state === "ThreeTop"
                && (player.hand.cards.count > 0 || game.stackOfCards.length > 0)) {
            return false;
        }

        console.log("No cards in hand/stack");

        // If card is part of bottom three and there are still top three cards
        if (card.state === "ThreeBottom")
            if (player.threeTop.cards.count > 0)
                return false;
            else
                return true;

        console.log("Not bottom card");

        return isCardPlayable(card);

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

    console.log("isPlayPossible - Player " + player.playerID + " state: " + player.state);

    for (var i = 0; i < cardContainer.count; i++) {
        console.log("Card " + cardContainer.get(i).object.cardObject.number +
                    " playable: " +  cardContainer.get(i).object.playable);
        if (cardContainer.get(i).object.playable) {
            return true;
        }
    }

    return false;
}

function areTopCardsChosen() {
    for (var player in game.players) {
        var cards = game.players[player].threeTop.cards;

        if (cards.count < 3) return false;

        for (var i = 0; i < cards.count; i++) {
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
