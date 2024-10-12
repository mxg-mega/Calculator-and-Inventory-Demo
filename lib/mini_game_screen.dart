import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MiniGameScreen extends StatefulWidget {
  const MiniGameScreen({super.key});

  @override
  State<MiniGameScreen> createState() => _MiniGameScreenState();
}

class _MiniGameScreenState extends State<MiniGameScreen> {
  double posX = 100;
  double posY = 100;
  double speed = 10;

  double boxSize = 40; // Size of the moving box
  Timer? _movementTimer;

  late Ticker _ticker;
  late DateTime _lastUpdateTime;

  TextEditingController speedValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the speed in the TextField
    speedValueController.text = speed.toString();

    // Initialize ticker for delta time
    _lastUpdateTime = DateTime.now();
    _ticker = Ticker(_onTick)..start();
  }

  // Called on each frame update
  void _onTick(Duration elapsed) {
    final currentTime = DateTime.now();
    final deltaTime = currentTime.difference(_lastUpdateTime).inMilliseconds / 1000.0; // in seconds
    _lastUpdateTime = currentTime;

    // Move box based on delta time
    setState(() {
      if (_isMovingUp) {
        moveUp(deltaTime);
      }
      if (_isMovingDown) {
        moveDown(deltaTime);
      }
      if (_isMovingLeft) {
        moveLeft(deltaTime);
      }
      if (_isMovingRight) {
        moveRight(deltaTime);
      }
    });
  }

  bool _isMovingUp = false;
  bool _isMovingDown = false;
  bool _isMovingLeft = false;
  bool _isMovingRight = false;

  void moveUp(double deltaTime) {
    setState(() {
      double deltaMovement = speed * deltaTime;
      posY = (posY - deltaMovement).clamp(0, MediaQuery.of(context).size.height - boxSize);
    });
  }

  void moveDown(double deltaTime) {
    setState(() {
      double deltaMovement = speed * deltaTime;
      posY = (posY + deltaMovement).clamp(0, MediaQuery.of(context).size.height - boxSize);
    });
  }

  void moveLeft(double deltaTime) {
    setState(() {
      double deltaMovement = speed * deltaTime;
      posX = (posX - deltaMovement).clamp(0, MediaQuery.of(context).size.width - boxSize);
    });
  }

  void moveRight(double deltaTime) {
    setState(() {
      double deltaMovement = speed * deltaTime;
      posX = (posX + deltaMovement).clamp(0, MediaQuery.of(context).size.width - boxSize);
    });
  }

  void startMoving(Function moveFunction) {
    stopMoving(); // Stop any previous timer

    // Start a timer to move continuously
    _movementTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        moveFunction();
      });
    });
  }

  void stopMoving() {
    // Cancel the timer if it's running
    if (_movementTimer != null) {
      _movementTimer!.cancel();
      _movementTimer = null;
    }
  }
/*
  void moveUp(double screenHeight) {
    setState(() {
      if (posY - speed >= 0) {
        posY -= speed; // Prevent moving beyond the top of the screen
      } else {
        posY = 0; // Stay at the top boundary
      }
    });
  }

  void moveDown(double screenHeight) {
    setState(() {
      if (posY + boxSize + speed <= screenHeight) {
        posY += speed; // Prevent moving beyond the bottom of the screen
      } else {
        posY = screenHeight - boxSize; // Stay at the bottom boundary
      }
    });
  }

  void moveLeft(double screenWidth) {
    setState(() {
      if (posX - speed >= 0) {
        posX -= speed; // Prevent moving beyond the left of the screen
      } else {
        posX = 0; // Stay at the left boundary
      }
    });
  }

  void moveRight(double screenWidth) {
    setState(() {
      if (posX + boxSize + speed <= screenWidth) {
        posX += speed; // Prevent moving beyond the right of the screen
      } else {
        posX = screenWidth - boxSize; // Stay at the right boundary
      }
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("MiniGame"),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: posX,
            top: posY,
            child: Container(
              height: boxSize,
              width: boxSize,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onLongPressStart: (_) => startMoving(() => moveUp(screenHeight)),
            onLongPressEnd: (_) => stopMoving(),
            onTapDown: (_) => setState(() => _isMovingUp = true),
            onTapUp: (_) => setState(() => _isMovingUp = false),
            onTapCancel: () => setState(() => _isMovingUp = false),
            child: ElevatedButton(
              onPressed: () => moveUp(0.1),
              child: const Icon(Icons.arrow_upward),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onLongPressStart: (_) => startMoving(() => moveLeft(screenWidth)),
                onLongPressEnd: (_) => stopMoving(),
                onTapDown: (_) => setState(() => _isMovingLeft = true),
                onTapUp: (_) => setState(() => _isMovingLeft = false),
                onTapCancel: () => setState(() => _isMovingLeft = false),
                child: ElevatedButton(
                  onPressed: () => moveLeft(0.1),
                  child: const Icon(Icons.arrow_left),
                ),
              ),
              GestureDetector(
                onLongPressStart: (_) => startMoving(() => moveRight(screenWidth)),
                onLongPressEnd: (_) => stopMoving(),
                onTapDown: (_) => setState(() => _isMovingRight = true),
                onTapUp: (_) => setState(() => _isMovingRight = false),
                onTapCancel: () => setState(() => _isMovingRight = false),
                child: ElevatedButton(
                  onPressed: () => moveRight(0.1),
                  child: const Icon(Icons.arrow_right),
                ),
              ),
            ],
          ),
          GestureDetector(
            onLongPressStart: (_) => startMoving(() => moveDown(screenHeight)),
            onLongPressEnd: (_) => stopMoving(),
            onTapDown: (_) => setState(() => _isMovingDown = true),
            onTapUp: (_) => setState(() => _isMovingDown = false),
            onTapCancel: () => setState(() => _isMovingDown = false),
            child: ElevatedButton(
              onPressed: () => moveDown(0.1),
              child: const Icon(Icons.arrow_downward),
            ),
          ),
          SizedBox(
            height: 70,
            width: 80,
            child: TextField(
              decoration: const InputDecoration(
                helperText: "Speed",
              ),
              controller: speedValueController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.white70,
              ),
              onChanged: (value) {
                setState(() {
                  speed = double.tryParse(value) ?? 10;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the timer when the widget is disposed
    stopMoving();
    _ticker.dispose();
    super.dispose();
  }
}
