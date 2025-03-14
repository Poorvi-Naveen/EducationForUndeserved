import 'package:flutter/material.dart';
import 'dart:async';
import 'chat_screen.dart'; // Import ChatScreen (if you have it)
import 'courses_page.dart'; // Import CoursesPage
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AIMZY',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(key: Key('splash')),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({required Key key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()), // Navigate to MainScreen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/splash.jpeg",
            fit: BoxFit.cover,
          ),
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: FadeTransition(
                opacity: _animation,
                child: Image.asset(
                  "assets/logo.png",
                  height: 200,
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// MainScreen with HomeScreen Integrated
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(), // Integrated HomeScreen
    CoursesPage(), // Add CoursesPage to the list of screens
    ChatScreen(), // Navigate to ChatScreen - replace with your ChatScreen if available
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal.shade300,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Integrated HomeScreen (renamed from HomePage in your first code snippet)
class HomeScreen extends StatefulWidget { // Renamed from HomePage
  const HomeScreen({super.key}); // Added Key? key for consistency

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState(); // Renamed from _HomePageState
}

class _HomeScreenState extends State<HomeScreen> { // Renamed from _HomePageState
  bool _isLoadingCourses = true;
  final List<Map<String, dynamic>> _recommendedCourses = [
    {
      'subjectName': 'Math',
      'backgroundImage': 'assets/math_bg.png', // Replace with actual image paths
    },
    {
      'subjectName': 'Science',
      'backgroundImage': 'assets/science_bg.png',
    },
    {
      'subjectName': 'History',
      'backgroundImage': 'assets/history_bg.png',
    },
    {
      'subjectName': 'English',
      'backgroundImage': 'assets/english_bg.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Simulate loading courses
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoadingCourses = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF21a199),
              Color(0xFF308ca5),
              Color(0xFF083774),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40), // Add some space at the top
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "HELLO BUDDY !!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.account_circle, color: Colors.white, size: 40),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              SearchBar(),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(title: "Recommended Courses"),
                      _isLoadingCourses
                          ? Center(child: CircularProgressIndicator())
                          : _recommendedCourses.isEmpty
                              ? Center(child: Text("No recommended courses."))
                              : CourseRow(
                                  courses: _recommendedCourses,
                                  buttonText: "Join",
                                ),
                      SectionTitle(title: "Ongoing Courses"),
                      CourseRow(
                        courses: _recommendedCourses,
                        buttonText: "Continue",
                      ),
                      SectionTitle(title: "Offline Downloads"),
                      CourseRow(
                        courses: _recommendedCourses,
                        buttonText: "Download",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search courses...",
        prefixIcon: Icon(Icons.search, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CourseRow extends StatelessWidget {
  final List<Map<String, dynamic>> courses;
  final String buttonText;
  const CourseRow({super.key, required this.courses, required this.buttonText}); // buttonText is now optional and defaults to ""

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: courses
            .map((course) => CourseCard(
                  subjectName: course['subjectName'],
                  backgroundImage: course['backgroundImage'],
                  buttonText: buttonText, // Pass buttonText here
                ))
            .toList(),
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final String subjectName;
  final String backgroundImage;
  final String buttonText;
  const CourseCard({super.key, 
    required this.subjectName,
    required this.backgroundImage,
    required this.buttonText,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {
          _scale = 1 - _controller.value;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () {
        _controller.reverse();
      },
      child: Transform.scale(
        scale: _scale,
        child: Container(
          margin: EdgeInsets.all(8.0),
          width: 200,
          height: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.backgroundImage),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.subjectName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (widget.buttonText.isNotEmpty) // Conditionally show button if buttonText is provided
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text(widget.buttonText),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _profilePicController;
  late Animation<double> _profilePicAnimation;

  @override
  void initState() {
    super.initState();
    _profilePicController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _profilePicAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _profilePicController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _profilePicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _profilePicAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _profilePicAnimation.value,
                  child: child,
                );
              },
              child: Stack(
                alignment: Alignment.bottomRight,
              children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/profile_placeholder.png'),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "User Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 32),
            ProfileListItem(
              icon: Icons.settings,
              label: "Settings",
              onTap: () {},
            ),
            ProfileListItem(
              icon: Icons.badge,
              label: "Your Badges",
              onTap: () {},
            ),
            ProfileListItem(
              icon: Icons.book,
              label: "Your Courses",
              onTap: () {},
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text("Logout"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Implement Logout Logic here in real app
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ProfileListItem({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(label),
      onTap: onTap,
      trailing: Icon(Icons.chevron_right),
    );
  }
}