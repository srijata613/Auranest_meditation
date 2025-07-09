import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _usersKey = 'zenflow_users';
  static const String _currentUserKey = 'current_user';

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Get all stored users
  Future<List<User>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_usersKey) ?? [];
    return usersJson.map((userJson) => User.fromJson(userJson)).toList();
  }

  // Save users to storage
  Future<void> _saveUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = users.map((user) => user.toJson()).toList();
    await prefs.setStringList(_usersKey, usersJson);
  }

  // Register a new user
  Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final users = await getUsers();

      // Check if email already exists
      if (users
          .any((user) => user.email.toLowerCase() == email.toLowerCase())) {
        return AuthResult(
          success: false,
          message:
              'This email is already registered. Please use a different email.',
        );
      }

      // Create new user
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        password: password, // In production, this should be hashed
        createdAt: DateTime.now(),
      );

      // Add to users list and save
      users.add(newUser);
      await _saveUsers(users);

      // Set as current user
      await setCurrentUser(newUser);

      return AuthResult(
        success: true,
        message: 'Registration successful! Welcome to ZenFlow.',
        user: newUser,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Registration failed. Please try again.',
      );
    }
  }

  // Login user
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final users = await getUsers();

      // Find user by email
      final user = users.firstWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
        orElse: () => throw Exception('User not found'),
      );

      // Check password
      if (user.password != password) {
        return AuthResult(
          success: false,
          message: 'Invalid email or password. Please try again.',
        );
      }

      // Set as current user
      await setCurrentUser(user);

      return AuthResult(
        success: true,
        message: 'Login successful! Welcome back.',
        user: user,
      );
    } catch (e) {
      if (e.toString().contains('User not found')) {
        return AuthResult(
          success: false,
          message: 'No account found with this email. Please sign up first.',
        );
      }
      return AuthResult(
        success: false,
        message: 'Login failed. Please try again.',
      );
    }
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUserJson = prefs.getString(_currentUserKey);
    if (currentUserJson != null) {
      return User.fromJson(currentUserJson);
    }
    return null;
  }

  // Set current user
  Future<void> setCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, user.toJson());
  }

  // Logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final currentUser = await getCurrentUser();
    return currentUser != null;
  }

  // Check if email exists
  Future<bool> emailExists(String email) async {
    final users = await getUsers();
    return users.any((user) => user.email.toLowerCase() == email.toLowerCase());
  }

  // Get user by email
  Future<User?> getUserByEmail(String email) async {
    final users = await getUsers();
    try {
      return users.firstWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Update user
  Future<AuthResult> updateUser(User updatedUser) async {
    try {
      final users = await getUsers();
      final index = users.indexWhere((user) => user.id == updatedUser.id);

      if (index != -1) {
        users[index] = updatedUser;
        await _saveUsers(users);
        await setCurrentUser(updatedUser);

        return AuthResult(
          success: true,
          message: 'Profile updated successfully.',
          user: updatedUser,
        );
      }

      return AuthResult(
        success: false,
        message: 'User not found.',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Failed to update profile.',
      );
    }
  }

  // Delete user account
  Future<AuthResult> deleteAccount(String userId) async {
    try {
      final users = await getUsers();
      users.removeWhere((user) => user.id == userId);
      await _saveUsers(users);
      await logout();

      return AuthResult(
        success: true,
        message: 'Account deleted successfully.',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Failed to delete account.',
      );
    }
  }
}

class AuthResult {
  final bool success;
  final String message;
  final User? user;

  AuthResult({
    required this.success,
    required this.message,
    this.user,
  });
}
