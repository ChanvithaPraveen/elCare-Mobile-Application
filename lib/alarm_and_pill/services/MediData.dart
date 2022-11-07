final String tableMedicineDetails = 'Medicine_data';

class MediFields {
  static final List<String> values = [
    /// Add all fields
    id, name, description, quantity, image_path
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String description = 'description';
  static final String quantity = 'quantity';
  static final String image_path = 'image_path';

}

class MediData {
  final int? id;
  final String name;
  final String description;
  final int quantity;
  final String image_path;


  const MediData({
    this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.image_path,

  });

  MediData copy({
    int? id,
    String? name,
    int? quantity,
    String? description,
    String? image_path,

  }) =>
      MediData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        image_path: image_path ?? this.image_path,

      );

  static MediData fromJson(Map<String, Object?> json) => MediData(
    id: json[MediFields.id] as int?,
    name: json[MediFields.name] as String,
    description: json[MediFields.description] as String,
    quantity: json[MediFields.quantity] as int,
    image_path: json[MediFields.image_path] as String,
  );

  Map<String, Object?> toJson() => {
    MediFields.id: id,
    MediFields.name: name,
    MediFields.description: description,
    MediFields.quantity: quantity,
    MediFields.image_path: image_path,
  };
}
