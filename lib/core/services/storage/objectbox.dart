import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../objectbox.g.dart';

class ObjectBox {

  ObjectBox._create(this.store);
  late final Store store;
  static ObjectBox? _instance;

  static Future<ObjectBox> create() async {
    if (_instance == null) {
      final docsDir = await getApplicationDocumentsDirectory();
      final store = await openStore(
        directory: p.join(docsDir.path, 'ecommerce-db'),
      );
      _instance = ObjectBox._create(store);
    }
    return _instance!;
  }
}