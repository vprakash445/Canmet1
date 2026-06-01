import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ─── Base URL ─────────────────────────────────────────────────────────────────
class ApiConfig {
  static const String baseUrl =
      'https://varahierpsolution.com/CanmetAdmin/public/api';

  static const Duration timeout = Duration(seconds: 20);
}

// ─── API Response wrapper ─────────────────────────────────────────────────────
class ApiResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;
  final int statusCode;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    required this.statusCode,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    return ApiResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.error(String message, {int statusCode = 0}) {
    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }
}

// ─── Main API Service ─────────────────────────────────────────────────────────
class ApiService {
  static ApiService? _instance;
  ApiService._();
  static ApiService get instance => _instance ??= ApiService._();

  // ── Token management ──────────────────────────────────────────────────

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('api_token');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_token', token);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('api_token');
  }

  // ── HTTP helpers ──────────────────────────────────────────────────────

  Map<String, String> _headers({String? token}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<ApiResponse> _post(
    String endpoint,
    Map<String, dynamic> body, {
    bool requiresAuth = false,
  }) async {
    try {
      String? token;
      if (requiresAuth) {
        token = await getToken();
        if (token == null) {
          return ApiResponse.error('Not authenticated. Please login.');
        }
      }

      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      final response = await http
          .post(
            uri,
            headers: _headers(token: token),
            body: jsonEncode(body),
          )
          .timeout(ApiConfig.timeout);

      return _parseResponse(response);
    } on SocketException {
      return ApiResponse.error(
          'No internet connection. Data saved locally.');
    } on TimeoutException {
      return ApiResponse.error('Request timed out. Please try again.');
    } catch (e) {
      return ApiResponse.error('Something went wrong: ${e.toString()}');
    }
  }

  Future<ApiResponse> _get(
    String endpoint, {
    bool requiresAuth = false,
    Map<String, String>? queryParams,
  }) async {
    try {
      String? token;
      if (requiresAuth) {
        token = await getToken();
        if (token == null) {
          return ApiResponse.error('Not authenticated. Please login.');
        }
      }

      var uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      if (queryParams != null) {
        uri = uri.replace(queryParameters: queryParams);
      }

      final response = await http
          .get(uri, headers: _headers(token: token))
          .timeout(ApiConfig.timeout);

      return _parseResponse(response);
    } on SocketException {
      return ApiResponse.error('No internet connection.');
    } on TimeoutException {
      return ApiResponse.error('Request timed out. Please try again.');
    } catch (e) {
      return ApiResponse.error('Something went wrong: ${e.toString()}');
    }
  }

  ApiResponse _parseResponse(http.Response response) {
    try {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ApiResponse.fromJson(json, response.statusCode);
    } catch (_) {
      return ApiResponse.error(
        'Invalid server response',
        statusCode: response.statusCode,
      );
    }
  }

  // ── Auth API ──────────────────────────────────────────────────────────

  /// Register a new patient
  Future<ApiResponse> register({
    required String name,
    required String age,
    required String gender,
    required String cancerType,
    required String hospitalId,
    required String mobile,
    required String password,
    required String language,
  }) {
    return _post('/patient/register', {
      'name':        name,
      'age':         int.tryParse(age),
      'gender':      gender,
      'cancer_type': cancerType,
      'hospital_id': hospitalId,
      'mobile':      mobile,
      'password':    password,
      'language':    language,
    });
  }

  /// Login with patient ID and password
  Future<ApiResponse> login({
    required String patientId,
    required String password,
  }) {
    return _post('/patient/login', {
      'patient_id': patientId,
      'password':   password,
    });
  }

  /// Get patient profile
  Future<ApiResponse> getProfile() {
    return _get('/patient/profile', requiresAuth: true);
  }

  /// Logout
  Future<ApiResponse> logout() async {
    final result = await _post('/patient/logout', {}, requiresAuth: true);
    await clearToken();
    return result;
  }

  // ── Health Log API ────────────────────────────────────────────────────

  /// Submit daily health log
  Future<ApiResponse> submitHealthLog({
    required String logDate,
    double? fastingGlucose,
    double? postMealGlucose,
    double? bpSystolic,
    double? bpDiastolic,
    double? weight,
    double? waist,
    int? stressScore,
    double? sleepHours,
  }) {
    return _post('/health-log', {
      'log_date':          logDate,
      'fasting_glucose':   fastingGlucose,
      'post_meal_glucose': postMealGlucose,
      'bp_systolic':       bpSystolic,
      'bp_diastolic':      bpDiastolic,
      'weight':            weight,
      'waist':             waist,
      'stress_score':      stressScore,
      'sleep_hours':       sleepHours,
    }, requiresAuth: true);
  }

  // ── Module Progress API ───────────────────────────────────────────────

  /// Update single module progress
  Future<ApiResponse> updateModuleProgress({
    required String moduleId,
    required int tasksCompleted,
    required int tasksTotal,
  }) {
    return _post('/module-progress', {
      'module_id':       moduleId,
      'tasks_completed': tasksCompleted,
      'tasks_total':     tasksTotal,
    }, requiresAuth: true);
  }

  /// Sync all modules at once
  Future<ApiResponse> syncAllModules(
      List<Map<String, dynamic>> modules) {
    return _post('/module-progress/sync', {
      'modules': modules,
    }, requiresAuth: true);
  }

  // ── Utility ───────────────────────────────────────────────────────────

  /// Check if API is reachable
  Future<bool> isOnline() async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}/health'))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
