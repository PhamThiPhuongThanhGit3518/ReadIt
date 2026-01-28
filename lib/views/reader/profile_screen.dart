import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/auth_providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return userAsync.when(
      data: (user) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
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
                            colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
                          ),
                        ),
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
                        child: const Icon(Icons.person, size: 80, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                Center(
                  child: Text(
                      user.username ?? "Đang tải...",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
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
                  itemCount: _title.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
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
                        colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                    height: 1,
                    thickness: 1,
                  ),
                ),
                const SizedBox(height: 32),

                GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('auth_token');

                    if (context.mounted) {
                      context.go('/sign_in');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF261D25),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFF0000).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_logout.svg',
                          width: 24,
                          colorFilter: const ColorFilter.mode(Color(0xFFBA1313), BlendMode.srcIn),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Log out',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: const Color(0xFFBA1313),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      loading: () => const Scaffold(
        backgroundColor: Color(0xFF0F151C),
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        backgroundColor: const Color(0xFF0F151C),
        body: Center(
          child: Text('Lỗi tải dữ liệu: $err', style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}