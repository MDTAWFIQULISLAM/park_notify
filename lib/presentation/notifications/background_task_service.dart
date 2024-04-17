import 'package:background_fetch/background_fetch.dart';
import 'notification_service.dart';

class BackgroundTaskService {
  DateTime parkedTime;

  BackgroundTaskService(this.parkedTime);

  void startBackgroundTasks() async {
    await BackgroundFetch.registerHeadlessTask(backgroundFetch);
    await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 10, // Fetch interval in minutes
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
      ),
          (String taskId) async {
        print("[BackgroundFetch] Event received $taskId");
        await backgroundFetch();
        BackgroundFetch.finish(taskId);
      },
    );
  }

  Future<void> backgroundFetch() async {
    final int minutesElapsed = DateTime.now().difference(parkedTime).inMinutes;
    if (minutesElapsed % 10 == 0) {
      final NotificationService notificationService = NotificationService();
      await notificationService.showNotification(minutesElapsed);
    }
  }
}
