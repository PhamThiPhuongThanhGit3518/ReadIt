import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedIndex = 0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: selectedIndex == 0 ? Color(0xFF101922) : Colors.transparent,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Center(
                              child: Text(
                                'Favourites',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        )
                      ),
                      Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedIndex = 1),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: selectedIndex == 1 ? Color(0xFF101922) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Center(
                                child: Text(
                                  'Offline',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          )
                      ),
                      Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedIndex = 2),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: selectedIndex == 2 ? Color(0xFF101922) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Center(
                                child: Text(
                                  'History',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          )
                      )
                    ],
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
