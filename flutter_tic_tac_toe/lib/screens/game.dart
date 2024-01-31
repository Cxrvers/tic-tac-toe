import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class LoadGame extends StatefulWidget {
  const LoadGame({super.key});

  @override
  State<LoadGame> createState() => _LoadGameState();
}

class _LoadGameState extends State<LoadGame> {
  bool player1Turn = true;
  List<String> gameBoard = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes = [];
  int attempts = 0;

  String resultDeclaration = '';
  bool winnerFound = false;
  int player1Score = 0;
  int player2Score = 0;
  int areBoxesFull = 0;
  

  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;

  static var font = GoogleFonts.coiny(
    textStyle: TextStyle(
      color: Colors.black,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          endTimer();
        }
      });
    });
  }

  void endTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourScheme.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(resultDeclaration, style: font),
                    SizedBox(height: 10),
                    _buildTimer()
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _pressed(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(180),
                          border: Border.all(
                            width: 5,
                            color: ColourScheme.primaryColor,
                          ),
                          color: matchedIndexes.contains(index)
                              ? ColourScheme.accentColor
                              : ColourScheme.secondaryColor,
                        ),
                        child: Center(
                          child: Text(
                            gameBoard[index],
                            style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                              fontSize: 64,
                              color: matchedIndexes.contains(index)
                                  ? ColourScheme.secondaryColor
                                  : ColourScheme.primaryColor,
                            )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Player O',
                        style: font,
                      ),
                      Text(
                        player1Score.toString(),
                        style: font,
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Player X',
                        style: font,
                      ),
                      Text(
                        player2Score.toString(),
                        style: font,
                      ),
                    ],
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  void _pressed(int index) {
    final isRunning = timer == null ? false : timer!.isActive;

    if (isRunning) {
      setState(() {
        if (player1Turn && gameBoard[index] == '') {
          gameBoard[index] = 'O';
          areBoxesFull++;
        } else if (!player1Turn && gameBoard[index] == '') {
          gameBoard[index] = 'X';
          areBoxesFull++;
        }

        player1Turn = !player1Turn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // check 1st row
    if (gameBoard[0] == gameBoard[1] &&
        gameBoard[0] == gameBoard[2] &&
        gameBoard[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + gameBoard[0] + ' Wins!';
        matchedIndexes.addAll([0, 1, 2]);
        endTimer();
        _updateScore(gameBoard[0]);
      });
    }

    // check 2nd row
    if (gameBoard[3] == gameBoard[4] &&
        gameBoard[3] == gameBoard[5] &&
        gameBoard[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + gameBoard[3] + ' Wins!';
        matchedIndexes.addAll([3, 4, 5]);
        endTimer();
        _updateScore(gameBoard[3]);
      });
    }

    // check 3rd row
    if (gameBoard[6] == gameBoard[7] &&
        gameBoard[6] == gameBoard[8] &&
        gameBoard[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + gameBoard[6] + ' Wins!';
        matchedIndexes.addAll([6, 7, 8]);
        endTimer();
        _updateScore(gameBoard[6]);
      });
    }

    // check 1st column
    if (gameBoard[0] == gameBoard[3] &&
        gameBoard[0] == gameBoard[6] &&
        gameBoard[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + gameBoard[0] + ' Wins!';
        matchedIndexes.addAll([0, 3, 6]);
        endTimer();
        _updateScore(gameBoard[0]);
      });
    }

    // check 2nd column
    if (gameBoard[1] == gameBoard[4] &&
        gameBoard[1] == gameBoard[7] &&
        gameBoard[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + gameBoard[1] + ' Wins!';
        matchedIndexes.addAll([1, 4, 7]);
        endTimer();
        _updateScore(gameBoard[1]);
      });
    }

    // check 3rd column
    if (gameBoard[2] == gameBoard[5] &&
        gameBoard[2] == gameBoard[8] &&
        gameBoard[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + gameBoard[2] + ' Wins!';
        matchedIndexes.addAll([2, 5, 8]);
        endTimer();
        _updateScore(gameBoard[2]);
      });
    }

    // check diagonal
    if (gameBoard[0] == gameBoard[4] &&
        gameBoard[0] == gameBoard[8] &&
        gameBoard[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + gameBoard[0] + ' Wins!';
        matchedIndexes.addAll([0, 4, 8]);
        endTimer();
        _updateScore(gameBoard[0]);
      });
    }

    // check diagonal
    if (gameBoard[6] == gameBoard[4] &&
        gameBoard[6] == gameBoard[2] &&
        gameBoard[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + gameBoard[6] + ' Wins!';
        matchedIndexes.addAll([6, 4, 2]);
        endTimer();
        _updateScore(gameBoard[6]);
      });
    }
    if (!winnerFound && areBoxesFull == 9) {
      setState(() {
        resultDeclaration = 'Nobody Wins!';
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      player1Score++;
    } else if (winner == 'X') {
      player2Score++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        gameBoard[i] = '';
      }
      resultDeclaration = '';
      matchedIndexes = [];
    });
    areBoxesFull = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: ColourScheme.accentColor,
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            onPressed: () {
              startTimer();
              _clearBoard();
              attempts++;
            },
            child: Text(
              attempts == 0 ? 'Start' : 'Play Again!',
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          );
  }
}