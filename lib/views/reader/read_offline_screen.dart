import 'package:flutter/material.dart';
import '../../database/models/offline_chapter.dart';

class ReadOfflineScreen extends StatelessWidget {
  final OfflineChapter chapter;

  const ReadOfflineScreen({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F151C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F151C),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chapter.storyName,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              "Chương ${chapter.orderNum}: ${chapter.chapterTitle}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              chapter.content,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
                height: 1.8
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "--- Hết chương (Offline) ---",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}