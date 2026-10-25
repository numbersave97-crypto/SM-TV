import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const SmTvApp());

const bg = Color(0xFF0B0B14);
const card = Color(0xFF161626);
const pink = Color(0xFFFF2D6F);

class SmTvApp extends StatelessWidget {
  const SmTvApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SM TV',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bg,
          colorScheme: const ColorScheme.dark(primary: pink),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: card,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
          ),
        ),
        routes: {
          '/': (_) => const Splash(),
          '/login': (_) => const AuthPage(signup: false),
          '/signup': (_) => const AuthPage(signup: true),
          '/home': (_) => const MainShell(),
          '/search': (_) => const SearchingPage(),
          '/call': (_) => const CallPage(),
          '/chat': (_) => const ChatPage(),
          '/settings': (_) => const SettingsPage(),
        },
      );
}

class Logo extends StatelessWidget {
  final double size;
  const Logo({super.key, this.size = 90});
  @override
  Widget build(BuildContext context) => Column(children: [
        Icon(Icons.live_tv_rounded, size: size, color: pink),
        Text.rich(TextSpan(children: const [
          TextSpan(text: 'SM '),
          TextSpan(text: 'TV', style: TextStyle(color: pink)),
        ]), style: TextStyle(fontSize: size * 0.45, fontWeight: FontWeight.w900)),
      ]);
}

class PinkBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool outlined;
  final IconData? icon;
  const PinkBtn(this.label, this.onTap,
      {super.key, this.outlined = false, this.icon});
  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon, size: icon == null ? 0 : 20),
          label: Text(label,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: outlined ? Colors.transparent : pink,
            foregroundColor: Colors.white,
            elevation: 0,
            side: outlined ? const BorderSide(color: pink) : null,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
        ),
      );
}

class Splash extends StatelessWidget {
  const Splash({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              const Spacer(),
              const Logo(size: 110),
              const SizedBox(height: 8),
              const Text('Connect with the World',
                  style: TextStyle(color: Colors.white70)),
              const Spacer(),
              PinkBtn('Get Started', () => Navigator.pushNamed(context, '/signup')),
              const SizedBox(height: 12),
              PinkBtn('Login', () => Navigator.pushNamed(context, '/login'),
                  outlined: true),
            ]),
          ),
        ),
      );
}

class AuthPage extends StatelessWidget {
  final bool signup;
  const AuthPage({super.key, required this.signup});

  Widget field(String hint, IconData i, {bool pass = false}) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          obscureText: pass,
          decoration: InputDecoration(hintText: hint, prefixIcon: Icon(i)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    void soon() => ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('শীঘ্রই আসছে')));
    return Scaffold(
      appBar: AppBar(backgroundColor: bg, elevation: 0),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        Text(signup ? 'Create Account' : 'Welcome Back!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        if (signup) field('Full Name', Icons.person_outline),
        field(signup ? 'Email' : 'Email or Username', Icons.email_outlined),
        if (signup) field('Username', Icons.person_outline),
        field('Password', Icons.lock_outline, pass: true),
        const SizedBox(height: 8),
        PinkBtn(signup ? 'Sign Up' : 'Login',
            () => Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false)),
        const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text('OR', style: TextStyle(color: Colors.white54)))),
        PinkBtn('Continue with Google', soon, outlined: true, icon: Icons.g_mobiledata),
        const SizedBox(height: 12),
        PinkBtn('Continue with Facebook', soon, outlined: true, icon: Icons.facebook),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(
              context, signup ? '/login' : '/signup'),
          child: Text(signup
              ? 'Already have an account? Login'
              : "Don't have an account? Sign Up"),
        ),
      ]),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeTab(),
      const Center(child: Text('Users')),
      const ChatList(),
      const ProfileTab(),
    ];
    return Scaffold(
      body: SafeArea(child: pages[i]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: i,
        onTap: (v) => setState(() => i = v),
        backgroundColor: bg,
        selectedItemColor: pink,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  Widget tile(String t, IconData i, Color c) => Container(
        decoration:
            BoxDecoration(color: c, borderRadius: BorderRadius.circular(14)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(i),
          Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
        ]),
      );
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(child: Logo(size: 40)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: card, borderRadius: BorderRadius.circular(16)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Start Random\nVideo Chat',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const Text('Meet new people around the world!',
                  style: TextStyle(color: Colors.white60)),
              const SizedBox(height: 16),
              PinkBtn('Start Chat', () => Navigator.pushNamed(context, '/search'),
                  icon: Icons.videocam),
            ]),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.4,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                tile('Country', Icons.public, Colors.blue),
                tile('Language', Icons.translate, Colors.deepPurple),
                tile('Gender', Icons.wc, Colors.orange),
                tile('Favorites', Icons.favorite, Colors.green),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Online Now',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  8,
                  (_) => const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: CircleAvatar(radius: 26, child: Icon(Icons.person)))),
            ),
          ),
        ],
      );
}

class ChatList extends StatelessWidget {
  const ChatList({super.key});
  @override
  Widget build(BuildContext context) => ListView(children: [
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: const Text('Jessica'),
          subtitle: const Text('Hello 👋'),
          onTap: () => Navigator.pushNamed(context, '/chat'),
        ),
      ]);
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  Widget stat(String n, String l) => Column(children: [
        Text(n, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(l, style: const TextStyle(color: Colors.white54)),
      ]);
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          const Center(child: CircleAvatar(radius: 44, child: Icon(Icons.person, size: 44))),
          const SizedBox(height: 8),
          const Center(
              child: Text('SM Khaled',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          const Center(child: Text('@sm_khaled', style: TextStyle(color: Colors.white54))),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            stat('120', 'Friends'),
            stat('45', 'Followers'),
            stat('12', 'Following'),
          ]),
          const SizedBox(height: 16),
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.pushNamed(context, '/settings')),
          const ListTile(leading: Icon(Icons.card_giftcard), title: Text('My Gifts')),
          const ListTile(leading: Icon(Icons.block), title: Text('Blocked Users')),
          const ListTile(leading: Icon(Icons.warning_amber), title: Text('Report a Problem')),
          ListTile(
              leading: const Icon(Icons.logout, color: pink),
              title: const Text('Logout', style: TextStyle(color: pink)),
              onTap: () =>
                  Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false)),
        ],
      );
}

class SearchingPage extends StatefulWidget {
  const SearchingPage({super.key});
  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  Timer? t;
  @override
  void initState() {
    super.initState();
    t = Timer(const Duration(seconds: 3), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/call');
    });
  }

  @override
  void dispose() {
    t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              const SizedBox(height: 24),
              const Text('Connecting...',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              const SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(color: pink, strokeWidth: 3)),
              const SizedBox(height: 24),
              const Text('Searching for a match...',
                  style: TextStyle(color: Colors.white70)),
              const Spacer(),
              PinkBtn('Cancel', () => Navigator.pop(context), outlined: true),
            ]),
          ),
        ),
      );
}

class CallPage extends StatelessWidget {
  const CallPage({super.key});
  Widget btn(IconData i, String l, VoidCallback f) => Column(children: [
        IconButton(onPressed: f, icon: Icon(i, color: Colors.white)),
        Text(l, style: const TextStyle(fontSize: 11)),
      ]);
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF2A2A4A), Colors.black])),
            child: const Center(
                child: Icon(Icons.person, size: 160, color: Colors.white24)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('SM TV', style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: pink, borderRadius: BorderRadius.circular(8)),
                    child: const Text('LIVE', style: TextStyle(fontSize: 12))),
              ]),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 130,
            child: Container(
              width: 90,
              height: 120,
              decoration: BoxDecoration(
                  color: card,
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.person, color: Colors.white38),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                  color: Colors.black54, borderRadius: BorderRadius.circular(40)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                btn(Icons.mic, 'Mute', () {}),
                btn(Icons.videocam, 'Camera', () {}),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.red,
                  child: IconButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (r) => false),
                      icon: const Icon(Icons.call_end, color: Colors.white)),
                ),
                btn(Icons.chat, 'Chat', () => Navigator.pushNamed(context, '/chat')),
                btn(Icons.skip_next, 'Next',
                    () => Navigator.pushReplacementNamed(context, '/search')),
              ]),
            ),
          ),
        ]),
      );
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final c = TextEditingController();
  final msgs = <List>[
    [false, 'Hello 👋'],
    [true, 'Hi! How are you?'],
  ];
  void send() {
    if (c.text.trim().isEmpty) return;
    setState(() => msgs.add([true, c.text.trim()]));
    c.clear();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: bg,
          title: const Text('Jessica'),
          actions: const [Icon(Icons.videocam), SizedBox(width: 12)],
        ),
        body: Column(children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: msgs
                  .map((m) => Align(
                        alignment: m[0] ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: m[0] ? pink : card,
                              borderRadius: BorderRadius.circular(14)),
                          child: Text(m[1]),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              Expanded(
                  child: TextField(
                      controller: c,
                      onSubmitted: (_) => send(),
                      decoration: const InputDecoration(hintText: 'Type a message...'))),
              IconButton(onPressed: send, icon: const Icon(Icons.send, color: pink)),
            ]),
          ),
        ]),
      );
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool n = true, m = true, c = true;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(backgroundColor: bg, title: const Text('Settings')),
        body: ListView(children: [
          SwitchListTile(
              title: const Text('Notification'),
              value: n,
              onChanged: (v) => setState(() => n = v)),
          SwitchListTile(
              title: const Text('Microphone'),
              value: m,
              onChanged: (v) => setState(() => m = v)),
          SwitchListTile(
              title: const Text('Camera'),
              value: c,
              onChanged: (v) => setState(() => c = v)),
          const ListTile(title: Text('Language'), trailing: Text('English')),
          const ListTile(title: Text('Country'), trailing: Text('All')),
          const ListTile(title: Text('About SM TV')),
        ]),
      );
}
