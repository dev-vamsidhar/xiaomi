import 'package:logger/logger.dart';

enum Sevearity { high, low, medium }

void log(data, [Sevearity type = Sevearity.high]) {
  if (type == Sevearity.high) {
    Logger().e(data);
  } else if (type == Sevearity.low) {
    Logger().v(data);
  } else {
    Logger().w(data);
  }
}
