import 'package:flutter/material.dart';
import '../models/dto/api_dto.dart';

class CustomHistoryStoryCard extends StatelessWidget {
  final HistoryItem story;
  final VoidCallback? onTap;
  final VoidCallback? onPlayTap;

  const CustomHistoryStoryCard({
    super.key,
    required this.story,
    this.onTap,
    this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    const String imageBaseUrl = "https://api.phongdaynai.id.vn/assets/images/poster/stories/";
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
                story.coverImagePath != null && story.coverImagePath!.isNotEmpty
                    ? "$imageBaseUrl${story.coverImagePath}"
                    : "https://img.idesign.vn/2018/10/23/id-loading-1.gif",
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
                    story.storyTitle,
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
                        'Last read chapter ${story.lastChapterOrder}: \n${story.lastChapterTitle}',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: onPlayTap,
              icon: const Icon(Icons.play_circle_fill, size: 40, color: Color(0xFF1A73E8)),
            ),
          ],
        ),
      ),
    );
  }
}