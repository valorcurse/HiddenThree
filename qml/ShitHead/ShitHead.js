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

var blockWidth = 100;
var blockHeight = 100 * 1.54;
var player1Area;
var player2Area;

var player1;
var player2;

var stackLevel = 0;

function removeIndex(array, index) {
    if (index !== -1)
        array.splice(index, 1);
}

function startNewGame(p1Area, p2Area) {

    player1Area = p1Area;
    player2Area = p2Area;

    player1 = {
        cards: new Array(3),
        cardsPosition : {x: (player1Area.width - (blockWidth * 3)) / 2, y: player1Area.height - blockHeight}
    };

    for (var i = 0; i < 3; i++) {
        var rnd = Math.floor((Math.random() * stackOfCards.length - 1) + 1);
        player1.cards[i] = stackOfCards[rnd];

        removeIndex(stackOfCards, rnd)
    }

    //  Initialize Board
    for (var index = 0; index < player1.cards.length; index++) {

        var card = player1.cards[index];

        createBlock(index, card, player1);
    }
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

        dynamicObject.x = player.cardsPosition.x + index * blockWidth;
        dynamicObject.y = player.cardsPosition.y;
        dynamicObject.width = blockWidth;
        dynamicObject.height = blockHeight;

    } else {
        console.log("error loading block component");
        console.log(component.errorString());

        return false;
    }

    return true;
}

function playCard(card) {
    if (card.state !== "played") {
        card.y = (playArea.y + playArea.height / 2) - (card.height / 2);
        card.x = (playArea.x + playArea.width / 2) - (card.width / 2);
        card.z = ++screen.stackLevel;
        card.rotation = Math.floor(Math.random() * 360) + 1

        card.state = "played";
    }
}
