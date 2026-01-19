import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // UPDATED APP TITLE HERE
      title: 'Ronan-R-R Portfolio App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F1115),
        primaryColor: const Color(0xFF6C63FF),
        cardColor: const Color(0xFF1E1E2C),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF2563EB),
          surface: Color(0xFF1E1E2C),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// --- SCREEN 1: SPLASH & PERSONAL BRAND ---
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F1115), Color(0xFF1A1A2E)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: Color(0xFF2563EB),
                child: CircleAvatar(
                  radius: 56,
                  backgroundImage: NetworkImage('https://github.com/Ronan-R-R.png'),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Ronan Roberts",
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "SOFTWARE ENGINEER",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainDashboard()),
                    );
                  },
                  child: const Text("View Portfolio", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon(FontAwesomeIcons.linkedin, "https://www.linkedin.com/in/rr-roberts/"),
                  const SizedBox(width: 20),
                  _socialIcon(FontAwesomeIcons.github, "https://github.com/Ronan-R-R"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          shape: BoxShape.circle,
        ),
        child: FaIcon(icon, size: 20, color: Colors.white70),
      ),
    );
  }
}

// --- MAIN DASHBOARD (HANDLES NAVIGATION) ---
class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const ProjectShowcaseScreen(),
    const SkillMatrixScreen(),
    const ExperienceScreen(),
    const ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: const Color(0xFF0F1115),
          selectedItemColor: const Color(0xFF6C63FF),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Projects'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Skills'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Experience'),
            BottomNavigationBarItem(icon: Icon(Icons.email), label: 'Contact'),
          ],
        ),
      ),
    );
  }
}

// --- SCREEN 2: PROJECT SHOWCASE ---
class ProjectShowcaseScreen extends StatelessWidget {
  const ProjectShowcaseScreen({super.key});

  Future<void> _launchProject() async {
    final Uri url = Uri.parse('https://ronan-r-r.github.io');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Work"),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("Featured Project", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),

          // --- FEATURED PROJECT CARD ---
          GestureDetector(
            onTap: _launchProject,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF1E1E2C),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5))
                  ]
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Area
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&q=80"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(
                        child: FaIcon(FontAwesomeIcons.globe, size: 50, color: Colors.white54),
                      ),
                    ),
                  ),

                  // Text Content Area
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: const Color(0xFF6C63FF), borderRadius: BorderRadius.circular(20)),
                              child: const Text("LIVE WEB", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                            const Icon(Icons.arrow_outward, size: 18, color: Colors.grey),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Ronan-R-R.github.io",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "My personal portfolio website hosted on GitHub Pages. Built with HTML, CSS, and JS. Fully responsive.",
                          style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),
          Center(
            child: Text(
              "More projects coming soon...",
              style: TextStyle(color: Colors.grey[700], fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}

// --- SCREEN 3: SKILL MATRIX DASHBOARD ---
class SkillMatrixScreen extends StatelessWidget {
  const SkillMatrixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skill Matrix"),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1A1A2E), Color(0xFF16213E)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatItem(count: "20+", label: "Total Skills"),
                  _StatItem(count: "Fullstack", label: "Core Field"),
                  _StatItem(count: "NQF 6", label: "Level"),
                ],
              ),
            ),
            const SizedBox(height: 30),

            const Text("Technical Skills", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            const _SkillBar(skill: "Flutter & Dart", percentage: 0.90),
            const _SkillBar(skill: "Web Dev (HTML/CSS/JS)", percentage: 0.95),
            const _SkillBar(skill: "Java & C#", percentage: 0.80),
            const _SkillBar(skill: "Azure Fundamentals", percentage: 0.75),

            const SizedBox(height: 30),
            const Text("Soft Skills", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                _TagChip(label: "Team Collaboration"),
                _TagChip(label: "Agile & Scrum"),
                _TagChip(label: "Requirements Analysis"),
                _TagChip(label: "Problem Solving"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count, label;
  const _StatItem({required this.count, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class _SkillBar extends StatelessWidget {
  final String skill;
  final double percentage;
  const _SkillBar({required this.skill, required this.percentage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(skill, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text("${(percentage * 100).toInt()}%", style: const TextStyle(color: Color(0xFF6C63FF))),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[800],
            color: const Color(0xFF6C63FF),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

// --- SCREEN 4: EXPERIENCE ---
class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Experience"), centerTitle: true, backgroundColor: Colors.transparent, automaticallyImplyLeading: false),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _TimelineItem(
            role: "Software Engineer Intern",
            company: "Coast IT Pty(Ltd)",
            date: "Oct 2025 - Nov 2025",
            desc: "Designed and built a full stack application. Contributed to UI design, backend development, and database security.",
            isFirst: true,
          ),
          _TimelineItem(
            role: "Tech Intern",
            company: "Open Vantage",
            date: "June 2025",
            desc: "Business requirements documentation, user story updates, and software modeling activities.",
          ),
          _TimelineItem(
            role: "Freelance Developer",
            company: "Self-Employed",
            date: "2023 - 2024",
            desc: "Web development focusing on client requirements and responsive design.",
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String role, company, date, desc;
  final bool isFirst, isLast;

  const _TimelineItem({
    required this.role,
    required this.company,
    required this.date,
    required this.desc,
    this.isFirst = false,
    this.isLast = false
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12, height: 12,
              decoration: const BoxDecoration(color: Color(0xFF6C63FF), shape: BoxShape.circle),
            ),
            if (!isLast) Container(width: 2, height: 100, color: Colors.grey[800]),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(company, style: const TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.w500)),
                Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Text(desc, style: TextStyle(color: Colors.grey[400], height: 1.4)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// --- SCREEN 5: CONTACT ---
class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _sendEmail() async {
    final String name = _nameController.text;
    final String message = _messageController.text;

    if (name.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in your name and message.")),
      );
      return;
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'ronanr2003@gmail.com',
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Portfolio Inquiry from $name',
        'body': 'Name: $name\n\nMessage:\n$message',
      }),
    );

    if (!await launchUrl(emailLaunchUri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open email client.")),
        );
      }
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact"), centerTitle: true, backgroundColor: Colors.transparent, automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Let's work together!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Find me on social media or drop a message below.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialButton(icon: FontAwesomeIcons.linkedin, label: "LinkedIn", url: "https://www.linkedin.com/in/rr-roberts/"),
                const SizedBox(width: 20),
                _SocialButton(icon: FontAwesomeIcons.github, label: "GitHub", url: "https://github.com/Ronan-R-R"),
              ],
            ),
            const SizedBox(height: 40),

            _CustomTextField(label: "Name", hint: "Your full name", controller: _nameController),
            const SizedBox(height: 15),

            _CustomTextField(label: "Message", hint: "Tell me about your project...", maxLines: 4, controller: _messageController),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _sendEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Open Email Client", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label, hint;
  final int maxLines;
  final TextEditingController? controller;

  const _CustomTextField({
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[800]),
            filled: true,
            fillColor: const Color(0xFF1E1E2C),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialButton({required this.icon, required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2C),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white10),
            ),
            child: FaIcon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
      backgroundColor: const Color(0xFF1E1E2C),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}