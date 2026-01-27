import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class StoryDetailScreen extends ConsumerStatefulWidget {
  const StoryDetailScreen({super.key});

  @override
  ConsumerState<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends ConsumerState<StoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
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
                          child: Image.asset(
                            'assets/images/night.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'The Midnight Star',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Jane Doe',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(height: 12),
                        _buildStatsSection(context),
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
              _buildAboutContent(),
              _buildAboutChapter(),
              const Center(child: Text("Reviews", style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          _buildStatItem('LIKES', '4.5K', icon: 'assets/icons/ic_heart.svg'),
          const VerticalDivider(color: Color(0xFF1D283A), thickness: 1, indent: 10, endIndent: 10),
          _buildStatItem('VIEWS', '9.6K', icon: 'assets/icons/ic_eye.svg'),
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

  Widget _buildAboutContent() {
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
          const Text(
            "In a world where the sun never sets, Elara discovers an ancient relic that can summon the \"Midnight Star\"—a legend that could either save her civilization or plunge it into eternal darkness.\n \nAs the royal guard closes in, Elara must journey across the Crystal Deserts to find the Oracle. But the star has a mind of its own, and its light is fading fast...",
            style: TextStyle(color: Colors.white70, height: 1.6, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutChapter() {
    return ListView.builder(
        itemCount: chapters.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final chapter = chapters[index];
          return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    context.push('/read_chapter');
                  },
                  child:
                    Row(
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
                              chapter.number.toString(),
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20,color: Theme.of(context).colorScheme.primary),
                            ),
                          )
                        ),
                        const SizedBox(width: 12,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chapter.title,
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Color(0xFFFFFFFF)),
                            ),
                            Text(
                              chapter.date,
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                            )
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.download)
                        ),
                      ],
                    ),
                ),
              ),
          );
        }
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

