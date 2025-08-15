import 'package:dio/dio.dart';

class LoginService {
  final Dio _dio;

  LoginService({Dio? dio}) : _dio = dio ?? Dio();

  /// Logs in the user with email/username and password
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'http://45.129.87.38:6065/user/login',
        data: {'email': email, 'password': password, 'role': 'vendor'},
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Login error: ${e.response?.data['message'] ?? e.message}',
        );
      } else {
        throw Exception('Login error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
