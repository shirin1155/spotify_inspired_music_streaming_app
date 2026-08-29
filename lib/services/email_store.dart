class EmailStore {
  EmailStore._();

  static final Set<String> _registeredEmails = <String>{};
  static final Map<String, String> _userNamesByEmail = <String, String>{};
  static String _currentUserEmail = '';

  static Future<List<String>> getEmails() async {
    return _registeredEmails.toList();
  }

  static Future<void> saveEmail(String email) async {
    final normalized = _normalize(email);
    if (normalized.isEmpty) return;

    _registeredEmails.add(normalized);
    _currentUserEmail = normalized;
  }

  static Future<void> saveName(String name) async {
    final normalized = _normalizeName(name);
    if (normalized.isEmpty) return;

    final key = _currentUserEmail.isNotEmpty ? _currentUserEmail : 'user';
    _userNamesByEmail[key] = normalized;
  }

  static Future<void> setCurrentUser(String email) async {
    final normalized = _normalize(email);
    if (normalized.isEmpty) return;

    _currentUserEmail = normalized;
  }

  static Future<String> getCurrentUserEmail() async {
    return _currentUserEmail;
  }

  static Future<String> getName() async {
    if (_currentUserEmail.isEmpty) {
      return 'USER';
    }

    final name = _userNamesByEmail[_currentUserEmail];
    return (name ?? 'USER').toUpperCase();
  }

  static Future<String> getNameForEmail(String email) async {
    final normalized = _normalize(email);
    if (normalized.isEmpty) return 'USER';

    final name = _userNamesByEmail[normalized];
    return (name ?? 'USER').toUpperCase();
  }

  static Future<bool> hasEmail(String email) async {
    final normalized = _normalize(email);
    if (normalized.isEmpty) return false;

    return _registeredEmails.contains(normalized);
  }

  static String _normalize(String email) {
    return email.trim().toLowerCase();
  }

  static String _normalizeName(String name) {
    return name.trim();
  }
}
