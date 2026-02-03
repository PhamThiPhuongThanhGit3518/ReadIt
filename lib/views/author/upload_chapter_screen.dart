import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/widgets/custom_text_field.dart';

import '../../services/file_picker_service.dart';
import '../../viewmodels/chapters/chapter_detail_viewmodel.dart';
import '../../viewmodels/chapters/chapter_form_viewmodel.dart';
import '../../viewmodels/stories/story_detail_viewmodel.dart';

class UploadChapterScreen extends ConsumerStatefulWidget {
  final int storyId;
  final int chapterId;
  final int chapterNum;

  const UploadChapterScreen({super.key, required this.storyId, required this.chapterId, required this.chapterNum});

  @override
  ConsumerState<UploadChapterScreen> createState() => _UploadChapterScreenState();
}

class _UploadChapterScreenState extends ConsumerState<UploadChapterScreen> {
  String chapterNumber = "";
  String chapterTitle = "";
  String? _selectedFilePath;

  final TextEditingController chapterNumberController = TextEditingController();
  final TextEditingController chapterTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.chapterId != -1) {
      _loadOldChapter();
    }
  }


  @override
  Widget build(BuildContext context) {
    ref.listen<ChapterFormState>(
      chapterFormViewModelProvider,
          (previous, next) {
        if (!mounted) return;

        if (next.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.error!)),
          );
        }
      },
    );
    final story = ref.watch(storyDetailProvider(widget.storyId));
    bool isEdit = widget.chapterId != -1;
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
                  Text(
                    isEdit ? 'Update Chapter' : 'Publish Chapter',
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
                story.value?.title ?? "Loading...",
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
                controller: chapterNumberController,
                enable: !isEdit,
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
                    onPressed: () async {
                      if (_selectedFilePath == null && !isEdit) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vui lòng chọn file nội dung!')),
                        );
                        return;
                      }

                      String content = '';
                      if (_selectedFilePath != null &&
                          !_selectedFilePath!.startsWith('Current content')) {
                        final file = File(_selectedFilePath!);
                        final bytes = await file.readAsBytes();
                        content = utf8.decode(bytes, allowMalformed: true);
                      }

                      await ref.read(chapterFormViewModelProvider.notifier).submitChapter(
                        storyId: widget.storyId,
                        title: chapterTitleController.text,
                        content: content,
                        orderNum: int.tryParse(chapterNumberController.text) ?? 1,
                        isEdit: isEdit,
                      );
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đã xử lý chương thành công!')),
                        );
                        Future.delayed(const Duration(milliseconds: 100), () {
                          if (mounted) context.pop();
                        });
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

  @override
  void dispose() {
    chapterNumberController.dispose();
    chapterTitleController.dispose();
    super.dispose();
  }

  Future<void> _loadOldChapter() async {
    final int? chapterNum = widget.chapterNum;

    if (chapterNum == null) {
      print('Error: chapterNum is null');
      return;
    }

    print('Loading Chapter with Number: $chapterNum');

    final chapter = await ref.read(
      chapterByOrderProvider(
        (storyId: widget.storyId, orderNum: chapterNum),
      ).future,
    );

    if (!mounted || chapter == null) return;

    setState(() {
      chapterNumberController.text = chapter.orderNum.toString();
      chapterTitleController.text = chapter.title;
      _selectedFilePath = "Current content loaded (Tap to change)";
    });
  }
}
