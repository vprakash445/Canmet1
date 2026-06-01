import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

// ─── Language Provider ────────────────────────────────────────────────────────

class LanguageProvider extends ChangeNotifier {
  String _lang = 'en';

  String get lang => _lang;
  bool get isHindi => _lang == 'hi';

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _lang = prefs.getString('lang') ?? 'en';
    notifyListeners();
  }

  Future<void> setLanguage(String l) async {
    if (_lang == l) return;
    _lang = l;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', l);
    notifyListeners();
  }

  void toggle() => setLanguage(_lang == 'en' ? 'hi' : 'en');
}

// ─── User Provider ────────────────────────────────────────────────────────────

class UserProvider extends ChangeNotifier {
  String _name = '';
  String _patientId = '';
  String _cancerType = '';
  String _age = '';
  String _gender = '';
  String _hospitalId = '';
  String _mobile = '';
  int _treatmentDay = 1;
  bool _isLoggedIn = false;
  bool _isOnline = false;

  String get name => _name;
  String get patientId => _patientId;
  String get cancerType => _cancerType;
  String get age => _age;
  String get gender => _gender;
  String get hospitalId => _hospitalId;
  String get mobile => _mobile;
  int get treatmentDay => _treatmentDay;
  bool get isLoggedIn => _isLoggedIn;
  bool get isOnline => _isOnline;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn   = prefs.getBool('logged_in') ?? false;
    _name         = prefs.getString('name') ?? '';
    _patientId    = prefs.getString('patient_id') ?? '';
    _cancerType   = prefs.getString('cancer_type') ?? '';
    _age          = prefs.getString('age') ?? '';
    _gender       = prefs.getString('gender') ?? '';
    _hospitalId   = prefs.getString('hospital_id') ?? '';
    _mobile       = prefs.getString('mobile') ?? '';
    _treatmentDay = prefs.getInt('treatment_day') ?? 1;
    notifyListeners();

    // Check online status silently
    ApiService.instance.isOnline().then((online) {
      _isOnline = online;
      notifyListeners();
    });
  }

  // ── Register ────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> register({
    required String name,
    required String age,
    required String gender,
    required String cancerType,
    required String hospitalId,
    required String mobile,
    required String password,
    required String language,
  }) async {
    final response = await ApiService.instance.register(
      name: name, age: age, gender: gender,
      cancerType: cancerType, hospitalId: hospitalId,
      mobile: mobile, password: password, language: language,
    );

    if (response.success && response.data != null) {
      final data = response.data!;
      await _saveLocally(
        name: data['name'] ?? name,
        patientId: data['patient_id'] ?? '',
        cancerType: cancerType, age: age, gender: gender,
        hospitalId: hospitalId, mobile: mobile,
        treatmentDay: (data['treatment_day'] ?? 1) as int,
        token: data['token']?.toString(),
      );
      return {'success': true, 'message': 'Registration successful'};
    } else {
      // Offline fallback
      final localId = 'CNM-${DateTime.now().millisecondsSinceEpoch % 90000 + 10000}';
      await _saveLocally(
        name: name, patientId: localId, cancerType: cancerType,
        age: age, gender: gender, hospitalId: hospitalId,
        mobile: mobile, treatmentDay: 1, token: null,
      );
      return {
        'success': true,
        'offline': true,
        'message': 'Registered offline. Will sync when online.',
      };
    }
  }

  // ── Login ───────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> login(
      String patientId, String password) async {
    final response = await ApiService.instance.login(
      patientId: patientId,
      password: password,
    );

    if (response.success && response.data != null) {
      final data = response.data!;
      await _saveLocally(
        name: data['name'] ?? 'Patient',
        patientId: data['patient_id'] ?? patientId,
        cancerType: data['cancer_type'] ?? '',
        age: (data['age'] ?? '').toString(),
        gender: data['gender'] ?? '',
        hospitalId: data['hospital_id'] ?? '',
        mobile: data['mobile'] ?? '',
        treatmentDay: (data['treatment_day'] ?? 1) as int,
        token: data['token']?.toString(),
      );
      return {'success': true};
    }

    // Offline login — accept if same patient was logged in before
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getString('patient_id') ?? '';
    if (savedId == patientId && prefs.getBool('logged_in') == true) {
      _isLoggedIn = true;
      notifyListeners();
      return {'success': true, 'offline': true,
        'message': 'Offline login. Some features limited.'};
    }

    return {
      'success': false,
      'message': response.message.isNotEmpty
          ? response.message
          : 'Invalid credentials',
    };
  }

  // ── Save locally ────────────────────────────────────────────────────

  Future<void> _saveLocally({
    required String name,
    required String patientId,
    required String cancerType,
    required String age,
    required String gender,
    required String hospitalId,
    required String mobile,
    required int treatmentDay,
    String? token,
  }) async {
    _name = name; _patientId = patientId; _cancerType = cancerType;
    _age = age; _gender = gender; _hospitalId = hospitalId;
    _mobile = mobile; _treatmentDay = treatmentDay; _isLoggedIn = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged_in', true);
    await prefs.setString('name', name);
    await prefs.setString('patient_id', patientId);
    await prefs.setString('cancer_type', cancerType);
    await prefs.setString('age', age);
    await prefs.setString('gender', gender);
    await prefs.setString('hospital_id', hospitalId);
    await prefs.setString('mobile', mobile);
    await prefs.setInt('treatment_day', treatmentDay);
    if (token != null) await ApiService.instance.saveToken(token);
    notifyListeners();
  }

  // ── Logout ──────────────────────────────────────────────────────────

  Future<void> logout() async {
    await ApiService.instance.logout();
    _isLoggedIn = false;
    _name = ''; _patientId = ''; _cancerType = '';
    _age = ''; _gender = ''; _hospitalId = ''; _mobile = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged_in', false);
    notifyListeners();
  }
}

// ─── Task Provider ────────────────────────────────────────────────────────────

class TaskProvider extends ChangeNotifier {
  final Map<String, Set<int>> _done = {};

  bool isTaskDone(String moduleId, int index) =>
      _done[moduleId]?.contains(index) ?? false;

  void toggleTask(String moduleId, int index, int totalTasks) {
    _done[moduleId] ??= {};
    if (_done[moduleId]!.contains(index)) {
      _done[moduleId]!.remove(index);
    } else {
      _done[moduleId]!.add(index);
    }
    notifyListeners();
    // Sync to server silently in background
    _syncModule(moduleId, totalTasks);
  }

  int completedCount(String moduleId) => _done[moduleId]?.length ?? 0;

  Future<void> _syncModule(String moduleId, int totalTasks) async {
    try {
      await ApiService.instance.updateModuleProgress(
        moduleId: moduleId,
        tasksCompleted: completedCount(moduleId),
        tasksTotal: totalTasks,
      );
    } catch (_) {}
  }

  Future<void> syncAll() async {
    if (_done.isEmpty) return;
    const totals = {
      'edumet': 5, 'nutrimet': 6, 'physimet': 6,
      'safemet': 5, 'trackmet': 5, 'mindmet': 5, 'medimet': 5,
    };
    final modules = _done.entries.map((e) => {
      'module_id': e.key,
      'tasks_completed': e.value.length,
      'tasks_total': totals[e.key] ?? 5,
    }).toList();
    try {
      await ApiService.instance.syncAllModules(modules);
    } catch (_) {}
  }
}
