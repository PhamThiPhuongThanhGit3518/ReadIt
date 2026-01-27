import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ReadChapterScreen extends ConsumerWidget {
  const ReadChapterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: SvgPicture.asset(
                        'assets/icons/ic_back.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
                      ),
                    )
                  ),
                  Text(
                    'Chapter 1: The beginning',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Divider(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                thickness: 1,
              ),
              Expanded(
                child: Column()
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                    width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/icons/ic_back.svg',
                                colorFilter: ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
                              )
                          ),
                          Text(
                            'PREVIOUS',
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 12),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/icons/ic_next.svg',
                                colorFilter: ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
                              )
                          ),
                          Text(
                            'NEXT',
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}



