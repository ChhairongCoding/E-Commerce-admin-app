import 'package:flutter/material.dart';

class ShowTermsPrivacyScreen extends StatelessWidget {
  const ShowTermsPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Privacy Policy"),
        backgroundColor: Color(0xff012B43),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Terms and Conditions Title
            Text(
              "Terms and Conditions",
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Welcome to our app. Please read these Terms and Conditions carefully before using our services.",
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            _buildSectionTitle("1. Use of Service"),
            _buildSectionText(
              "You agree to use this app only for lawful purposes. Any unauthorized use may lead to termination of your access.",
            ),

            _buildSectionTitle("2. Intellectual Property"),
            _buildSectionText(
              "All contents, designs, and trademarks in this app are owned by us and protected under copyright law.",
            ),

            _buildSectionTitle("3. Limitation of Liability"),
            _buildSectionText(
              "We are not responsible for any damages resulting from the use or inability to use this application.",
            ),

            _buildSectionTitle("4. Modifications"),
            _buildSectionText(
              "We may modify these terms at any time. Continued use indicates your acceptance of changes.",
            ),

            const SizedBox(height: 30),
            Divider(color: Colors.grey.shade400, thickness: 1.2),
            const SizedBox(height: 30),

            // Privacy Policy Title
            Text(
              "Privacy Policy",
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Your privacy is important to us. This policy explains how we collect, use, and protect your information.",
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            _buildSectionTitle("1. Information Collection"),
            _buildSectionText(
              "We may collect your name, email address, and app usage data to improve the experience.",
            ),

            _buildSectionTitle("2. How We Use Data"),
            _buildSectionText(
              "Your data helps us provide better services, support, and security.",
            ),

            _buildSectionTitle("3. Data Protection"),
            _buildSectionText(
              "We take appropriate security measures to protect your personal data from unauthorized access.",
            ),

            _buildSectionTitle("4. Your Rights"),
            _buildSectionText(
              "You have the right to access, update, or delete your data by contacting us directly.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSectionText(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
    );
  }
}
