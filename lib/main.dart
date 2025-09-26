import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: MyApp(),
    ),
  );
}

// Mood Model
class MoodModel with ChangeNotifier {
  String _currentMood = 'assets/happy.png';
  Color _backgroundColor = Colors.yellow;

  // Counters
  final Map<String, int> _moodCounts = {
    'happy': 0,
    'sad': 0,
    'excited': 0,
  };

  String get currentMood => _currentMood;
  Color get backgroundColor => _backgroundColor;
  Map<String, int> get moodCounts => _moodCounts;

  void setHappy() {
    _currentMood = 'assets/happy.png';
    _backgroundColor = Colors.yellow;
    _moodCounts['happy'] = (_moodCounts['happy'] ?? 0) + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'assets/sad.png';
    _backgroundColor = Colors.blue;
    _moodCounts['sad'] = (_moodCounts['sad'] ?? 0) + 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'assets/excited.png';
    _backgroundColor = Colors.orange;
    _moodCounts['excited'] = (_moodCounts['excited'] ?? 0) + 1;
    notifyListeners();
  }
}

// Main App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Scaffold(
          backgroundColor: moodModel.backgroundColor,
          appBar: AppBar(title: Text('Mood Toggle Challenge')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('How are you feeling?', style: TextStyle(fontSize: 24)),
                SizedBox(height: 30),
                MoodDisplay(),
                SizedBox(height: 50),
                MoodButtons(),
                SizedBox(height: 40),
                MoodCounter(), // New counter widget
              ],
            ),
          ),
        );
      },
    );
  }
}

// Displays the current mood image
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Image.asset(
          moodModel.currentMood,
          height: 150,
          width: 150,
        );
      },
    );
  }
}

// Mood Buttons
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setHappy();
          },
          child: Text('Happy 😊'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setSad();
          },
          child: Text('Sad 😢'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setExcited();
          },
          child: Text('Excited 🎉'),
        ),
      ],
    );
  }
}

// Mood Counter Widget
class MoodCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Column(
          children: [
            Text(
              "Mood Counters",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("😊 Happy: ${moodModel.moodCounts['happy']}"),
                Text("😢 Sad: ${moodModel.moodCounts['sad']}"),
                Text("🎉 Excited: ${moodModel.moodCounts['excited']}"),
              ],
            ),
          ],
        );
      },
    );
  }
}
