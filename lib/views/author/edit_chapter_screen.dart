import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/models/dto/api_dto.dart';
import 'package:read_it/widgets/custom_edit_chapter_card.dart';
import '../../viewmodels/chapters/chapter_form_viewmodel.dart';
import '../../viewmodels/chapters/chapter_list_viewmodel.dart';
import '../../viewmodels/chapters/delete_chapter_viewmodel.dart';
import '../../viewmodels/stories/story_detail_viewmodel.dart';

  class EditChapterScreen extends ConsumerStatefulWidget {
    final int storyId;

    const EditChapterScreen({super.key, required this.storyId});

    @override
    ConsumerState<EditChapterScreen> createState() => _EditChapterScreenState();
  }

  class _EditChapterScreenState extends ConsumerState<EditChapterScreen> {

    @override
    void initState() {
      super.initState();
      Future.microtask(() {
        ref.invalidate(chapterListProvider(widget.storyId));
        ref.invalidate(storyDetailProvider(widget.storyId));
      });
    }

    @override
    Widget build(BuildContext context) {

      ref.listen(chapterFormViewModelProvider, (previous, next) {
        if (next.isSuccess && mounted) {
          ref.invalidate(chapterListProvider(widget.storyId));
          ref.invalidate(storyDetailProvider(widget.storyId));
        }
      });

      final chapterAsync = ref.watch(chapterListProvider(widget.storyId));

      final chapterList = chapterAsync.maybeWhen(
        data: (list) => list.reversed.toList(),
        orElse: () => const <ChapterSummary>[],
      );

      final storyDetail = ref.watch(storyDetailProvider(widget.storyId));

      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(Icons.arrow_back)
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              storyDetail.value?.title ?? "Loading...",
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Text(
                              'Chapter Management'
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 50,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      )
                    ),
                    onPressed: () {
                      context.push('/upload_chapter/${widget.storyId}/-1');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_add.svg',
                          colorFilter: ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
                        ),
                        Text(
                          ' Add New Chapter',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  '${storyDetail.value?.chapterCount} CHAPTERS PUBLISHED',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: ListView.builder(
                    key: ValueKey(chapterList.length),
                    itemCount: chapterList.length,
                    itemBuilder: (context, index) {
                      final chapter = chapterList[index];
                      return CustomEditChapterCard(
                          chapterDetail: chapter,
                          onEdit: () {
                            final chapterNum = chapter.orderNum ?? 0;
                            print('Pushing to edit chapter with orderNum: $chapterNum');

                            context.push(
                              '/upload_chapter/${widget.storyId}/${chapter.id}',
                              extra: {'chapterNum': chapterNum},
                            );
                          },
                          onDelete: () {
                            _showDeleteConfirmation(context, ref,widget.storyId, chapter);
                          }
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, int storyId, ChapterSummary chapter) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1D283A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
            const SizedBox(width: 10),
            Text(
              'Confirm Delete',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${chapter.title}"? This action cannot be undone.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              ref.read(deleteChapterProvider.notifier).deleteChapter(chapterId: chapter.id ?? -1, storyId: storyId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đang xóa "${chapter.title}"...')),
              );
            },
            child: const Text('DELETE', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
