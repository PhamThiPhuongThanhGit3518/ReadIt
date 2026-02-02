import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/dto/api_dto.dart';

class CustomPopularStoryCard extends StatelessWidget {
  final StorySummary story;
  final VoidCallback onTap;

  const CustomPopularStoryCard({super.key, required this.story, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const String imageBaseUrl = "https://api.phongdaynai.id.vn/assets/images/poster/stories/";
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWith * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "$imageBaseUrl${story.coverImagePath}",
                width: screenWith * 0.35,
                height: screenHeight * (1/5),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              story.title,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${story.viewCount} reads',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
