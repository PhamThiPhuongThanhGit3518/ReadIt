import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/widgets/custom_popular_story_card.dart';
import 'package:read_it/widgets/custom_story_card.dart';
import '../../viewmodels/stories/story_list_viewmodel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(storyListViewModelProvider.notifier).fetchNewStories();
      ref.read(storyListViewModelProvider.notifier).fetchPopularStories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final storyListState = ref.watch(storyListViewModelProvider);

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
                        ref.read(storyListViewModelProvider.notifier).fetchStories();
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
                          ref.read(storyListViewModelProvider.notifier).search(value);
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
                    ? _buildSearchResults(storyListState.stories)
                    : _buildDefaultHome(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultHome() {
    final storyListState = ref.watch(storyListViewModelProvider);
    final newState = storyListState.newStories;
    final popularState = storyListState.popularStories;
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            'Most Popular',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 12),
          SizedBox(
              height: screenHeight * (1/3.2),
              width: screenWith,
              child: _buildPopularStories(popularState)
          ),
          const SizedBox(height: 24),
          Text(
            'New Updates',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 12),
          _buildSearchResults(newState, isScrollable: false),
        ],
      ),
    );
  }

  Widget _buildPopularStories(AsyncValue storyState) {
    return storyState.when(
      data: (stories) {
        if (stories.isEmpty) {
          return const Center(child: Text("Không tìm thấy truyện nào"));
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final story = stories[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CustomPopularStoryCard(
                story: story,
                onTap: () {
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
  Widget _buildSearchResults(AsyncValue storyState, {bool isScrollable = true}) {
    return storyState.when(
      data: (stories) {
        if (stories.isEmpty) return const Center(child: Text("Không tìm thấy truyện nào"));

        return ListView.builder(
          shrinkWrap: true,
          physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final story = stories[index];
            return CustomStoryCard(
              story: story,
              onTap: () {
                context.push('/story_detail/${story.id}');
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Lỗi tải truyện: $err')),
    );
  }
}