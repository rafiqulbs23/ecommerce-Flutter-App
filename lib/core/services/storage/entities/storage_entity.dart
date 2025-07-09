import 'package:objectbox/objectbox.dart';

@Entity()
class StorageEntity {

  StorageEntity({
    this.id = 0,
    required this.key,
    required this.value,
    required this.createdAt,
  });
  @Id()
  int id;
  
  String key;
  
  /// The value stored as a string (typically JSON)
  String value;
  
  DateTime createdAt;
}