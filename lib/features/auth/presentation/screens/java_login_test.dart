import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController(text: "harsh.singh@company.com");
  final passwordCtrl = TextEditingController(text: "RECRUIT@2025");

  String responseText = "";
  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      isLoading = true;
      responseText = "⌛ Loading...";
    });

    final uri = Uri.parse("http://192.168.1.3:8080/api/web-users/login");

    final body = {
      "email": emailCtrl.text.trim(),
      "password": passwordCtrl.text.trim(),
    };

    try {
      final res = await http.post(
        uri,
        headers: {"X-Tenant": "abc", "Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      setState(() {
        if (res.statusCode == 200) {
          final json = jsonDecode(res.body);
          // 🔥 Show only key-value formatted
          responseText = json.entries
              .map((e) => "${e.key}: ${e.value}")
              .join("\n");
        } else {
          responseText = "❌ Error: ${res.statusCode}\n${res.body}";
        }
      });
    } catch (e) {
      setState(() {
        responseText = "❌ Exception: $e";
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  void clearResponse() {
    setState(() => responseText = "");
  }

  void reload() {
    if (emailCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty) {
      login(); // direct re-login API call
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Test")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordCtrl,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: false,
            ),
            const SizedBox(height: 20),

            // 🔥 Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : login,
                    child: const Text("LOGIN"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : reload,
                    child: const Text("RELOAD"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: isLoading ? null : clearResponse,
                    child: const Text("CLEAR"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    responseText.isEmpty
                        ? "Response will appear here..."
                        : responseText,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
