import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RoadmapCourses extends StatefulWidget {
  const RoadmapCourses({super.key});

  @override
  RoadmapCoursesState createState() => RoadmapCoursesState();
}

class RoadmapCoursesState extends State<RoadmapCourses> {
  int _selectedCourseIndex = 0;
  final List<String> _courses = ['SQL', 'Python', 'JavaScript'];
  final Map<String, List<Map<String, dynamic>>> _courseTopics = {
    'SQL': [
      {'title': 'Introduction to SQL', 'completed': true},
      {'title': 'Basic Queries', 'completed': true},
      {'title': 'Joins & Relationships', 'completed': true},
      {'title': 'Stored Procedures', 'completed': false},
    ],
    'Python': [
      {'title': 'Python Basics', 'completed': true},
      {'title': 'Data Types & Variables', 'completed': true},
      {'title': 'Functions & Loops', 'completed': false},
    ],
    'JavaScript': [
      {'title': 'JS Fundamentals', 'completed': true},
      {'title': 'DOM Manipulation', 'completed': false},
      {'title': 'Asynchronous JS', 'completed': false},
    ],
  };

  @override
  Widget build(BuildContext context) {
    String selectedCourse = _courses[_selectedCourseIndex];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: DropdownButton<String>(
          value: selectedCourse,
          icon: Icon(Icons.arrow_drop_down, color: Colors.black),
          style: TextStyle(
            color: const Color.fromARGB(255, 248, 246, 246),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          underline: Container(height: 0),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCourseIndex = _courses.indexOf(newValue!);
            });
          },
          items:
              _courses.map<DropdownMenuItem<String>>((String course) {
                return DropdownMenuItem<String>(
                  value: course,
                  child: Text(course),
                );
              }).toList(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF7F7FD5),
                    Color(0xFF86A8E7),
                    Color(0xFF91EAE4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Progress',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: 30.0,
                    lineWidth: 5.0,
                    percent: 0.62,
                    center: Text(
                      '62%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    progressColor: Colors.white,
                    backgroundColor: Colors.white.withAlpha(51),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:
                      _courseTopics[selectedCourse]!
                          .map(
                            (topic) => GestureDetector(
                              onTap: () => _navigateToRoadmap(topic['title']),
                              child: _buildCourseItem(
                                topic['completed']
                                    ? Icons.check_circle
                                    : Icons.play_circle_fill,
                                topic['title'],
                                topic['completed'],
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseItem(IconData icon, String title, bool completed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color:
              completed ? Colors.deepPurpleAccent.withAlpha(51) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: completed ? Colors.deepPurple : Colors.grey,
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: completed ? const Color.fromARGB(221, 255, 255, 255) : Colors.grey,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _navigateToRoadmap(String topicTitle) {
    final roadmapData = {
      'Introduction to SQL': [
        'What is SQL?',
        'SQL Syntax',
        'First Query',
        'Data Types',
        'Constraints',
        'Basic Joins',
        'Practice',
      ],
      'Python Basics': [
        'Hello, Python!',
        'Variables & Data Types',
        'Operators',
        'Control Flow',
        'Loops',
        'Functions',
        'Modules',
      ],
      // Add more topics with their respective steps
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => RoadmapScreen(
              topicTitle: topicTitle,
              steps:
                  roadmapData[topicTitle] ??
                  ['Step 1', 'Step 2', 'Step 3'], // Default steps if not found
            ),
      ),
    );
  }
}

class RoadmapScreen extends StatelessWidget {
  final String topicTitle;

  const RoadmapScreen({
    super.key,
    required this.topicTitle,
    required List<String> steps,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(topicTitle)),
      body: Center(child: Text("Roadmap for $topicTitle")),
    );
  }
}
