import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("TIC TAC TOE Game")),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              PlayerPanel(),
              SizedBox(height: 55),
              GameGrid(),
            ],
          ),
        ),
      ),
    ),
  );
}

class PlayerPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Color.fromARGB(255, 14, 21, 131),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlayerNamePanel("Player 1", "X"),

            PlayerNamePanel("Player 2", "O"),
          ],
        ),
      ),
    );
  }
}

class PlayerNamePanel extends StatefulWidget {
  String initialName = "";
  String initialSymbol = "";
  PlayerNamePanel(String name, String symbol) {
    initialName = name;
    initialSymbol = symbol;
  }

  @override
  State<StatefulWidget> createState() {
    return PlayerNamePanelState();
  }
}

class PlayerNamePanelState extends State<PlayerNamePanel> {
  String playerName = "Player A";
  String buttonText = "edit";
  String symbolText = "X";
  initState() {
    super.initState();
    playerName = widget.initialName;
    symbolText = widget.initialSymbol;
  }

  TextEditingController textController = TextEditingController();
  onEditButtonClick() {
    setState(() {
      if (buttonText == "edit") {
        buttonText = "save";
      } else {
        playerName = textController.text;
        buttonText = "edit";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 130,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color.fromARGB(255, 68, 142, 246),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buttonText == "edit"
                ? Text(
                  playerName,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                )
                : TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    border: OutlineInputBorder(),
                  ),
                ),
            Text(symbolText),
            ElevatedButton(
              onPressed: onEditButtonClick,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}

class GameGrid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameGridState();
  }
}

class GameGridState extends State<GameGrid> {
  List<String> gameState = ["", "", "", "", "", "", "", "", "", ""];
  String turnSymbol = 'X';
  String turnText = "Turn : X";

  void resetGame() {
    setState(() {
      gameState = ["", "", "", "", "", "", "", "", "", ""];
      turnSymbol = 'X';
      turnText = "Turn : X";
    });
  }

  onGameGridButtonClick(int index) {
    setState(() {
      if (gameState[index] == "") {
        gameState[index] = turnSymbol;
      }
      String result = checkWin();

      if (result == 'WIN') {
        turnText = "WIN : " + turnSymbol;
      } else if (result == 'DRAW') {
        turnText = "DRAW";
      } else {
        turnSymbol = turnSymbol == 'X' ? 'O' : 'X';
        turnText = "Turn : $turnSymbol";
      }
    });
  }

  String checkWin() {
    var winningCombinations = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7],
    ];
    for (var combo in winningCombinations) {
      if (gameState[combo[0]] == turnSymbol &&
          gameState[combo[1]] == turnSymbol &&
          gameState[combo[2]] == turnSymbol) {
        return "WIN";
      }
    }
    bool isDraw = true;
    for (int i = 1; i <= 9; i++) {
      if (gameState[i] == "") {
        isDraw = false;
        break;
      }
    }

    if (isDraw) {
      return "DRAW";
    }

    return "GAMEON";
  }

  Widget buildButton(int index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 120,
        height: 120,
        child: ElevatedButton(
          onPressed: () => {onGameGridButtonClick(index)},
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 221, 155, 110),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            gameState[index],
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 125),
                Text(
                  turnText,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 146, 146),
                  ),
                ),
              ],
            ),
            Row(children: [buildButton(1), buildButton(2), buildButton(3)]),
            Row(children: [buildButton(4), buildButton(5), buildButton(6)]),
            Row(children: [buildButton(7), buildButton(8), buildButton(9)]),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetGame,

              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 1, 146, 146),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Reset Game", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
