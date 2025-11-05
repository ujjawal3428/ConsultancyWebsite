class AdminPermission {
  static const String manageUsers = 'manage_users';
  static const String editContent = 'edit_content';
  static const String viewAnalytics = 'view_analytics';
  static const String manageEvents = 'manage_events';
  static const String manageNewsroom = 'manage_newsroom';
  static const String manageResources = 'manage_resources';
  
  static List<String> getAllPermissions() {
    return [
      manageUsers,
      editContent,
      viewAnalytics,
      manageEvents,
      manageNewsroom,
      manageResources,
    ];
  }
}