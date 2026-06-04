import 'package:flutter/material.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: CustomAppBar(
        title: "Help & Support",
        isBackButtonExist: true,
        centerTitle: true,
        titleStyle: headline(context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSupportCard(
            icon: Icons.email_rounded,
            title: "Email Us",
            value: "support@zestygo.com",
          ),
          _buildSupportCard(
            icon: Icons.phone_android_rounded,
            title: "Call Helpline",
            value: "+880 1234-567890",
          ),
          _buildSupportCard(
            icon: Icons.support_agent_rounded,
            title: "Live Chat Support",
            value: "Available 24/7 inside Merchant App",
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppConstColor.primaryColor.withOpacity(0.1),
            child: Icon(icon, color: AppConstColor.primaryColor),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
