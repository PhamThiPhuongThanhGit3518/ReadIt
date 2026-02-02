import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/services/viewmodels/chapter_viewmodel.dart';
import 'package:read_it/services/viewmodels/story_detail_viewmodel.dart';
import 'package:read_it/utils/date_formatter.dart';
import '../../models/dto/api_dto.dart';
import '../../providers/api_providers.dart';
import '../../services/viewmodels/offline/offline_viewmodel.dart';

class StoryDetailScreen extends ConsumerStatefulWidget {
  final int storyId;

  const StoryDetailScreen({super.key, required this.storyId});

  @override
  ConsumerState<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends ConsumerState<StoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final storyDetailAsync = ref.watch(storyDetailViewModelProvider);
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
                              storyDetailAsync.story.value?.coverLink ?? "https://www.shutterstock.com/shutterstock/videos/1039407446/thumb/1.jpg?ip=x480",
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 48, right: 48),
                            child: Text(
                              storyDetailAsync.story.value?.title ?? 'Loading...',
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Jane Doe',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(height: 12),
                        _buildStatsSection(),
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
              _buildAboutContent(storyDetailAsync.story.value?.description ?? 'Loading...'),
              _buildAboutChapter(chaptersAsync),
              const Center(child: Text("Reviews", style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    final storyDetailAsync = ref.watch(storyDetailViewModelProvider);
    final int favCount = storyDetailAsync.story.value?.favoriteCount ?? 0;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          _buildStatItem(
            'LIKES',
            '$favCount',
            icon: 'assets/icons/ic_heart.svg',
            iconColor: favCount > 0 ? Colors.redAccent : const Color(0xFF94A3B8),
            onTap: () {
              ref.read(storyDetailViewModelProvider.notifier).toggleFavorite(widget.storyId);
            },
          ),
          const VerticalDivider(color: Color(0xFF1D283A), thickness: 1, indent: 10, endIndent: 10),
          _buildStatItem('VIEWS', '${storyDetailAsync.story.value?.viewCount ?? 0}', icon: 'assets/icons/ic_eye.svg'),
          const VerticalDivider(color: Color(0xFF1D283A), thickness: 1, indent: 10, endIndent: 10),
          _buildStatItem('STATUS', 'Completed', color: const Color(0xFF22C55E)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {String? icon, Color? color, Color? iconColor, VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  SvgPicture.asset(
                    icon,
                    width: 14,
                    height: 14,
                    colorFilter: ColorFilter.mode(iconColor ?? const Color(0xFF94A3B8), BlendMode.srcIn),
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  value,
                  style: TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            )
          ],
        ),
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
        final storyDetailAsync = ref.watch(storyDetailViewModelProvider);
        final story = storyDetailAsync.story.value;

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
                onTap: () => context.push('/read_chapter/${widget.storyId}/${chapter.orderNum}'),
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
                            chapter.orderNum.toString(),
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
                          Text(
                            DateFormatter.toRelativeTime(chapter.createdAt),
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (story == null) return;
                        final response = await ref.read(storyRepositoryProvider)
                            .getChapterByNumber(widget.storyId, chapter.orderNum);

                        if (response.data != null) {
                          final chapterDetail = response.data!;

                          await ref.read(offlineViewModelProvider.notifier)
                              .downloadChapter(story, chapterDetail);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Đã tải: ${chapterDetail.title}')),
                            );
                          }
                        }
                      },
                      icon: ref.watch(isDownloadedProvider(chapter.id))
                          ? const Icon(Icons.cloud_done, color: Colors.green)
                          : const Icon(Icons.download, color: Colors.grey),
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

