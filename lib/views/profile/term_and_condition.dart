import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                '1. Introduction',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Welcome to our application. By accessing or using our service, you agree to be bound by these terms and conditions.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '2. User Responsibilities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Users are expected to use the application in a manner that is lawful and respectful of others. Any form of abuse or harassment is strictly prohibited.',
                style: TextStyle(fontSize: 16),
              ),
              // Tambahkan lebih banyak bagian sesuai kebutuhan
              SizedBox(height: 16),
              Text(
                '3. Privacy Policy',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your personal information.',
                style: TextStyle(fontSize: 16),
              ),
              // Tambahkan lebih banyak bagian sesuai kebutuhan
              SizedBox(height: 16),
              Text(
                '4. Changes to Terms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We reserve the right to modify these terms at any time. Users will be notified of any changes, and continued use of the service constitutes acceptance of the new terms.',
                style: TextStyle(fontSize: 16),
              ),
              // Tambahkan lebih banyak bagian sesuai kebutuhan
              SizedBox(height: 16),
              Text(
                '5. Contact Us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'If you have any questions or concerns about these terms, please contact us at support@example.com.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
