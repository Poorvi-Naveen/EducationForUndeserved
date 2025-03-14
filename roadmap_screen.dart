// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'roadmap_data.dart'; // Ensure this file has the roadmap data

class RoadmapScreen extends StatelessWidget {
  final String courseName;

  const RoadmapScreen({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    List<String>? steps = roadmapSteps[courseName]; // Fetch roadmap steps

    return Scaffold(
      appBar: AppBar(title: Text('Roadmap for $courseName')),
      body: steps != null
          ? ListView.builder(
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(steps[index]),
                    onTap: () {
                      // Navigate to lesson screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonScreen(lessonTitle: steps[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : const Center(child: Text('No roadmap available')),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learning App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Nunito',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
  final int _streak = 15;
  final int _gems = 1250;
  final int _hearts = 5;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: const NetworkImage('https://via.placeholder.com/150'),
              radius: 18,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
                Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.orange, size: 16),
                    Text(
                      '$_streak',
                      style: const TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.diamond, color: Colors.red, size: 16),
                    Text(
                      '$_gems',
                      style: const TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.favorite, color: Colors.red, size: 16),
                    Text(
                      '$_hearts',
                      style: const TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.green,
          tabs: const [
            Tab(text: 'LEARN'),
            Tab(text: 'PRACTICE'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLearnTab(),
          _buildPracticeTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Stories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_outlined),
            activeIcon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
        ],
      ),
    );
  }

  Widget _buildLearnTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildLanguageSwitch(),
          const SizedBox(height: 24),
          _buildLearningPath(),
          const SizedBox(height: 24),
          _buildDailyQuest(),
          const SizedBox(height: 24),
          _buildStreakCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPracticeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Practice Skills',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPracticeGrid(),
        ],
      ),
    );
  }

  Widget _buildLanguageSwitch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              'ES',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Spanish',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.add, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  'Add new',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningPath() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Unit 1: Basics',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildLessonPath(),
        ],
      ),
    );
  }

  Widget _buildLessonPath() {
    return Column(
      children: [
        _buildLesson(
          title: 'Basics 1',
          icon: Icons.outlet_outlined,
          color: Colors.amber,
          isCompleted: true,
        ),
        _buildPathConnector(),
        _buildLesson(
          title: 'Phrases',
          icon: Icons.chat_bubble_outlined,
          color: Colors.purple,
          isCompleted: true,
        ),
        _buildPathConnector(),
        _buildLesson(
          title: 'Basics 2',
          icon: Icons.grid_view_outlined,
          color: Colors.green,
          isCompleted: false,
          isCurrent: true,
        ),
        _buildPathConnector(),
        _buildLesson(
          title: 'Food',
          icon: Icons.restaurant_outlined,
          color: Colors.orange,
          isCompleted: false,
          isLocked: true,
        ),
        _buildPathConnector(),
        _buildLesson(
          title: 'Animals',
          icon: Icons.pets_outlined,
          color: Colors.blue,
          isCompleted: false,
          isLocked: true,
        ),
      ],
    );
  }

  Widget _buildLesson({
    required String title,
    required IconData icon,
    required Color color,
    bool isCompleted = false,
    bool isCurrent = false,
    bool isLocked = false,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isLocked ? Colors.grey : color,
              shape: BoxShape.circle,
              border: isCurrent
                  ? Border.all(color: Colors.green, width: 3)
                  : null,
            ),
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isLocked ? Colors.grey : Colors.black87,
                ),
              ),
              Text(
                isCompleted
                    ? 'Completed'
                    : isCurrent
                        ? 'Start lesson'
                        : 'Locked',
                style: TextStyle(
                  fontSize: 14,
                  color: isCompleted
                      ? Colors.green
                      : isCurrent
                          ? Colors.blue
                          : Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (isCompleted)
            const Icon(Icons.star, color: Colors.amber)
          else if (isLocked)
            const Icon(Icons.lock, color: Colors.grey)
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'START',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPathConnector() {
    return Container(
      width: 2,
      height: 24,
      margin: const EdgeInsets.only(left: 29),
      color: Colors.grey.shade300,
    );
  }

  Widget _buildDailyQuest() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: Colors.green),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Daily Quest',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Complete 3 lessons to earn 50 gems',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'GO',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
  
  _buildStreakCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_fire_department, color: Colors.orange),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Streak Bonus',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Keep up the good work to earn more gems',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'CLAIM',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
  
  _buildPracticeGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildPracticeCard(
          title: 'Vocabulary',
          icon: Icons.book_outlined,
          color: Colors.blue,
        ),
        _buildPracticeCard(
          title: 'Grammar',
          icon: Icons.menu_book_outlined,
          color: Colors.green,
        ),
        _buildPracticeCard(
          title: 'Listening',
          icon: Icons.hearing_outlined,
          color: Colors.orange,
        ),
        _buildPracticeCard(
          title: 'Speaking',
          icon: Icons.mic_outlined,
          color: Colors.purple,
        ),
      ],
    );
  }
  
  _buildPracticeCard({required String title, required IconData icon, required MaterialColor color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color.shade900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Practice your $title skills',
            style: TextStyle(
              fontSize: 14,
              color: color.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
// Dummy LessonScreen (Replace with actual implementation)
class LessonScreen extends StatelessWidget {
  final String lessonTitle;

  const LessonScreen({super.key, required this.lessonTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lessonTitle)),
      body: Center(child: Text('Lesson content for $lessonTitle')),
    );
  }
}