import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../viewmodels/auth_viewmodel.dart';

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
    final bool isAuthor = user?.role == 'author';
    final tabs = isAuthor
      ? ['My stories', 'Favourite', 'Offline']
      : ['Favourites', 'Offline', 'History'];

    return Scaffold(
      floatingActionButton: isAuthor
        ? FloatingActionButton(
          onPressed: () {
            context.push('/create_story');
          },
          child: Icon(
            Icons.add,
          )
      ) : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                'Personal Library',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 24,),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: List.generate(tabs.length, (index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedIndex = index),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? const Color(0xFF101922)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                tabs[index],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
