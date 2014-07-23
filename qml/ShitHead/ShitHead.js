var stackOfCards = [
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
        ]

var cardsPriority = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "j", "q", "k", "a"];

var player1;
var player2;

function startNewGame(p1Area, p2Area) {

    // Shuffle cards
    shuffle(stackOfCards);

    //  Initialize Board
    createStackOfCards();

    // Create players
    player1 = {
        cards: new Array(3),
        cardsPosition : {x: (player1Area.width ) / 2, y: player1Area.y },
        playerArea: player1Area
    };

    player2 = {
        cards: new Array(3),
        cardsPosition: {x: (player2Area.width ) / 2, y: player2Area.y },
        playerArea: player2Area
    };

    // Deals cards to players
    dealCards(player1, 3);
    dealCards(player2, 3);

}

function dealCards(player, numberOfCards) {
    for (var i = 0; i < numberOfCards; i++) {
        player.cards[i] = stackOfCards.pop();
        createBlock(i, player.cards[i], player);
    }
}

function removeIndex(array, index) {
    if (index !== -1)
        array.splice(index, 1);
}

function createStackOfCards() {
    var component = Qt.createComponent("Card.qml");

    if (component.status === Component.Ready) {

        for (var i = 0; i < stackOfCards.length; i++) {
            var card = component.createObject(background, {cardObject: stackOfCards[i]});

            if (card === null) {
                console.log("error creating block");
                console.log(component.errorString());

                return false;
            }

            card.state = "Stack";

        }
    } else {
        console.log("error loading block component");
        console.log(component.errorString());

        return false;
    }

    return true;
}

function createBlock(index, card, player) {
    var component = Qt.createComponent("Card.qml");

    if (component.status === Component.Ready) {
        var dynamicObject = component.createObject(background, {cardObject: card, player: player});

        if (dynamicObject === null) {
            console.log("error creating block");
            console.log(component.errorString());

            return false;
        }

        var cardsSize = player.cards.length * dynamicObject.width;

        dynamicObject.x = (player.playerArea.width - cardsSize) / 2 + index * dynamicObject.width;
        dynamicObject.y = player.playerArea.y + (player.playerArea.height - dynamicObject.height) / 2;

    } else {
        console.log("error loading block component");
        console.log(component.errorString());

        return false;
    }

    return true;
}

function playCard(card) {
    if (card.state === "Played") return;

    // No card has been played
    if (screen.topCard === undefined ||
            // Or card can be played
            cardsPriority.indexOf(card.cardObject.number) >= cardsPriority.indexOf(screen.topCard.cardObject.number)) {

        card.state = "Played";
        ++screen.stackLevel;
        screen.topCard = card;
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

function ifPlayable(card) {
    if (card.cardObject === undefined) return;

    if (screen.topCard === undefined ||
            cardsPriority.indexOf(card.cardObject.number) >= cardsPriority.indexOf(screen.topCard.cardObject.number)) {
        return "green";
    } else {
        return "transparent";
    }
}
