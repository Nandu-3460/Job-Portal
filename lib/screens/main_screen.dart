import 'package:flutter/material.dart';
import '../models/job.dart';
import '../models/application.dart';
import '../data/sample_jobs.dart';
import '../widgets/job_details_dialog.dart';
import '../widgets/apply_dialog.dart';
import 'home_tab.dart';
import 'find_jobs_tab.dart';
import 'my_applications_tab.dart';
import 'about_tab.dart';

/// Main scaffold managing application state, navigation tabs, and modal dialogs.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTabIndex = 0;
  String _findJobsSearchQuery = '';

  // In-memory application storage (StatefulWidget state)
  final List<JobApplication> _applications = [];

  // Quick lookup set for applied jobs
  Set<String> get _appliedJobIds => _applications.map((a) => a.jobId).toSet();

  void _onTabSelected(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  void _onSearchFromHome(String query) {
    setState(() {
      _findJobsSearchQuery = query;
      _currentTabIndex = 1; // Switch to Find Jobs Tab
    });
  }

  void _handleJobDetails(Job job) {
    showDialog(
      context: context,
      builder: (context) => JobDetailsDialog(
        job: job,
        isAlreadyApplied: _appliedJobIds.contains(job.id),
        onApply: () => _handleApply(job),
      ),
    );
  }

  void _handleApply(Job job) {
    showDialog(
      context: context,
      builder: (context) => ApplyDialog(
        job: job,
        isAlreadyApplied: _appliedJobIds.contains(job.id),
        onApplicationSubmitted: (application) {
          setState(() {
            _applications.add(application);
          });
        },
        onViewApplications: () {
          setState(() {
            _currentTabIndex = 2; // Switch to My Applications Tab
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Crisp modern off-white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        titleSpacing: 20,
        title: InkWell(
          onTap: () => _onTabSelected(0),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.school, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FreshGrad Jobs',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(
                      'College Capstone Project',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: isDesktop
            ? [
                _NavButton(
                  title: 'Home',
                  icon: Icons.home_outlined,
                  isSelected: _currentTabIndex == 0,
                  onTap: () => _onTabSelected(0),
                ),
                _NavButton(
                  title: 'Find Jobs',
                  icon: Icons.work_outline,
                  isSelected: _currentTabIndex == 1,
                  onTap: () => _onTabSelected(1),
                ),
                _NavButton(
                  title: 'My Applications',
                  icon: Icons.assignment_outlined,
                  isSelected: _currentTabIndex == 2,
                  badgeCount: _applications.length,
                  onTap: () => _onTabSelected(2),
                ),
                _NavButton(
                  title: 'About & SDG',
                  icon: Icons.info_outline,
                  isSelected: _currentTabIndex == 3,
                  onTap: () => _onTabSelected(3),
                ),
                const SizedBox(width: 16),
              ]
            : null,
      ),
      drawer: isDesktop
          ? null
          : Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.school, size: 40, color: Colors.white),
                        const SizedBox(height: 10),
                        const Text(
                          'FreshGrad Jobs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Job Portal for Fresh Graduates',
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home_outlined),
                    title: const Text('Home'),
                    selected: _currentTabIndex == 0,
                    onTap: () {
                      Navigator.pop(context);
                      _onTabSelected(0);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: const Text('Find Jobs'),
                    selected: _currentTabIndex == 1,
                    onTap: () {
                      Navigator.pop(context);
                      _onTabSelected(1);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.assignment_outlined),
                    title: const Text('My Applications'),
                    trailing: _applications.isNotEmpty
                        ? Badge.count(count: _applications.length)
                        : null,
                    selected: _currentTabIndex == 2,
                    onTap: () {
                      Navigator.pop(context);
                      _onTabSelected(2);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About & SDG'),
                    selected: _currentTabIndex == 3,
                    onTap: () {
                      Navigator.pop(context);
                      _onTabSelected(3);
                    },
                  ),
                ],
              ),
            ),
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          HomeTab(
            jobs: sampleJobs,
            appliedJobIds: _appliedJobIds,
            onSearchSubmitted: _onSearchFromHome,
            onViewJobDetails: _handleJobDetails,
            onApplyToJob: _handleApply,
            onNavigateToFindJobs: () => _onTabSelected(1),
          ),
          FindJobsTab(
            jobs: sampleJobs,
            appliedJobIds: _appliedJobIds,
            initialSearchQuery: _findJobsSearchQuery,
            onViewJobDetails: _handleJobDetails,
            onApplyToJob: _handleApply,
          ),
          MyApplicationsTab(
            applications: _applications,
            onBrowseJobs: () => _onTabSelected(1),
          ),
          const AboutTab(),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : NavigationBar(
              selectedIndex: _currentTabIndex,
              onDestinationSelected: _onTabSelected,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.work_outline),
                  selectedIcon: Icon(Icons.work),
                  label: 'Find Jobs',
                ),
                NavigationDestination(
                  icon: _applications.isNotEmpty
                      ? Badge.count(
                          count: _applications.length,
                          child: const Icon(Icons.assignment_outlined),
                        )
                      : const Icon(Icons.assignment_outlined),
                  selectedIcon: _applications.isNotEmpty
                      ? Badge.count(
                          count: _applications.length,
                          child: const Icon(Icons.assignment),
                        )
                      : const Icon(Icons.assignment),
                  label: 'Applications',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.info_outline),
                  selectedIcon: Icon(Icons.info),
                  label: 'About',
                ),
              ],
            ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final int badgeCount;
  final VoidCallback onTap;

  const _NavButton({
    required this.title,
    required this.icon,
    required this.isSelected,
    this.badgeCount = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget iconWidget = Icon(
      icon,
      size: 18,
      color: isSelected ? theme.colorScheme.primary : Colors.grey.shade700,
    );

    if (badgeCount > 0) {
      iconWidget = Badge.count(
        count: badgeCount,
        child: iconWidget,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton.icon(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? theme.colorScheme.primary : Colors.grey.shade800,
          backgroundColor: isSelected ? theme.colorScheme.primary.withAlpha(20) : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: iconWidget,
        label: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 13.5,
          ),
        ),
      ),
    );
  }
}
