import 'package:flutter/material.dart';
import '../../../common_widget/custom_app_bar.dart';
import '../../../const/styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Privacy Policy",
        isBackButtonExist: true,
        centerTitle: true,
        titleStyle: headline(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Merchant Privacy & Regulations",
              style: headline(context)?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text(
              "Your information security is our topmost priority. Zesty Go architecture works securely under end-to-end encrypted restaurant token policies.\n\n"
              "1. Data Collection\nWe collect standard data strictly relevant to order transactions, menu structures, and payout accounts to secure transparent kitchen processing workflows.\n\n"
              "2. Location Monitoring\nBackground tracker maps operate strictly under food dispatch schedules to provide dynamic customer tracking statuses.\n\n"
              "3. Third-Party Sharing\nWe never sell or distribute custom configurations or metrics dataset info packages to structural unauthorized platforms.",
              style: bodyMedium(
                context,
              )?.copyWith(color: Colors.grey.shade700, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
