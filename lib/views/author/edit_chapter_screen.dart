  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:go_router/go_router.dart';
  import 'package:read_it/services/new_viewmodels/story_detail_viewmodel.dart';
  import 'package:read_it/widgets/custom_edit_chapter_card.dart';
  import '../../services/new_viewmodels/chapter_viewmodel.dart';

  class EditChapterScreen extends ConsumerStatefulWidget {
    final int storyId;

    const EditChapterScreen({super.key, required this.storyId});

    @override
    ConsumerState<EditChapterScreen> createState() => _EditChapterScreenState();
  }

  class _EditChapterScreenState extends ConsumerState<EditChapterScreen> {
    @override
    Widget build(BuildContext context) {
      final chapterList = ref.watch( chapterListProvider(widget.storyId)).value?.reversed.toList();
      final storyDetail = ref.watch(storyDetailViewModelProvider);

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
                              storyDetail.story.value?.title ?? "Loading...",
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
                  '${storyDetail.story.value?.chapterCount} CHAPTERS PUBLISHED',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: ListView.builder(
                    itemCount: chapterList?.length ?? 0,
                    itemBuilder: (context, index) {
                      final chapter = chapterList?[index];
                      if (chapter == null) return const SizedBox.shrink();
                      return CustomEditChapterCard(
                          chapterDetail: chapter,
                          onEdit: () {
                            context.push(
                                '/upload_chapter/${widget.storyId}/${chapter.id}',
                                extra: {'chapterNum': chapter.orderNum}
                            );
                          },
                          onDelete: () {
                            ref.read(deleteChapterProvider.notifier).deleteChapter(chapterId: chapter.id);
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
