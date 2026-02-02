import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:read_it/models/dto/api_dto.dart';

import '../utils/date_formatter.dart';

class CustomEditChapterCard extends StatelessWidget {
  final ChapterSummary chapterDetail;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CustomEditChapterCard({super.key, required this.chapterDetail, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF17222F), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chapter ${chapterDetail.orderNum}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    '${chapterDetail.title}',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    'Updated on \n${DateFormatter.toVietnamese(chapterDetail.createdAt)}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Color(0xFF58677C)),
                  )
                ],
              ),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size(50, 50),
              padding: EdgeInsets.zero,
              backgroundColor: Color(0xFF233648),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
            ),
            onPressed: onEdit,
            child: SvgPicture.asset(
              'assets/icons/ic_edit.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
            )
          ),
          const SizedBox(width: 8),
          FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size(50, 50),
                padding: EdgeInsets.zero,
                backgroundColor: Color(0xFF20151A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
              ),
              onPressed: onDelete,
              child: SvgPicture.asset(
                'assets/icons/ic_trash.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(Color(0xFFEF4444), BlendMode.srcIn),
              )
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
