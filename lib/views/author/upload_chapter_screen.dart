import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/services/viewmodels/chapter_viewmodel.dart';
import 'package:read_it/widgets/custom_text_field.dart';

import '../../services/file_picker_service.dart';
import '../../services/viewmodels/refresh_ui/library_viewmodel.dart';

class UploadChapterScreen extends ConsumerStatefulWidget {
  final int storyId;
  final int chapterId;

  const UploadChapterScreen({super.key, required this.storyId, required this.chapterId});

  @override
  ConsumerState<UploadChapterScreen> createState() => _UploadChapterScreenState();
}

class _UploadChapterScreenState extends ConsumerState<UploadChapterScreen> {
  String chapterNumber = "";
  String chapterTitle = "";
  String? _selectedFilePath;

  final TextEditingController chapterNumberController = TextEditingController();
  final TextEditingController chapterTitleController = TextEditingController();

  final libraryViewModelProvider = StateNotifierProvider<LibraryViewModel, LibraryState>((ref) {
    return LibraryViewModel(ref);
  });


  @override
  void initState() {
    super.initState();
    if (widget.chapterId != -1) {
      Future.microtask(() async {
        final extraData = GoRouterState.of(context).extra as Map<String, dynamic>;
        final int chapterNum = extraData['chapterNum'];
        final chapterAsync = ref.watch(chapterByOrderProvider((
          storyId: widget.storyId,
          orderNum: chapterNum,
        )));
        if (chapterAsync != null) {
          setState(() {
            chapterNumberController.text = chapterAsync.value?.orderNum.toString() ?? '';
            chapterTitleController.text = chapterAsync.value?.title ?? '';
            _selectedFilePath = chapterAsync.value?.content;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.chapterId != -1;
    final uploadChapterState = ref.watch(uploadChapterProvider);

    return Scaffold(
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: SvgPicture.asset(
                      'assets/icons/ic_back.svg',
                      height: 24,
                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                  Text( isEdit ? 'Edit Chapter' : 'Upload Chapter',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12,),
              Divider(
                thickness: 1,
                color: Color(0xFF1E293B),
              ),
              const SizedBox(height: 12,),
              Text(
                'Story Name',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8,),
              Text(
                'Add a new chapter to your fantasy masterpiece',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 32,),
              CustomTextField(
                label: 'Chapter Number',
                hint: 'Enter chapter number',
                isPassword: false,
                controller: chapterNumberController
              ),
              const SizedBox(height: 12,),
              CustomTextField(
                  label: 'Chapter Title',
                  hint: 'Enter chapter title',
                  isPassword: false,
                  controller: chapterTitleController
              ),
              const SizedBox( height: 24,),
              Text(
                'Chapter File (.doc or .md)',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox( height: 12,),
              Center(
                child: DottedBorder(
                  color: Colors.blueGrey.withOpacity(0.5),
                  strokeWidth: 2,
                  dashPattern: const [8, 4],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: InkWell(
                    onTap: () async {
                      final path = await ref.read(filePickerServiceProvider).pickDocument() ;
                      if (path != null) {
                        setState(() {
                          _selectedFilePath = path;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: const Color(0xFF1A222D),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _selectedFilePath != null ? [
                          const Icon(Icons.upload_file_rounded, size: 50, color: Colors.blue),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              _selectedFilePath!.split('/').last,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Text(
                            "Tap to change file",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ] : const [
                          Icon(Icons.upload_file_rounded, size: 50, color: Color(
                              0xFF595858)),
                          SizedBox(height: 10),
                          Text("Tap to upload .txt or .md", style: TextStyle(color: Colors.white, fontSize: 16)),
                          Text("MAXIMUM FILE SIZE: 20 MB", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox( height: 24,),
              SizedBox(
                height: 56,
                child: FilledButton(
                    onPressed: (uploadChapterState.isLoading || _selectedFilePath == null)
                        ? null
                        : () async {
                      try {
                        final file = File(_selectedFilePath!);
                        final bytes = await file.readAsBytes();
                        String content = utf8.decode(bytes, allowMalformed: true);
          
                        await ref.read(uploadChapterProvider.notifier).uploadChapter(
                          storyId: widget.storyId,
                          title: chapterTitleController.text,
                          content: content,
                          orderNum: int.tryParse(chapterNumberController.text) ?? 1,
                        );

                        ref.read(libraryViewModelProvider.notifier).onChapterUploaded(widget.storyId);
          
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Đã đăng chương thành công!')),
                          );
                          context.go('/library');
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Lỗi tải chương: $e')),
                        );
                      }
                    },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                  child: Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Publish Chapter  ',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24),
                      ),
                      Icon(
                        Icons.send,
                        color: Color(0xFFFFFFFF)
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      ),)
    );
  }
}
