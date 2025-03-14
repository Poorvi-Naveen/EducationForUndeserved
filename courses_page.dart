import 'package:flutter/material.dart';
import 'roadmap_page.dart'; // Import the roadmap page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoursesPage(),
    );
  }
}

class CoursesPage extends StatelessWidget {
  final List<Map<String, dynamic>> subjects = [
    {"name": "Mathematics", "icon": Icons.calculate, "color": Colors.blue},
    {"name": "Science", "icon": Icons.science, "color": Colors.green},
    {"name": "History", "icon": Icons.history_edu, "color": Colors.red},
    {"name": "English", "icon": Icons.menu_book, "color": Colors.purple},
  ];

  CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoadmapPage(subject: subjects[index]["name"]),
                  ),
                );
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: subjects[index]["color"],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(subjects[index]["icon"], size: 50, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      subjects[index]["name"],
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}