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
        cards: [],
        playerArea: player1Area,
        state: "Player1"
    };
    game.players.push(player1);
    game.playerTurn = game.players.indexOf(player1);

    player2 = {
        cards: [],
        playerArea: player2Area,
        state: "Player2"
    };
    game.players.push(player2);


    // Deals cards to players
    dealCards(player1, 15);
    dealCards(player2, 3);
}

function dealCards(player, numberOfCards) {
    for (var i = 0; i < numberOfCards; i++) {

        var card = stackOfCards.pop();
        card.state = player.state;
        card.player = player;

        player.cards.push(card);
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
            var card = component.createObject(background, {cardObject: cardsInfo[i], state: "Stack"});

            if (card === null) {
                console.log("error creating block");
                console.log(component.errorString());

                return false;
            }

            stackOfCards.push(card);
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
        var cardIndex = player.cards.indexOf(card);
        removeIndex(player.cards, cardIndex);

        // Add it to the played cards stack
        game.playedCards.push(card);

        // Remove player's info from card
        card.player = null;
        card.state = "Played";

        // Don't set new topcard if the card played was 3
        if (card.cardObject.number !== "3") {
            game.stackLevel++;
            game.topCard = card;
        }

        // Deal player new cards if possible or necessary
        dealCards(player, 3 - player.cards.length);

        switchPlayerTurn();
    }
}

function isPlayPossible(player) {
    var cards = player.cards;

    for (var i = 0; i < cards.length; i++) {
        if (cards[i].playable) {
            return true;
        }
    }

    return false;
}

function switchPlayerTurn() {
    // Choose the next player in the array
    game.playerTurn = (game.playerTurn + 1) % game.players.length;

    var currentPlayer = game.players[game.playerTurn];

    // If the next player has a possible play
    if (!isPlayPossible(currentPlayer)) {
        for (var i = 0; game.playedCards.length; i++) {
            var currentCard = game.playedCards.pop();

            // Change card from owner
            currentCard.state = currentPlayer.state;
            currentCard.player = currentPlayer;
            currentPlayer.cards.push(currentCard);
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

function isPlayable(card) {

    // If card is not owned by either the players
    if (card.state !== "Player1" && card.state !== "Player2") return false;

    // If it's not this player's turn
    if (game.players.indexOf(card.player) !== game.playerTurn) return false;

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

function calculateSpacing(area) {
    var cardWidth = 100; // TODO: Fix this
    var widthOverflow = game.width - (area.children.length * cardWidth);
    if (widthOverflow < 0) {
        return widthOverflow / area.children.length * 2;

    }
    else
        return 10;
}
