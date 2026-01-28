import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../models/dto/api_dto.dart';
import '../../viewmodels/story_viewmodel.dart';

class StoryDetailScreen extends ConsumerStatefulWidget {
  final int storyId;

  const StoryDetailScreen({super.key, required this.storyId});

  @override
  ConsumerState<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends ConsumerState<StoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final storyDetailAsync = ref.watch(storyDetailProvider(widget.storyId));
    final chaptersAsync = ref.watch(chapterListProvider(widget.storyId));

    return Scaffold(
      backgroundColor: const Color(0xFF0F151C),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 480,
                pinned: true,
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: SvgPicture.asset(
                    'assets/icons/ic_back.svg',
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
                backgroundColor: const Color(0xFF0F151C),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Container(
                          width: 200,
                          height: 250,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              storyDetailAsync.value?.posterLink ?? "https://lh7-rt.googleusercontent.com/docsz/AD_4nXd-JmBSGuLeZSkBuj38razGDVv45PcjJ6KhweCCwwHv1HfqwAwW8lY8HEba9IzJK0B_Z_9E8vcAiV02YF4jLO9eGgA6f-zqqOsCr8FtmhgCreaR5SSd9FxkuK2fr0Vdj6J_6r1tNHNmYACFiWkAs4EO1KHK?key=tE_qip6BHPL4g00JXL_X6Q",
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 150,
                                  height: 150,
                                  color: Colors.grey[900],
                                  child: const Center(child: CircularProgressIndicator()),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 150,
                                height: 150,
                                color: Colors.grey,
                                child: const Icon(Icons.broken_image, size: 50),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Center(
                          child: Text(
                            storyDetailAsync.value!.title,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Jane Doe',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(height: 12),
                        _buildStatsSection(storyDetailAsync),
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                  indicatorColor: Theme.of(context).colorScheme.onSurface,
                  indicatorWeight: 1,
                  dividerColor: Color(0xFF5A5A5A),
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: 'About'),
                    Tab(text: 'Chapters'),
                    Tab(text: 'Reviews'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildAboutContent(storyDetailAsync.value!.description),
              _buildAboutChapter(chaptersAsync),
              const Center(child: Text("Reviews", style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(AsyncValue storyDetailAsync) {
    final storyDetailAsync = ref.watch(storyDetailProvider(widget.storyId));
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          _buildStatItem('LIKES', '4.5K', icon: 'assets/icons/ic_heart.svg'),
          const VerticalDivider(color: Color(0xFF1D283A), thickness: 1, indent: 10, endIndent: 10),
          _buildStatItem('VIEWS', '${storyDetailAsync.value?.viewCount}', icon: 'assets/icons/ic_eye.svg'),
          const VerticalDivider(color: Color(0xFF1D283A), thickness: 1, indent: 10, endIndent: 10),
          _buildStatItem('STATUS', 'Completed', color: const Color(0xFF22C55E)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {String? icon, Color? color}) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                SvgPicture.asset(icon, width: 14, height: 14, colorFilter: const ColorFilter.mode(Color(0xFF94A3B8), BlendMode.srcIn)),
                const SizedBox(width: 4),
              ],
              Text(value, style: TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAboutContent(String storyDetail) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: ['Fantasy', 'Mystery', 'Adventure'].map((tag) => Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20)),
              child: Text(tag, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            )).toList(),
          ),
          const SizedBox(height: 20),
          Text(
            storyDetail,
            style: TextStyle(color: Colors.white70, height: 1.6, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutChapter(AsyncValue<List<ChapterSummary>> chaptersAsync) {
    return chaptersAsync.when(
      data: (chapterList) {
        if (chapterList.isEmpty) {
          return const Center(child: Text("Truyện chưa có chương nào", style: TextStyle(color: Colors.white70)));
        }
        return ListView.builder(
          itemCount: chapterList.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final chapter = chapterList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GestureDetector(
                onTap: () => context.push('/read_chapter/${chapter.id}'),
                child: Row(
                  children: [
                    Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Center(
                          child: Text(
                            (index + 1).toString(), // Dùng index + 1 làm số chương
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.primary
                            ),
                          ),
                        )
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chapter.title,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            "Mới cập nhật", // Server của anh chưa trả về ngày, tạm để text này
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.download, color: Colors.grey)
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Lỗi tải chương: $err")),
    );
  }
}

class ChapterItem {
  final int number;
  final String title;
  final String date;

  ChapterItem({required this.number, required this.title, required this.date});
}

final List<ChapterItem> chapters = [
  ChapterItem(number: 1, title: 'The Awakening', date: 'Oct 12, 2023'),
  ChapterItem(number: 2, title: 'The Forgotten Relic', date: 'Oct 15, 2023'),
  ChapterItem(number: 3, title: 'Crystal Deserts', date: 'Oct 20, 2023'),
  ChapterItem(number: 4, title: 'Day night', date: 'Oct 21, 2023'),
  ChapterItem(number: 5, title: 'Remember the pass', date: 'Oct 22, 2023'),
  ChapterItem(number: 6, title: 'See you again', date: 'Oct 25, 2023'),
];

