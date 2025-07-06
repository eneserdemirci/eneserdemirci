import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_simulation_game/core/router/app_router.dart';
import 'package:life_simulation_game/core/theme/app_theme.dart';
import 'package:life_simulation_game/features/character/domain/entities/character_entity.dart';

/// Character creation form widget
class CharacterCreationForm extends ConsumerStatefulWidget {
  final String userId;

  const CharacterCreationForm({
    required this.userId,
    super.key,
  });

  @override
  ConsumerState<CharacterCreationForm> createState() => _CharacterCreationFormState();
}

class _CharacterCreationFormState extends ConsumerState<CharacterCreationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  
  Gender _selectedGender = Gender.male;
  DateTime _birthDate = DateTime.now().subtract(const Duration(days: 365 * 20));
  String _selectedCareer = 'Student';
  
  final List<String> _careers = [
    'Student',
    'Artist',
    'Engineer',
    'Doctor',
    'Teacher',
    'Lawyer',
    'Chef',
    'Musician',
    'Athlete',
    'Writer',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Character Name
          Text(
            'Character Name',
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Enter your character\'s name',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a character name';
              }
              if (value.trim().length < 2) {
                return 'Name must be at least 2 characters';
              }
              if (value.trim().length > 50) {
                return 'Name must be less than 50 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          
          // Gender Selection
          Text(
            'Gender',
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: Gender.values.map((gender) {
              return Expanded(
                child: RadioListTile<Gender>(
                  title: Text(_getGenderDisplayName(gender)),
                  value: gender,
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          
          // Birth Date
          Text(
            'Birth Date',
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: _selectBirthDate,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 12),
                  Text(
                    '${_birthDate.day}/${_birthDate.month}/${_birthDate.year}',
                    style: context.textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Career Selection
          Text(
            'Starting Career',
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedCareer,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.work),
            ),
            items: _careers.map((career) {
              return DropdownMenuItem(
                value: career,
                child: Text(career),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCareer = value!;
              });
            },
          ),
          const SizedBox(height: 32),
          
          // Age Display
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Character Info',
                    style: context.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('Age: ${_calculateAge()} years old'),
                  Text('Gender: ${_getGenderDisplayName(_selectedGender)}'),
                  Text('Career: $_selectedCareer'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          // Create Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onCreateCharacter,
              child: const Text(
                'Create Character',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getGenderDisplayName(Gender gender) {
    switch (gender) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
    }
  }

  int _calculateAge() {
    final now = DateTime.now();
    int age = now.year - _birthDate.year;
    if (now.month < _birthDate.month ||
        (now.month == _birthDate.month && now.day < _birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> _selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  void _onCreateCharacter() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement character creation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Character creation will be implemented soon!'),
        ),
      );
      
      // Navigate to dashboard for now
      context.go(AppRouter.dashboard);
    }
  }
}