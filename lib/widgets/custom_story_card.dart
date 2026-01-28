import 'package:flutter/material.dart';
import '../models/dto/api_dto.dart';

class CustomStoryCard extends StatelessWidget {
  final StorySummary story;
  final VoidCallback? onTap;
  final VoidCallback? onPlayTap;

  const CustomStoryCard({
    super.key,
    required this.story,
    this.onTap,
    this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    const String imageBaseUrl = "http://notifications-rebel-lying-porcelain.trycloudflare.com/assets/images/poster/stories/";
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF101922),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
              "$imageBaseUrl${story.coverImagePath}" ?? "https://www.shutterstock.com/shutterstock/videos/1039407446/thumb/1.jpg?ip=x480",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.grey, width: 80, height: 80, child: const Icon(Icons.book)),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    story.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'M. Mystery',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'CH. ${story.chapterCount ?? 0} ADDED',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '• 2h ago',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: onPlayTap,
              icon: const Icon(Icons.play_circle_fill, size: 48, color: Color(0xFF1A73E8)),
            ),
          ],
        ),
      ),
    );
  }
}