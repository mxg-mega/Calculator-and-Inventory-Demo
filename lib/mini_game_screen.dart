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

  late Ticker _ticker;
  late DateTime _lastUpdateTime;
  bool _isMovingUp = false;
  bool _isMovingDown = false;
  bool _isMovingLeft = false;
  bool _isMovingRight = false;

  TextEditingController speedValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    speedValueController.text = speed.toString();
    _lastUpdateTime = DateTime.now();
    _ticker = Ticker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final currentTime = DateTime.now();
    final deltaTime = currentTime.difference(_lastUpdateTime).inMilliseconds / 1000.0; // in seconds
    _lastUpdateTime = currentTime;

    // Update position based on movement state and delta time
    setState(() {
      if (_isMovingUp) moveUp(deltaTime);
      if (_isMovingDown) moveDown(deltaTime);
      if (_isMovingLeft) moveLeft(deltaTime);
      if (_isMovingRight) moveRight(deltaTime);
    });
  }

  void moveUp(double deltaTime) {
    posY = (posY - speed * deltaTime).clamp(0, MediaQuery.of(context).size.height - boxSize);
  }

  void moveDown(double deltaTime) {
    posY = (posY + speed * deltaTime).clamp(0, MediaQuery.of(context).size.height - boxSize);
  }

  void moveLeft(double deltaTime) {
    posX = (posX - speed * deltaTime).clamp(0, MediaQuery.of(context).size.width - boxSize);
  }

  void moveRight(double deltaTime) {
    posX = (posX + speed * deltaTime).clamp(0, MediaQuery.of(context).size.width - boxSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
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
            onTapDown: (_) => setState(() => _isMovingUp = true),
            onTapUp: (_) => setState(() => _isMovingUp = false),
            onTapCancel: () => setState(() => _isMovingUp = false),
            child: ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.arrow_upward),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTapDown: (_) => setState(() => _isMovingLeft = true),
                onTapUp: (_) => setState(() => _isMovingLeft = false),
                onTapCancel: () => setState(() => _isMovingLeft = false),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.arrow_left),
                ),
              ),
              GestureDetector(
                onTapDown: (_) => setState(() => _isMovingRight = true),
                onTapUp: (_) => setState(() => _isMovingRight = false),
                onTapCancel: () => setState(() => _isMovingRight = false),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.arrow_right),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTapDown: (_) => setState(() => _isMovingDown = true),
            onTapUp: (_) => setState(() => _isMovingDown = false),
            onTapCancel: () => setState(() => _isMovingDown = false),
            child: ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.arrow_downward),
            ),
          ),
          SizedBox(
            height: 70,
            width: 80,
            child: TextField(
              decoration: const InputDecoration(helperText: "Speed"),
              controller: speedValueController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white70),
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
    _ticker.dispose();
    super.dispose();
  }
}
