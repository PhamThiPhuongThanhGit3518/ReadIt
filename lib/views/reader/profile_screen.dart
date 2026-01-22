import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const SizedBox(height: 48),
                    Text(
                      'Profile',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20),
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/icons/ic_setting.svg',
                          colorFilter: ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
                        )
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.asset(
                    'assets/images/mountain.jpeg',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 140,
                      height: 140,
                      color: Colors.grey,
                      child: const Icon(Icons.person, size: 80),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: Text(
                  'Phuong Thanh',
                  style: Theme.of(context).textTheme.displayLarge,
                )
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: Text(
                  ' Information',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
                ),
              ),
              Divider(
                thickness: 1,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              ),
              ListView.separated(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(
                          _iconpath[index],
                          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    title: Text(
                      _title[index],
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    trailing: SvgPicture.asset(
                      'assets/icons/ic_route.svg',
                      colorFilter: ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                        height: 1,
                        thickness: 1
                    ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF261D25),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFFFF0000).withOpacity(0.2),
                    width: 1
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      width: 24,
                      'assets/icons/ic_logout.svg',
                      colorFilter: ColorFilter.mode(Color(0xFFBA1313), BlendMode.srcIn),
                    ),
                    Text(
                      '  Log out',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Color(
                          0xFFBA1313), fontWeight: FontWeight.bold)
                    )
                  ]
                ),
              )
            ],
          )
        )
      )
    );
  }
}

final List<String> _iconpath = [
  'assets/icons/ic_term.svg',
  'assets/icons/ic_clause.svg',
  'assets/icons/ic_question.svg',
  'assets/icons/ic_star.svg'
];

final List<String> _title = [
  'Privacy Policy',
  'Terms of Use',
  'Support & Report',
  'Rate App'
];
