import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = List.generate(9, (index) => '');
  String turn = 'X';
  String winner = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              winner.isNotEmpty ? 'Winner: $winner' : 'Turn: $turn',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: List.generate(9, (index) {
                return GestureDetector(
                  onTap: () => _tapped(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        items[index],
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _reset,
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.white,
                  side: BorderSide(color: Colors.white),
                ),
                child:
                    const Text('Reset', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(index) {
    if (winner.isNotEmpty || items[index].isNotEmpty) {
      return;
    }

    setState(() {
      items[index] = turn;
      turn = turn == 'X' ? 'O' : 'X';
    });

    _checkWinner();
  }

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (items[i].isNotEmpty &&
          items[i] == items[i + 1] &&
          items[i] == items[i + 2]) {
        setState(() {
          winner = items[i];
        });
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (items[i].isNotEmpty &&
          items[i] == items[i + 3] &&
          items[i] == items[i + 6]) {
        setState(() {
          winner = items[i];
        });
        return;
      }
    }

    // Check diagonals
    if (items[0].isNotEmpty && items[0] == items[4] && items[0] == items[8]) {
      setState(() {
        winner = items[0];
      });
      return;
    }

    if (items[2].isNotEmpty && items[2] == items[4] && items[2] == items[6]) {
      setState(() {
        winner = items[2];
      });
      return;
    }

    // Check for tie
    if (!items.contains('')) {
      setState(() {
        winner = 'Tie';
      });
    }
  }

  void _reset() {
    setState(() {
      items = List.generate(9, (index) => '');
      turn = 'X';
      winner = '';
    });
  }
}
