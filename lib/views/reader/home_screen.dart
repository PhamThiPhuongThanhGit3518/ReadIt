import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: searchController,
                    onChanged: (value) => setState(() => searchText = value),
                    decoration: InputDecoration(
                        hintText: 'Search story or author',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'New Updates',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 24,),
                  Text(
                    'Most Popular',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 24,),
                  GestureDetector(
                    onTap: () {
                      context.push('/story_detail');
                    },
                    child: Text(
                      'Demo Story Details',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                    ),
                  )
                ],
              ),
            )
          )
      ),
    );
  }
}
