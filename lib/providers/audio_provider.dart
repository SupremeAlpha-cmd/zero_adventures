import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  late AudioPlayer _musicPlayer;

  bool _musicEnabled = true;
  bool _sfxEnabled = true;
  double _musicVolume = 0.5;
  double _sfxVolume = 0.5;

  AudioProvider(this.sharedPreferences) {
    _musicPlayer = AudioPlayer();
    _loadPreferences();
  }

  // Getters
  bool get musicEnabled => _musicEnabled;
  bool get sfxEnabled => _sfxEnabled;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;

  // Setters
  void toggleMusic(bool value) {
    _musicEnabled = value;
    if (_musicEnabled) {
      playMusic();
    } else {
      stopMusic();
    }
    _savePreferences();
    notifyListeners();
  }

  void toggleSfx(bool value) {
    _sfxEnabled = value;
    _savePreferences();
    notifyListeners();
  }

  void setMusicVolume(double volume) {
    _musicVolume = volume;
    _musicPlayer.setVolume(volume);
    _savePreferences();
    notifyListeners();
  }

  void setSfxVolume(double volume) {
    _sfxVolume = volume;
    _savePreferences();
    notifyListeners();
  }

  // Methods
  Future<void> playMusic() async {
    if (_musicEnabled) {
      _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.play(AssetSource('music/background.mp3'));
    }
  }

  Future<void> stopMusic() async {
    await _musicPlayer.stop();
  }

  Future<void> playSfx(String sfx) async {
    if (_sfxEnabled) {
      final sfxPlayer = AudioPlayer();
      await sfxPlayer.setVolume(_sfxVolume);
      await sfxPlayer.play(AssetSource('sfx/$sfx'));
    }
  }

  // Persistence
  void _loadPreferences() {
    _musicEnabled = sharedPreferences.getBool('musicEnabled') ?? true;
    _sfxEnabled = sharedPreferences.getBool('sfxEnabled') ?? true;
    _musicVolume = sharedPreferences.getDouble('musicVolume') ?? 0.5;
    _sfxVolume = sharedPreferences.getDouble('sfxVolume') ?? 0.5;

    setMusicVolume(_musicVolume);
    setSfxVolume(_sfxVolume);
  }

  void _savePreferences() {
    sharedPreferences.setBool('musicEnabled', _musicEnabled);
    sharedPreferences.setBool('sfxEnabled', _sfxEnabled);
    sharedPreferences.setDouble('musicVolume', _musicVolume);
    sharedPreferences.setDouble('sfxVolume', _sfxVolume);
  }
}
