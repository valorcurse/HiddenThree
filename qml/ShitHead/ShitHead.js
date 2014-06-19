var stackOfCards = [
            [
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
                {number: "a", type: "clover", source: "textures/cards/c_a.png"}
            ],
            [
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
                {number: "a", type: "diamonds", source: "textures/cards/d_a.png"}
            ],
            [
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
                {number: "a", type: "spades", source: "textures/cards/s_a.png"}
            ],
            [
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
        ]

var blockWidth = 100;
var blockHeight = 100 * 1.54;
var maxColumn = stackOfCards.length;
var maxRow = stackOfCards[0].length;
var maxIndex = maxColumn * maxRow;
var board = new Array(maxIndex);
var component;

//Index function used instead of a 2D array
function index(column, row) {
    return column + (row * maxColumn);
}

function startNewGame() {
    //Delete blocks from previous game
    for (var i = 0; i < maxIndex; i++) {
        if (board[i] != null)
            board[i].destroy();
    }

    //Initialize Board
    board = new Array(maxIndex);
    for (var column = 0; column < maxColumn; column++) {

        for (var row = 0; row < maxRow; row++) {

            board[index(column, row)] = null;

            var card = stackOfCards[column][row];

            createBlock(row, column, card);
        }
    }
}

function createBlock(column, row, card) {
    if (component == null)
        component = Qt.createComponent("Card.qml");

    // Note that if Block.qml was not a local file, component.status would be
    // Loading and we should wait for the component's statusChanged() signal to
    // know when the file is downloaded and ready before calling createObject().
    if (component.status == Component.Ready) {
        var dynamicObject = component.createObject(background);

        if (dynamicObject == null) {
            console.log("error creating block");
            console.log(component.errorString());

            return false;
        }

       dynamicObject.imageSource = card.source;

                dynamicObject.x = column * blockWidth;
                dynamicObject.y = row * blockHeight;
                dynamicObject.width = blockWidth;
                dynamicObject.height = blockHeight;
                board[index(column, row)] = dynamicObject;

    } else {
        console.log("error loading block component");
        console.log(component.errorString());

        return false;
    }
    return true;
}
