import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController rollNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = "";
  bool isLoading = false;

  Future<void> login() async {
    final url = Uri.parse("http://localhost:5000/api/student/login");

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "rollNumber": rollNumberController.text,
          "password": passwordController.text
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HubCenter(student: data['student']),
          ),
        );
      } else {
        setState(() {
          errorMessage = data['message'] ?? 'Invalid credentials';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error connecting to server!";
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 80, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                "Student Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey[700]),
              ),
              SizedBox(height: 20),
              TextField(
                controller: rollNumberController,
                decoration: InputDecoration(
                  labelText: "Roll Number",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),
              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 14)),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.blue,
                ),
                child: Text("Login", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
