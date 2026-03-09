import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/custom_request_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/widgets/custom_summary_item.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Request History", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Track your blood requests", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            // ----------Summary Row--------------
            Row(
              children: [
                CustomSummaryItem(count: "42",label:  "Fulfilled", bg: const Color(0xFFE8F5E9),text:  const Color(0xFF2E7D32)),
                const SizedBox(width: 12),
                CustomSummaryItem(count: "3", label: "Active", bg: const Color(0xFFFFF3E0), text: const Color(0xFFEF6C00)),
                const SizedBox(width: 12),
                CustomSummaryItem(count: "2", label: "Cancelled",bg:  const Color(0xFFFFEBEE), text: const Color(0xFFC62828)),
              ],
            ),

            const SizedBox(height: 32),
            const Text("Recent Requests", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // ---------Request List-------------
            CustomRequestCard(
              type: "O+ Blood Request",
              units: 3,
              date: "Sep 28, 2024",
              priority: "Critical",
              status: "Fulfilled",
              color: Colors.green,
            ),
            CustomRequestCard(
              type: "A- Blood Request",
              units: 2,
              date: "Sep 15, 2024",
              priority: "High",
              status: "Fulfilled",
              color: Colors.green,
            ),
            CustomRequestCard(
              type: "B+ Blood Request",
              units: 4,
              date: "Mar 20, 2024",
              priority: "High",
              status: "Fulfilled",
              color: Colors.green,
            ),CustomRequestCard(
              type: "A+ Blood Request",
              units: 1,
              date: "Jun 3, 2024",
              priority: "Critical",
              status: "Cancelled",
              color: Colors.red,
            ),CustomRequestCard(
              type: "AB- Blood Request",
              units: 3,
              date: "Feb 13, 2024",
              priority: "Critical",
              status: "Fulfilled",
              color: Colors.green,
            ),CustomRequestCard(
              type: "O- Blood Request",
              units: 2,
              date: "Apr 23, 2024",
              priority: "Low",
              status: "Cancelled",
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
  }