import 'package:flutter/material.dart';

class HubCenter extends StatefulWidget {
  final Map<String, dynamic> student;

  HubCenter({required this.student});

  @override
  _HubCenterState createState() => _HubCenterState();
}

class _HubCenterState extends State<HubCenter> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    String name = widget.student['name'] ?? 'Unknown';
    String department = widget.student['department'] ?? 'N/A';
    String year = widget.student['year'] ?? 'N/A';
    int age = widget.student['age'] ?? 0;
    int attendance = widget.student['attendance'] ?? 0;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Color(0xFFfff8e5),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 310,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(70)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/logo.png", height: 200, width: 200),
                    Text(
                      '"Collaborate. Learn. Achieve."',
                      style: TextStyle(fontSize: 15, fontFamily: 'Reggae One', color: Colors.white),
                    ),
                    SizedBox(height: 13),
                    Container(
                      width: 232,
                      height: 43.54,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFC107),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Hello, $name!',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Rammetto One', color: Color(0xFF0a0a0a)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Container(
                width: 290,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    SizedBox(height: 15),
                    InfoBox(label: 'Age', value: '$age', isDarkMode: isDarkMode),
                    InfoBox(label: 'Department', value: department, isDarkMode: isDarkMode),
                    InfoBox(label: 'Year', value: year, isDarkMode: isDarkMode),
                    InfoBox(label: 'Attendance', value: '$attendance%', isDarkMode: isDarkMode),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Dark Mode', style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black)),
                        Switch(
                          value: isDarkMode,
                          onChanged: (value) {
                            setState(() {
                              isDarkMode = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(text: 'About Me', icon: Icons.person, onPressed: () => Navigator.pushNamed(context, '/about')),
                  SizedBox(width: 10),
                  CustomIconButton(text: 'Contact', icon: Icons.contact_mail, onPressed: () => Navigator.pushNamed(context, '/chatgpt')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String label;
  final String value;
  final bool isDarkMode;
  InfoBox({required this.label, required this.value, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
          Text(value, style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black)),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  CustomIconButton({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: Size(128, 42),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Poppins', color: Colors.white)),
    );
  }
}
