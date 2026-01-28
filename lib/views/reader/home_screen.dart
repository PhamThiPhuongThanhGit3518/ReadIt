import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/widgets/custom_story_card.dart';
import '../../viewmodels/story_viewmodel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final storyState = ref.watch(storyListProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (isSearching)
                    IconButton(
                      onPressed: () {
                        setState(() => isSearching = false);
                        ref.read(storyListProvider.notifier).fetchStories();
                        searchController.clear();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() => isSearching = false);
                        }
                      },
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() => isSearching = true);
                          ref.read(storyListProvider.notifier).search(value);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Search story or author',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: isSearching
                    ? _buildSearchResults(storyState)
                    : _buildDefaultHome(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultHome() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Updates',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 24),
          Text(
            'Most Popular',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => context.push('/story_detail'),
            child: Text(
              'Demo Story Details',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildSearchResults(AsyncValue storyState) {
    return storyState.when(
      data: (stories) {
        if (stories.isEmpty) {
          return const Center(child: Text("Không tìm thấy truyện nào"));
        }
        return ListView.builder(
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final story = stories[index];
            return CustomStoryCard(
              story: story,
              onTap: () => context.push('/story_detail/${story.id}'),
              onPlayTap: () => context.push('/story/${story.id}/chapters/1'),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Lỗi tải truyện: $err')),
    );
  }
}