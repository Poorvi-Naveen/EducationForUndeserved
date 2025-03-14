import 'package:flutter/material.dart';

class RoadmapPage extends StatelessWidget {
  final String subject;

  RoadmapPage({super.key, required this.subject});

  final Map<String, List<String>> roadmaps = {
    "Mathematics": ["Basics of Numbers", "Algebra", "Geometry", "Trigonometry", "Calculus"],
    "Science": ["Introduction to Physics", "Basic Chemistry", "Biology Fundamentals", "Experiments & Applications"],
    "History": ["Ancient Civilizations", "Medieval History", "Modern History", "World Wars"],
    "English": ["Grammar Basics", "Creative Writing", "Literature", "Advanced Vocabulary"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$subject Roadmap"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(roadmaps[subject]?.length ?? 0, (index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: index % 2 == 0
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      CustomPaint(
                        painter: LinePainter(index: index),
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          child: Card(
                            color: const Color(0xFF1976D2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: Colors.white, size: 40),
                                    SizedBox(height: 10),
                                    Text(
                                      roadmaps[subject]![index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (index < roadmaps[subject]!.length - 1)
                    CustomPaint(
                      painter: LinePainter(index: index, isVertical: true),
                      child: Container(
                        height: 50,
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final int index;
  final bool isVertical;

  LinePainter({required this.index, this.isVertical = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    if (isVertical) {
      canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        paint,
      );
    } else {
      if (index % 2 == 0) {
        canvas.drawLine(
          Offset(size.width, size.height / 2),
          Offset(size.width + 24, size.height / 2),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(-24, size.height / 2),
          Offset(0, size.height / 2),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

