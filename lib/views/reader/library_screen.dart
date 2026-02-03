import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/widgets/custom_history_story_card.dart';
import 'package:read_it/widgets/custom_publish_work_card.dart';
import 'package:read_it/widgets/custom_story_card.dart';
import '../../database/models/offline_chapter.dart';
import '../../models/dto/api_dto.dart';
import '../../viewmodels/auth/auth_viewmodel.dart';
import '../../viewmodels/stories/delete_story_viewmodel.dart';
import '../../viewmodels/offline/offline_viewmodel.dart';
import '../../viewmodels/refresh_ui/library_viewmodel.dart';
import '../../viewmodels/stories/story_detail_viewmodel.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final user = authState.asData?.value;
    final libraryState = ref.watch(libraryViewModelProvider.select((state) => state));
    final offlineChapters = ref.watch(offlineChaptersProvider);

    final bool isAuthor = user?.role == 'author';
    final tabs = isAuthor
        ? ['My stories', 'Favourite', 'Offline']
        : ['Favourites', 'Offline', 'History'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                'Personal Library',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: DefaultTabController(
                  length: tabs.length,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D283A),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                            color: const Color(0xFF101922),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          dividerColor: Colors.transparent,
                          padding: const EdgeInsets.all(5),
                          tabs: tabs.map((title) => Tab(text: title)).toList(),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: isAuthor
                              ? [
                            _buildMyStories(),
                            _buildFavorites(libraryState.favorites),
                            _buildOffline(offlineChapters),
                          ]
                              : [
                            _buildFavorites(libraryState.favorites),
                            _buildOffline(offlineChapters),
                            _buildHistory(libraryState.history),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyStories() {
    final userId = ref.watch(authViewModelProvider).asData?.value?.id ?? -1;
    final myStoriesAsync = ref.watch(libraryViewModelProvider.select((s) => s.myStories));
    return myStoriesAsync.when(
      data: (stories) {
        return Column(
          children: [
            Row(
              children: [
                Text(
                  'Published Works',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => context.push('/create_story/-1'),
                  child: Row(
                    children: [
                      const Icon(Icons.add, color: Colors.white),
                      Text(
                        ' New Story',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: stories.isEmpty
                  ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.library_books_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text("You haven't published any stories yet.",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
                  : ListView.builder(
                key: ValueKey(stories.length),
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  final story = stories[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: CustomPublishWorkCard(
                      story: story,
                      onEditChapter: () {
                        context.push('/edit_chapter/${story.id}');
                      },
                      onEditStory: () {
                        context.push('/create_story/${story.id}');
                      },
                      onDeleteStory: () {
                        _showDeleteConfirmation(context, ref, story, userId);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Lỗi tải My Stories: $err'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(libraryViewModelProvider.notifier).refreshMyStories(),
              child: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavorites(AsyncValue<List<StorySummary>> storyState) {
    return storyState.when(
      data: (stories) {
        if (stories.isEmpty) {
          return const Center(child: Text("Bạn chưa có truyện yêu thích nào"));
        }
        return ListView.builder(
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final story = stories[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CustomStoryCard(
                story: story,
                onTap: () {
                  ref.read(storyDetailViewModelProvider.notifier).loadStoryDetail(story.id ?? -1);
                  context.push('/story_detail/${story.id}');
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Lỗi tải yêu thích: $err'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(libraryViewModelProvider.notifier).refreshFavorites(),
              child: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOffline(AsyncValue<List<OfflineChapter>> offlineState) {
    return offlineState.when(
      data: (chapters) {
        if (chapters.isEmpty) {
          return const Center(
            child: Text("Chưa có chương nào tải về", style: TextStyle(color: Colors.white70)),
          );
        }
        return ListView.builder(
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final item = chapters[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1D283A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.download_done_rounded, color: Colors.greenAccent),
                title: Text(
                  item.chapterTitle,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${item.storyName} - Chương ${item.orderNum}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                onTap: () {
                  context.push('/read_offline', extra: item);
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete_sweep_outlined, color: Colors.redAccent),
                  onPressed: () async {
                    await ref.read(offlineViewModelProvider.notifier).deleteChapter(item.id);
                  },
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Lỗi tải Offline: $e")),
    );
  }

  Widget _buildHistory(AsyncValue<List<HistoryItem>> historyState) {
    return historyState.when(
      data: (items) {
        if (items.isEmpty) {
          return const Center(child: Text("Chưa có lịch sử đọc truyện nào"));
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CustomHistoryStoryCard(
                story: item,
                onTap: () {
                  ref.read(storyDetailViewModelProvider.notifier).loadStoryDetail(item.storyId ?? -1);
                  context.push('/story_detail/${item.storyId}');
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Lỗi tải lịch sử: $err'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(libraryViewModelProvider.notifier).refreshHistory(),
              child: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, StorySummary story, int userId) {
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
          'Are you sure you want to delete "${story.title}"? This action cannot be undone.',
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
              ref.read(deleteStoryViewModelProvider.notifier).deleteStory(story.id ?? -1, userId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đang xóa "${story.title}"...')),
              );
            },
            child: const Text('DELETE', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}