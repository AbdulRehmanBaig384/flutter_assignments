import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _nameController = TextEditingController(text: 'Abdul Rehman');
  final _studentIdController = TextEditingController(text: 'B23110106004');

  // State values
  String? _selectedDepartment = 'Computer Science & Engineering';
  String _selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully!'),
          backgroundColor: AppTheme.primaryBlue,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundGrey,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: AppTheme.primaryBlue),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: const Text(
          'UBIT Hub',
          style: TextStyle(
            color: AppTheme.primaryBlue,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.textDark,
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'STUDENT ACCOUNT',
                  style: TextStyle(
                    color: AppTheme.accentBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Abdul Rehman',
                  style: TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Computer Science & Engineering · Class of 2025',
                  style: TextStyle(
                    color: AppTheme.textMedium,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                // Verified Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFBFCFFF)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_outlined,
                          size: 16, color: AppTheme.accentBlue),
                      SizedBox(width: 6),
                      Text(
                        'Verified Student',
                        style: TextStyle(
                          color: AppTheme.accentBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Tab Bar
                TabBar(
                  controller: _tabController,
                  labelColor: AppTheme.primaryBlue,
                  unselectedLabelColor: AppTheme.textMedium,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(fontSize: 14),
                  indicatorColor: AppTheme.primaryBlue,
                  indicatorWeight: 2.5,
                  tabs: const [
                    Tab(text: 'Personal Info'),
                    Tab(text: 'My Listings'),
                    Tab(text: 'Settings'),
                  ],
                ),
              ],
            ),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Tab 1: Personal Info
                _PersonalInfoTab(
                  formKey: _formKey,
                  nameController: _nameController,
                  studentIdController: _studentIdController,
                  selectedDepartment: _selectedDepartment,
                  selectedGender: _selectedGender,
                  onDepartmentChanged: (val) =>
                      setState(() => _selectedDepartment = val),
                  onGenderChanged: (val) =>
                      setState(() => _selectedGender = val ?? 'Male'),
                  onSave: _handleSave,
                  onCancel: () {},
                ),

                // Tab 2: My Listings placeholder
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.storefront_outlined,
                          size: 64, color: AppTheme.textLight),
                      SizedBox(height: 16),
                      Text(
                        'No listings yet',
                        style: TextStyle(
                          color: AppTheme.textMedium,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Start selling on the marketplace!',
                        style: TextStyle(
                          color: AppTheme.textLight,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // Tab 3: Settings placeholder
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings_outlined,
                          size: 64, color: AppTheme.textLight),
                      SizedBox(height: 16),
                      Text(
                        'Settings',
                        style: TextStyle(
                          color: AppTheme.textMedium,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalInfoTab extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController studentIdController;
  final String? selectedDepartment;
  final String selectedGender;
  final ValueChanged<String?> onDepartmentChanged;
  final ValueChanged<String?> onGenderChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const _PersonalInfoTab({
    required this.formKey,
    required this.nameController,
    required this.studentIdController,
    required this.selectedDepartment,
    required this.selectedGender,
    required this.onDepartmentChanged,
    required this.onGenderChanged,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Identity Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.cardWhite,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card header
                  const Row(
                    children: [
                      Icon(Icons.badge_outlined,
                          color: AppTheme.primaryBlue, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Profile Identity',
                        style: TextStyle(
                          color: AppTheme.textDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Full Name
                  _FieldLabel('Full Name'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: nameController,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Name is required' : null,
                    decoration: const InputDecoration(
                      hintText: 'Enter your full name',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Student ID
                  _FieldLabel('Student ID'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: studentIdController,
                    validator: (v) => v == null || v.isEmpty
                        ? 'Student ID is required'
                        : null,
                    decoration: const InputDecoration(
                      hintText: 'Enter your student ID',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Department Selection
                  _FieldLabel('Department Selection'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedDepartment,
                    validator: (v) =>
                        v == null ? 'Please select a department' : null,
                    decoration: const InputDecoration(
                      hintText: 'Select department',
                    ),
                    onChanged: onDepartmentChanged,
                    items: departments
                        .map((dept) => DropdownMenuItem(
                              value: dept,
                              child: Text(
                                dept,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ))
                        .toList(),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: AppTheme.textMedium),
                  ),
                  const SizedBox(height: 16),

                  // Gender Identification
                  _FieldLabel('Gender Identification'),
                  const SizedBox(height: 8),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: ['Male', 'Female', 'Non-binary'].map((gender) {
                      return RadioListTile<String>(
                        value: gender,
                        groupValue: selectedGender,
                        onChanged: onGenderChanged,
                        title: Text(
                          gender,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textDark,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        activeColor: AppTheme.primaryBlue,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryBlue,
                    side: const BorderSide(color: AppTheme.primaryBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onSave,
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Profile Strength Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryBlue.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background circle decoration
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profile Strength',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '85%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        value: 0.85,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Complete your profile to unlock premium marketplace features and campus discounts.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Privacy Note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border(
                left: BorderSide(
                  color: AppTheme.primaryBlue,
                  width: 4,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Privacy Note',
                  style: TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Your department information helps us tailor marketplace recommendations and campus alerts.',
                  style: TextStyle(
                    color: AppTheme.textMedium,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppTheme.textDark,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
