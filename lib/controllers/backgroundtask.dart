import 'package:frontend/helpers/logger.dart';
import 'package:get/get.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:schedulers/schedulers.dart';

class BackgroundController extends GetxController {
  @override
  void onInit() {
    scheduler.start();
    super.onInit();
  }

  final scheduler = NeatPeriodicTaskScheduler(
    interval: Duration(seconds: 5),
    name: 'hello-world',
    timeout: Duration(seconds: 5),
    task: () async => print('Hello World'),
    minCycle: Duration(seconds: 5),
  );
}
