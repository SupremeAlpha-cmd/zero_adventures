import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _soundEffects = true;
  bool _music = false;
  double _musicVolume = 0.75;
  bool _pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final primaryColor = isDarkMode ? const Color(0xFF4A4E69) : theme.primaryColor;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: textColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('General', textColor),
            _buildSettingsCard(
              primaryColor,
              [
                _buildSwitchTile('Sound Effects', _soundEffects, (value) => setState(() => _soundEffects = value), textColor, primaryColor),
                _buildSwitchTile('Music', _music, (value) => setState(() => _music = value), textColor, primaryColor),
                _buildSliderTile('Music Volume', _musicVolume, (value) => setState(() => _musicVolume = value), textColor, primaryColor),
                _buildSwitchTile('Push Notifications', _pushNotifications, (value) => setState(() => _pushNotifications = value), textColor, primaryColor),
                _buildNavigationTile('Language', Icons.language, textColor, primaryColor, () {}),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Account', textColor),
            _buildSettingsCard(
              primaryColor,
              [
                _buildNavigationTile('Account Details', Icons.person_outline, textColor, primaryColor, () {}),
                _buildNavigationTile('Change Password', Icons.lock_outline, textColor, primaryColor, () {}),
                _buildNavigationTile('Link Social Accounts', Icons.share_outlined, textColor, primaryColor, () {}),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Support & Legal', textColor),
            _buildSettingsCard(
              primaryColor,
              [
                _buildNavigationTile('Help & FAQ', Icons.help_outline, textColor, primaryColor, () {}),
                _buildNavigationTile('Report a Bug', Icons.bug_report_outlined, textColor, primaryColor, () {}),
                _buildNavigationTile('Privacy Policy', Icons.shield_outlined, textColor, primaryColor, () {}),
                _buildNavigationTile('Terms of Service', Icons.description_outlined, textColor, primaryColor, () {}),
              ],
            ),
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

  Padding _buildSectionHeader(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
    );
  }

  Card _buildSettingsCard(Color cardColor, List<Widget> children) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(children: children),
    );
  }

  ListTile _buildNavigationTile(String title, IconData icon, Color textColor, Color iconColor, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  SwitchListTile _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged, Color textColor, Color activeColor) {
    return SwitchListTile.adaptive(
      title: Text(title, style: TextStyle(color: textColor)),
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
      inactiveThumbColor: Colors.grey,
    );
  }

   Padding _buildSliderTile(String title, double value, ValueChanged<double> onChanged, Color textColor, Color activeColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: textColor)),
          Row(
            children: [
              Expanded(
                child: CupertinoSlider(
                  value: value,
                  onChanged: onChanged,
                  min: 0.0,
                  max: 1.0,
                  activeColor: activeColor,
                  thumbColor: activeColor,
                ),
              ),
              Text('${(value * 100).toInt()}%', style: TextStyle(color: textColor)),
            ],
          ),
        ],
      ),
    );
  }
}
