import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/widgets/custom_publish_work_card.dart';
import 'package:read_it/widgets/custom_story_card.dart';
import '../../models/dto/api_dto.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/story_viewmodel.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});
  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final user = authState.asData?.value;
    final userId = user?.id ?? -1;

    final historyStory = ref.watch(progressStoriesProvider);
    final favoriteStory = ref.watch(favoriteStoriesProvider);
    final userStory = ref.watch(storiesByUserProvider(userId));

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
                            _buildMyStories(userStory),
                            _buildFavorites(favoriteStory),
                            _buildOffline(historyStory),
                          ]
                              : [
                            _buildFavorites(favoriteStory),
                            _buildOffline(historyStory),
                            _buildHistory(historyStory),
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

  Widget _buildMyStories(AsyncValue<List<StorySummary>> storyState) {
    final userId = ref.watch(authViewModelProvider).asData?.value?.id ?? -1;
    return storyState.when(
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
                      borderRadius: BorderRadiusGeometry.circular(12)
                    )
                  ),
                    onPressed: () => context.push('/create_story/-1'),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Color(0xFFFFFFFF),
                      ),
                      Text(
                        ' New Story',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                )
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
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  final story = stories[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: CustomPublishWorkCard(
                      story: story,
                      onAddChapter: () {
                        ref.invalidate(storyDetailProvider(story.id));
                        context.push('/upload_chapter', extra: story.id);
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
      error: (err, stack) => Center(child: Text('Lỗi tải truyện của bạn: $err')),
    );
  }

  Widget _buildFavorites(AsyncValue storyState) {
    return storyState.when(
      data: (stories) {
        if (stories.isEmpty) {
          return const Center(child: Text("Không tìm thấy truyện nào"));
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
                    ref.invalidate(storyDetailProvider(story.id));
                    context.push('/story_detail/${story.id}');
                  },
                ),
              );
            }
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Lỗi tải truyện: $err')),
    );
  }

  Widget _buildOffline(AsyncValue storyState) {
    return storyState.when(
      data: (stories) {
        if (stories.isEmpty) {
          return const Center(child: Text("Không tìm thấy truyện nào"));
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
                    ref.invalidate(storyDetailProvider(story.id));
                    context.push('/story_detail/${story.id}');
                  },
                ),
              );
            }
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Lỗi tải truyện: $err')),
    );
  }

  Widget _buildHistory(AsyncValue storyState) {
    return storyState.when(
      data: (stories) {
        if (stories.isEmpty) {
          return const Center(child: Text("Không tìm thấy truyện nào"));
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
                    ref.invalidate(storyDetailProvider(story.id));
                    context.push('/story_detail/${story.id}');
                  },
                ),
              );
            }
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Lỗi tải truyện: $err')),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              )
            ),
            onPressed: () {
              ref.read(deleteStoryProvider.notifier).delete(story.id, userId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Deleting "${story.title}"...')),
              );
            },
            child: const Text('DELETE', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
