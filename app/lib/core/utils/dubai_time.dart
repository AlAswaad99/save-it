/// Gulf Standard Time is UTC+4 and does not observe daylight saving.
const Duration dubaiOffset = Duration(hours: 4);

/// 24-hour clock in Asia/Dubai, independent of the device time zone.
String formatDubaiTime(DateTime instant) {
  final dubai = instant.toUtc().add(dubaiOffset);
  final hour = dubai.hour.toString().padLeft(2, '0');
  final minute = dubai.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}
