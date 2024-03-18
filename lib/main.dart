// import 'package:flutter/material.dart';

// void main() {
//   runApp(FlashcardApp());
// }

// class FlashcardApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flashcard App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => HomePage(),
//         '/add_flashcard': (context) => AddFlashcardPage(),
//       },
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Flashcard> flashcards = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flashcards'),
//       ),
//       body: Center(
//         child: flashcards.isEmpty
//             ? Text('No flashcards added yet')
//             : ListView.builder(
//                 itemCount: flashcards.length,
//                 itemBuilder: (context, index) {
//                   return FlashcardWidget(flashcard: flashcards[index]);
//                 },
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final newFlashcard = await Navigator.pushNamed(context, '/add_flashcard');
//           if (newFlashcard != null && newFlashcard is Flashcard) {
//             setState(() {
//               flashcards.add(newFlashcard);
//             });
//           }
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class AddFlashcardPage extends StatelessWidget {
//   final TextEditingController questionController = TextEditingController();
//   final TextEditingController answerController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Flashcard'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: questionController,
//               decoration: InputDecoration(labelText: 'Question'),
//             ),
//             SizedBox(height: 20.0),
//             TextField(
//               controller: answerController,
//               decoration: InputDecoration(labelText: 'Answer'),
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 if (questionController.text.isNotEmpty &&
//                     answerController.text.isNotEmpty) {
//                   Navigator.pop(
//                     context,
//                     Flashcard(
//                       question: questionController.text,
//                       answer: answerController.text,
//                     ),
//                   );
//                 }
//               },
//               child: Text('Save Flashcard'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Flashcard {
//   String question;
//   String answer;

//   Flashcard({required this.question, required this.answer});
// }

// class FlashcardWidget extends StatefulWidget {
//   final Flashcard flashcard;

//   FlashcardWidget({required this.flashcard});

//   @override
//   _FlashcardWidgetState createState() => _FlashcardWidgetState();
// }

// class _FlashcardWidgetState extends State<FlashcardWidget> {
//   bool _showQuestion = true;

//   void _flipCard() {
//     setState(() {
//       _showQuestion = !_showQuestion;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _flipCard,
//       child: Container(
//         padding: EdgeInsets.all(16.0),
//         margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 1,
//               blurRadius: 3,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             _showQuestion ? widget.flashcard.question : widget.flashcard.answer,
//             style: TextStyle(fontSize: 18.0),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/add_flashcard': (context) => AddFlashcardPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Flashcard> flashcards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
      ),
      body: Center(
        child: flashcards.isEmpty
            ? Text('No flashcards added yet')
            : ListView.builder(
                itemCount: flashcards.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(flashcards[index].question),
                    onDismissed: (direction) {
                      setState(() {
                        flashcards.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Flashcard deleted'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: FlashcardWidget(flashcard: flashcards[index]),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newFlashcard = await Navigator.pushNamed(context, '/add_flashcard');
          if (newFlashcard != null && newFlashcard is Flashcard) {
            setState(() {
              flashcards.add(newFlashcard);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddFlashcardPage extends StatelessWidget {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Flashcard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: answerController,
              decoration: InputDecoration(labelText: 'Answer'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (questionController.text.isNotEmpty &&
                    answerController.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Flashcard(
                      question: questionController.text,
                      answer: answerController.text,
                    ),
                  );
                }
              },
              child: Text('Save Flashcard'),
            ),
          ],
        ),
      ),
    );
  }
}

class Flashcard {
  String question;
  String answer;

  Flashcard({required this.question, required this.answer});
}

class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;

  FlashcardWidget({required this.flashcard});

  @override
  _FlashcardWidgetState createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool _showQuestion = true;

  void _flipCard() {
    setState(() {
      _showQuestion = !_showQuestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            _showQuestion ? widget.flashcard.question : widget.flashcard.answer,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
