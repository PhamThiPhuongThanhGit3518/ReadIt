import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/dto/api_dto.dart';

class CustomPublishWorkCard extends StatefulWidget {
  final StorySummary story;
  final VoidCallback onEditStory;
  final VoidCallback onDeleteStory;
  final VoidCallback onEditChapter;

  const CustomPublishWorkCard({super.key, required this.story, required this.onEditStory, required this.onDeleteStory, required this.onEditChapter});

  @override
  State<CustomPublishWorkCard> createState() => _CustomPublishWorkCardState();
}

class _CustomPublishWorkCardState extends State<CustomPublishWorkCard> {
  @override
  Widget build(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF17222F), width: 1),
      ),
      height: screenHeight * 0.17,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.story.coverImagePath != null && widget.story.coverImagePath!.isNotEmpty
                      ? "https://api.phongdaynai.id.vn/assets/images/poster/stories/${widget.story.coverImagePath}"
                      : "https://img.idesign.vn/2018/10/23/id-loading-1.gif",
                  width: screenWith * 0.17,
                  height: screenHeight * 0.13,
                  fit: BoxFit.cover,
                )
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    widget.story.title ?? "Loading...",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Total Chapters: ${widget.story.chapterCount}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.grey),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Color(0xFF233648),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          )
                        ),
                        onPressed: widget.onEditStory,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Edit\nStory',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ),
                      FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: Color(0xFF112D4A),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              )
                          ),
                          onPressed: widget.onEditChapter,
                          child: Text(
                            textAlign: TextAlign.center,
                            'Edit\nChapter',
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Color(0xFF137EEA), fontWeight: FontWeight.bold),
                          )
                      ),
                      FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: Color(0xFF20151A),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              )
                          ),
                          onPressed: widget.onDeleteStory,
                          child: SvgPicture.asset(
                            'assets/icons/ic_trash.svg',
                            colorFilter: ColorFilter.mode(Color(0xFFEF4444), BlendMode.srcIn),
                          )
                      )
                    ],
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
