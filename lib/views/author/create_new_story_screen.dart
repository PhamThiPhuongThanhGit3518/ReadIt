import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/widgets/custom_text_field.dart';

import '../../services/file_picker_service.dart';
import '../../viewmodels/story_viewmodel.dart';

class CreateNewStoryScreen extends ConsumerStatefulWidget {
  const CreateNewStoryScreen({super.key});

  @override
  ConsumerState<CreateNewStoryScreen> createState() => _CreateNewStoryScreenState();
}

class _CreateNewStoryScreenState extends ConsumerState<CreateNewStoryScreen> {
  String storyTitle = "";
  String description = "";

  String? _selectedImagePath;

  final TextEditingController storyTitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final createStoryState = ref.watch(createStoryProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: SvgPicture.asset(
                      'assets/icons/ic_close.svg',
                      colorFilter: ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
                    ),
                  ),
                  Text(
                    '  Create New Story',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 12,),
              Divider(
                thickness: 1,
                color: Color(0xFF1E293B),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Story Details',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        'Tell us about your masterpiece',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                      ),
                      const SizedBox(height: 24,),
                      Text(
                        'Cover Image',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 12,),
                      Center(
                        child: DottedBorder(
                          color: Colors.blueGrey.withOpacity(0.5),
                          strokeWidth: 2,
                          dashPattern: const [8, 4],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          child: InkWell(
                            onTap: () async {
                              final path = await ref.read(filePickerServiceProvider).pickImageFromGallery() ;
                              if (path != null) {
                                setState(() {
                                  _selectedImagePath = path;
                                });
                              }
                            },
                            child: Container(
                              width: 200,
                              height: 300,
                              color: const Color(0xFF1A222D),
                              child: _selectedImagePath != null
                                  ? Image.file(File(_selectedImagePath!), fit: BoxFit.cover)
                                  :Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.add_photo_alternate, size: 50, color: Colors.blue),
                                  SizedBox(height: 10),
                                  Text("Upload Cover", style: TextStyle(color: Colors.white, fontSize: 16)),
                                  Text("600 x 900px recommended", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomTextField(
                          label: 'Story Title',
                          hint: 'Enter a catchy title',
                          isPassword: false,
                          controller: storyTitleController
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 12,),
                      TextField(
                        controller: descriptionController,
                        maxLines: 5,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Write a brief summary of your story...",
                          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1.5
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      Text(
                        'Categories',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 24,),
                      SizedBox(
                        height: 56,
                        child: FilledButton(
                            onPressed: createStoryState.isLoading
                                ? null
                                : () async {
                              await ref.read(createStoryProvider.notifier).create(
                                storyTitleController.text,
                                descriptionController.text,
                                _selectedImagePath != null ? File(_selectedImagePath!) : null,
                              );

                              final result = ref.read(createStoryProvider);
                              if (result.hasValue && result.value?.success == true) {
                                final newStoryId = result.value?.data?.storyId;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Tạo truyện thành công!')),
                                );

                                context.push('/upload_chapter', extra: newStoryId);
                              } else if (result.hasError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Lỗi: ${result.error}')),
                                );
                              }
                            },
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Save & Continue  ',
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24),
                                ),
                                SvgPicture.asset(
                                  'assets/icons/ic_next.svg',
                                  colorFilter: ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
                                  width: 24,
                                  height: 24,
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}