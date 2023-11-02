enum NotificationData {
  success,
  info,
  warning,
  error,
  delete
}

extension KeyValue on NotificationData {
  String get name {
    switch (this) {
      case NotificationData.success:
        return 'success';
      case NotificationData.info:
        return 'info';
      case NotificationData.warning:
        return 'warning';
      case NotificationData.error:
        return 'error';
      case NotificationData.delete:
        return 'delete';           
      default:
        return '';
    }
  }
}