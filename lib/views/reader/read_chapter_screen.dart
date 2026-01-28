import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../viewmodels/story_viewmodel.dart';

class ReadChapterScreen extends ConsumerWidget {
  final int chapterId;
  const ReadChapterScreen({super.key, required this.chapterId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapterAsync = ref.watch(chapterDetailProvider(chapterId));

    return Scaffold(
      backgroundColor: const Color(0xFF0F151C),
      body: SafeArea(
        child: chapterAsync.when(
          data: (chapter) {
            if (chapter == null) return const Center(child: Text("Không tìm thấy nội dung"));

            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _buildHeader(context, chapter.orderNum, chapter.title),

                  Divider(color: Colors.white.withOpacity(0.1)),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Text(
                        chapter.content,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          height: 1.6,
                          fontFamily: 'Serif',
                        ),
                      ),
                    ),
                  ),

                  _buildBottomNav(context),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Lỗi: $err', style: const TextStyle(color: Colors.red))),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int orderNum, String title) {
    return Stack(
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
        )
      ],
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavButton(context, 'PREVIOUS', 'assets/icons/ic_back.svg'),
            const Spacer(),
            _buildNavButton(context, 'NEXT', 'assets/icons/ic_next.svg'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String label, String icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            icon,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 10),
        )
      ],
    );
  }
}
