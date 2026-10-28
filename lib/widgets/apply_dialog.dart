import 'package:flutter/material.dart';
import '../models/job.dart';
import '../models/application.dart';

/// Application form dialog to submit candidate profile for a specific job.
class ApplyDialog extends StatefulWidget {
  final Job job;
  final bool isAlreadyApplied;
  final Function(JobApplication) onApplicationSubmitted;
  final VoidCallback onViewApplications;

  const ApplyDialog({
    super.key,
    required this.job,
    required this.isAlreadyApplied,
    required this.onApplicationSubmitted,
    required this.onViewApplications,
  });

  @override
  State<ApplyDialog> createState() => _ApplyDialogState();
}

class _ApplyDialogState extends State<ApplyDialog> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _educationController = TextEditingController();
  final _skillsController = TextEditingController();
  String _selectedGradYear = '2025';

  final List<String> _gradYears = ['2023', '2024', '2025', '2026', '2027'];
  bool _submittedSuccessfully = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _educationController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Validate form inputs
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Safety check for duplicate
    if (widget.isAlreadyApplied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have already applied for this position!'),
          backgroundColor: Colors.orange,
        ),
      );
      Navigator.of(context).pop();
      return;
    }

    // Create new application
    final newApplication = JobApplication(
      id: 'app-${DateTime.now().millisecondsSinceEpoch}',
      jobId: widget.job.id,
      jobTitle: widget.job.title,
      companyName: widget.job.company,
      candidateName: _nameController.text.trim(),
      candidateEmail: _emailController.text.trim(),
      education: _educationController.text.trim(),
      graduationYear: _selectedGradYear,
      skills: _skillsController.text.trim(),
      appliedDate: DateTime.now(),
      status: 'Applied',
    );

    widget.onApplicationSubmitted(newApplication);

    setState(() {
      _submittedSuccessfully = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _submittedSuccessfully
              ? _buildSuccessView(theme)
              : _buildFormView(theme),
        ),
      ),
    );
  }

  /// Success message screen displayed upon successful application submission
  Widget _buildSuccessView(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
            size: 64,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Application Submitted!',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your profile has been successfully sent to ${widget.job.company} for the role of ${widget.job.title}.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme.colorScheme.primary.withAlpha(40)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, size: 20, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Track your status under "My Applications" tab.',
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            const SizedBox(width: 12),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onViewApplications();
              },
              icon: const Icon(Icons.folder_shared_outlined),
              label: const Text('View My Applications'),
            ),
          ],
        ),
      ],
    );
  }

  /// Interactive Form View with input validations
  Widget _buildFormView(ThemeData theme) {
    if (widget.isAlreadyApplied) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, size: 48, color: Colors.orange),
          const SizedBox(height: 12),
          Text(
            'Already Applied',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'You have already submitted an application for ${widget.job.title} at ${widget.job.company}.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onViewApplications();
                },
                child: const Text('Go to My Applications'),
              ),
            ],
          ),
        ],
      );
    }

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Apply for Position',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.job.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.job.company,
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(height: 24),

            // Full Name Field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Candidate Full Name *',
                hintText: 'e.g. John Doe',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your full name';
                }
                if (value.trim().length < 3) {
                  return 'Name must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address *',
                hintText: 'e.g. student@college.edu',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email address';
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value.trim())) {
                  return 'Please enter a valid email format';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Education Degree Field
            TextFormField(
              controller: _educationController,
              decoration: const InputDecoration(
                labelText: 'Education / Degree *',
                hintText: 'e.g. B.Tech Computer Science, BCA, B.Sc IT',
                prefixIcon: Icon(Icons.school_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please specify your degree or education';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Graduation Year Dropdown
            DropdownButtonFormField<String>(
              initialValue: _selectedGradYear,
              decoration: const InputDecoration(
                labelText: 'Graduation Year *',
                prefixIcon: Icon(Icons.calendar_today_outlined),
                border: OutlineInputBorder(),
              ),
              items: _gradYears.map((year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text('Batch $year'),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedGradYear = val;
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            // Candidate Skills Field
            TextFormField(
              controller: _skillsController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Key Skills & Technologies *',
                hintText: 'e.g. Dart, Flutter, Python, SQL, Problem Solving',
                prefixIcon: Icon(Icons.stars_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please list a few of your skills';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.check),
                  label: const Text('Submit Application'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
