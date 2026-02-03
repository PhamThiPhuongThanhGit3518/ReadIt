import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../viewmodels/chapters/chapter_detail_viewmodel.dart';
import '../../viewmodels/stories/story_detail_viewmodel.dart';

final currentChapterNumProvider = StateProvider<int>((ref) => 1);

class ReadChapterScreen extends ConsumerStatefulWidget {
  final int storyId;
  final int chapterNum;

  const ReadChapterScreen({
    super.key,
    required this.storyId,
    required this.chapterNum,
  });

  @override
  ConsumerState<ReadChapterScreen> createState() => _ReadChapterScreenState();
}

class _ReadChapterScreenState extends ConsumerState<ReadChapterScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(currentChapterNumProvider.notifier).state = widget.chapterNum;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chapterNum = ref.watch(currentChapterNumProvider);
    final chapterAsync = ref.watch(
      chapterByOrderProvider((storyId: widget.storyId, orderNum: chapterNum)),
    );
    final storyDetailAsync = ref.watch(storyDetailProvider(widget.storyId));
    final totalChapter = storyDetailAsync.value?.chapterCount ?? 1;

    return Scaffold(
      backgroundColor: const Color(0xFF0F151C),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, chapterNum, chapterAsync.value?.title ?? "Chapter $chapterNum"),
            const Divider(color: Colors.white10),
            Expanded(
              child: chapterAsync.when(
                data: (chapter) {
                  if (chapter == null) {
                    return const Center(child: Text("Không tìm thấy nội dung", style: TextStyle(color: Colors.white70)));
                  }

                  return SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: SelectableText(
                      chapter.content ?? 'Nội dung trống',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        height: 1.6,
                        fontFamily: 'Serif',
                      ),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Lỗi tải chapter: $err', style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.refresh(
                          chapterByOrderProvider((storyId: widget.storyId, orderNum: chapterNum)),
                        ),
                        child: const Text('Thử lại'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomNav(context, totalChapter, chapterNum),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int orderNum, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: SvgPicture.asset(
                'assets/icons/ic_back.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
          Text(
            'Chapter $orderNum: $title',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, int totalChapter, int currentChapter) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavButton(
              context: context,
              label: 'PREVIOUS',
              icon: 'assets/icons/ic_back.svg',
              enabled: currentChapter > 1,
              onTap: () {
                if (currentChapter > 1) {
                  ref.read(currentChapterNumProvider.notifier).state = currentChapter - 1;
                  _scrollController.jumpTo(0); // Scroll lên đầu nội dung mới
                }
              },
            ),
            const Spacer(),
            _buildNavButton(
              context: context,
              label: 'NEXT',
              icon: 'assets/icons/ic_next.svg',
              enabled: currentChapter < totalChapter,
              onTap: () {
                if (currentChapter < totalChapter) {
                  ref.read(currentChapterNumProvider.notifier).state = currentChapter + 1;
                  _scrollController.jumpTo(0);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required BuildContext context,
    required String label,
    required String icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: enabled ? onTap : null,
            icon: SvgPicture.asset(
              icon,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}