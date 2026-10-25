import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';
import '../core/app_strings.dart';
import '../models/event_item.dart';
import '../widgets/onboarding_controls.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  EventCategory _selectedCategory = EventCategory.sport;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedLocation;

  final List<String> _availableLocations = [
    'Cairo, Egypt',
    'Alexandria, Egypt',
    'Giza, Egypt',
    'Maadi, Cairo',
    'Zamalek, Cairo',
    'New Cairo, Egypt',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _getCategoryLightImage(EventCategory category) {
    switch (category) {
      case EventCategory.sport:
        return AppAssets.sportLight;
      case EventCategory.bookClub:
        return AppAssets.bookClubLight;
      case EventCategory.birthday:
        return AppAssets.birthdayLight;
      case EventCategory.meeting:
        return AppAssets.meetingLight;
      case EventCategory.exhibition:
        return AppAssets.exhibitionLight;
    }
  }

  String _getCategoryDarkImage(EventCategory category) {
    switch (category) {
      case EventCategory.sport:
        return AppAssets.sportDark;
      case EventCategory.bookClub:
        return AppAssets.bookClubDark;
      case EventCategory.birthday:
        return AppAssets.birthdayDark;
      case EventCategory.meeting:
        return AppAssets.meetingDark;
      case EventCategory.exhibition:
        return AppAssets.exhibitionDark;
    }
  }

  String _getCategoryLabel(EventCategory category, AppStrings strings) {
    switch (category) {
      case EventCategory.sport:
        return strings.sport;
      case EventCategory.bookClub:
        return strings.bookClub;
      case EventCategory.birthday:
        return strings.birthday;
      case EventCategory.meeting:
        return strings.meeting;
      case EventCategory.exhibition:
        return strings.exhibition;
    }
  }

  IconData _getCategoryIcon(EventCategory category) {
    switch (category) {
      case EventCategory.sport:
        return Icons.sports_volleyball_outlined;
      case EventCategory.bookClub:
        return Icons.menu_book_outlined;
      case EventCategory.birthday:
        return Icons.cake_outlined;
      case EventCategory.meeting:
        return Icons.business_outlined;
      case EventCategory.exhibition:
        return Icons.palette_outlined;
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submit() {
    final strings = AppStrings.of(context);

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(strings.dateRequired),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(strings.locationRequired),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final date = _selectedDate!;
    final dayStr = date.day.toString().padLeft(2, '0');
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final monthStr = monthNames[date.month - 1];

    final timeStr = _selectedTime?.format(context);


    final newEvent = EventItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      day: dayStr,
      month: monthStr,
      category: _selectedCategory,
      lightImage: _getCategoryLightImage(_selectedCategory),
      darkImage: _getCategoryDarkImage(_selectedCategory),
      description: _descriptionController.text.trim(),
      location: _selectedLocation,
      time: timeStr,
    );

    final provider = EventScope.of(context);
    provider.addEvent(newEvent);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(strings.eventCreatedSuccessfully),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final strings = AppStrings.of(context);

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: isDark ? AppColors.primary : AppColors.grey.withValues(alpha: 0.4),
        width: 1.2,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 1.5,
      ),
    );

    final currentImage = isDark
        ? _getCategoryDarkImage(_selectedCategory)
        : _getCategoryLightImage(_selectedCategory);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          strings.createEvent,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Event Image Preview
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primary, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.5),
                        child: Image.asset(
                          currentImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: isDark ? const Color(0xFF101127) : Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.broken_image, color: AppColors.primary, size: 40),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Categories Selector
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: EventCategory.values.map((category) {
                          final isSelected = category == _selectedCategory;
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(end: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : (isDark ? const Color(0xFF101127) : Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 1.2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getCategoryIcon(category),
                                      size: 18,
                                      color: isSelected ? Colors.white : AppColors.primary,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      _getCategoryLabel(category, strings),
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : AppColors.primary,
                                        fontSize: 14,
                                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title Field
                    Text(
                      strings.eventTitle,
                      style: TextStyle(
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _titleController,
                      style: TextStyle(
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                      decoration: InputDecoration(
                        hintText: strings.enterEventTitle,
                        hintStyle: const TextStyle(color: AppColors.grey, fontSize: 14),
                        prefixIcon: const Icon(Icons.edit_note, color: AppColors.primary),
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: focusedBorder,
                        filled: true,
                        fillColor: isDark ? const Color(0xFF101127) : Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return strings.eventTitleRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Description Field
                    Text(
                      strings.description,
                      style: TextStyle(
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      style: TextStyle(
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                      ),
                      decoration: InputDecoration(
                        hintText: strings.enterDescription,
                        hintStyle: const TextStyle(color: AppColors.grey, fontSize: 14),
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: focusedBorder,
                        filled: true,
                        fillColor: isDark ? const Color(0xFF101127) : Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return strings.descriptionRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Date & Time Row
                    Row(
                      children: [
                        // Date picker button
                        Expanded(
                          child: InkWell(
                            onTap: _pickDate,
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF101127) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isDark ? AppColors.primary : AppColors.grey.withValues(alpha: 0.4),
                                  width: 1.2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_month, color: AppColors.primary, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _selectedDate == null
                                          ? strings.chooseDate
                                          : '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}',
                                      style: TextStyle(

                                        color: _selectedDate == null
                                            ? AppColors.grey
                                            : (isDark ? AppColors.darkText : AppColors.lightText),
                                        fontSize: 14,
                                        fontWeight: _selectedDate == null ? FontWeight.w400 : FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Time picker button
                        Expanded(
                          child: InkWell(
                            onTap: _pickTime,
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF101127) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isDark ? AppColors.primary : AppColors.grey.withValues(alpha: 0.4),
                                  width: 1.2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.access_time, color: AppColors.primary, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _selectedTime == null
                                          ? strings.chooseTime
                                          : _selectedTime!.format(context),
                                      style: TextStyle(
                                        color: _selectedTime == null
                                            ? AppColors.grey
                                            : (isDark ? AppColors.darkText : AppColors.lightText),
                                        fontSize: 14,
                                        fontWeight: _selectedTime == null ? FontWeight.w400 : FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Location Dropdown / Selector
                    Text(
                      strings.location,
                      style: TextStyle(
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedLocation,
                      hint: Text(

                        strings.chooseEventLocation,
                        style: const TextStyle(color: AppColors.grey, fontSize: 14),
                      ),
                      dropdownColor: isDark ? const Color(0xFF101127) : Colors.white,
                      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.primary),
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: focusedBorder,
                        filled: true,
                        fillColor: isDark ? const Color(0xFF101127) : Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      items: _availableLocations.map((loc) {
                        return DropdownMenuItem<String>(
                          value: loc,
                          child: Text(
                            loc,
                            style: TextStyle(
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedLocation = val;
                        });
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return strings.locationRequired;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 28),

                    // Create Event Button
                    AppPrimaryButton(
                      label: strings.createEvent,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
