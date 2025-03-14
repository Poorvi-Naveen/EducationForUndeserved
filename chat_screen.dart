import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  final String apiKey = 'AIzaSyDO8uuSRqnt6i8DDE5AfTeOLEniZNObV54'; // Replace with your actual API key
  final String apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';

  // Define theme colors based on the image, including gradient colors
  Color gradientColorTop = const Color(0xFF308ca5);   // Top color of the gradient (darker blue)
  Color gradientColorBottom = const Color(0xFF083774); // Bottom color of the gradient (lighter blue)
  Color appBarColor = const Color(0xFF1976D2);         // Slightly lighter blue for AppBar
  Color messageBubbleUser = const Color(0xFF29B6F6);     // Light blue for user messages
  Color messageBubbleBot = const Color(0xFFE0E0E0);     // Light grey for bot messages
  Color textColorPrimary = Colors.white;             // White for primary text on blue backgrounds
  Color textColorSecondary = Colors.black;           // Black for secondary text on light backgrounds


  Future<void> sendMessage(String message) async {
    setState(() {
      _messages.add({"role": "user", "text": message});
    });

    try {
      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'), // Construct the API URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": message},
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        // Extract response text
        String botResponse = "No response";
        if (decodedResponse != null &&
            decodedResponse['candidates'] != null &&
            decodedResponse['candidates'].isNotEmpty &&
            decodedResponse['candidates'][0]['content'] != null &&
            decodedResponse['candidates'][0]['content']['parts'] != null &&
            decodedResponse['candidates'][0]['content']['parts'].isNotEmpty &&
            decodedResponse['candidates'][0]['content']['parts'][0]['text'] != null) {
          botResponse = decodedResponse['candidates'][0]['content']['parts'][0]['text'];
        }

        setState(() {
          _messages.add({"role": "bot", "text": botResponse});
        });
      } else {
        setState(() {
          _messages.add({
            "role": "bot",
            "text": "Error: API request failed with status code ${response.statusCode}",
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          "role": "bot",
          "text": "Error: Unable to fetch response. $e",
        });
      });
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Make Scaffold background transparent to show gradient
      appBar: AppBar(
        title: const Text("Chat with AI"),
        backgroundColor: appBarColor,
        titleTextStyle: TextStyle(color: textColorPrimary, fontSize: 20),
        iconTheme: IconThemeData(color: textColorPrimary),
      ),
      body: Stack(
        children: [
          // Gradient Background Container - Placed first to be behind other widgets
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, // Start gradient from the top
                  end: Alignment.bottomCenter, // End gradient at the bottom
                  colors: [Color(0xFF21a199), gradientColorTop, gradientColorBottom], // Use defined gradient colors
                ),
              ),
            ),
          ),
          Positioned.fill( // Image fills the entire background
            child: Opacity( // Optional: Adjust opacity to make doodles subtle
              opacity: 0.5, // Example opacity, adjust as needed
              child: Image.asset(
                "assets/bg_doodle.jpeg", // Path to your doodle image asset
                fit: BoxFit.cover, // Cover the entire background
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    bool isUser = msg["role"] == "user";
                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isUser ? messageBubbleUser : messageBubbleBot,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          msg["text"]!,
                          style: TextStyle(color: isUser ? textColorPrimary : textColorSecondary),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Ask something...",
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: appBarColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400] ?? Colors.grey),
                          ),
                        ),
                        style: TextStyle(color: textColorSecondary),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: textColorPrimary),
                      onPressed: () {
                        if (_controller.text.trim().isNotEmpty) {
                          sendMessage(_controller.text.trim());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}