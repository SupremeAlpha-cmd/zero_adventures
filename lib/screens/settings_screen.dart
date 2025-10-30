import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/providers/audio_provider.dart';
import 'package:zero_adventures/screens/main_shell.dart';
import '../providers/theme_provider.dart';
import 'welcome_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out?'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Log Out'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                // Navigate to the welcome screen and remove all previous routes
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final audioProvider = Provider.of<AudioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Appearance', theme),
            _buildSettingsCard(theme, [
              _buildThemeChooser(context, themeProvider, theme),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('General', theme),
            _buildSettingsCard(theme, [
              _buildSwitchTile(theme, 'Sound Effects', audioProvider.sfxEnabled, (value) {
                audioProvider.toggleSfx(value);
              }),
              _buildSwitchTile(theme, 'Music', audioProvider.musicEnabled, (value) {
                audioProvider.toggleMusic(value);
              }),
              _buildSliderTile(theme, 'Music Volume', audioProvider.musicVolume, (value) {
                audioProvider.setMusicVolume(value);
              }),
              _buildSwitchTile(theme, 'Push Notifications', true, (value) {}),
              _buildNavigationTile(theme, 'Language', Icons.language, () {}),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('Account', theme),
            _buildSettingsCard(theme, [
              _buildNavigationTile(theme, 'Account Details', Icons.person_outline, () {
                Navigator.pushNamed(context, '/profile');
              }),
              _buildNavigationTile(theme, 'Change Password', Icons.lock_outline, () {}),
              _buildNavigationTile(theme, 'Link Social Accounts', Icons.share_outlined, () {}),
            ]),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () => _showLogoutConfirmationDialog(context),
                child: Text(
                  'Log Out',
                  style: TextStyle(color: theme.colorScheme.error, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Support & Legal', theme),
            _buildSettingsCard(theme, [
              _buildNavigationTile(theme, 'Help & FAQ', Icons.help_outline, () {}),
              _buildNavigationTile(theme, 'Report a Bug', Icons.bug_report_outlined, () {}),
              _buildNavigationTile(theme, 'Privacy Policy', Icons.shield_outlined, () {}),
              _buildNavigationTile(theme, 'Terms of Service', Icons.description_outlined, () {}),
            ]),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Zero Adventures v1.0.0',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeChooser(
    BuildContext context,
    ThemeProvider themeProvider,
    ThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildThemeOption(context, themeProvider, 'Light', ThemeMode.light, Icons.wb_sunny),
              _buildThemeOption(context, themeProvider, 'Dark', ThemeMode.dark, Icons.nightlight_round),
              _buildThemeOption(context, themeProvider, 'System', ThemeMode.system, Icons.settings_brightness),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    ThemeProvider themeProvider,
    String title,
    ThemeMode mode,
    IconData icon,
  ) {
    final bool isSelected = themeProvider.themeMode == mode;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => themeProvider.setThemeMode(mode),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary.withOpacity(0.2) : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.grey.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? theme.colorScheme.primary : theme.iconTheme.color),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyLarge?.color)),
          ],
        ),
      ),
    );
  }

  Padding _buildSectionHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Card _buildSettingsCard(ThemeData theme, List<Widget> children) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(children: children),
    );
  }

  ListTile _buildNavigationTile(ThemeData theme, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: theme.iconTheme.color),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  SwitchListTile _buildSwitchTile(
    ThemeData theme,
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: theme.colorScheme.primary,
    );
  }

  Padding _buildSliderTile(
    ThemeData theme,
    String title,
    double value,
    ValueChanged<double> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Row(
            children: [
              Expanded(
                child: CupertinoSlider(
                  value: value,
                  onChanged: onChanged,
                  min: 0.0,
                  max: 1.0,
                  activeColor: theme.colorScheme.primary,
                  thumbColor: theme.colorScheme.primary,
                ),
              ),
              Text('${(value * 100).toInt()}%'),
            ],
          ),
        ],
      ),
    );
  }
}
