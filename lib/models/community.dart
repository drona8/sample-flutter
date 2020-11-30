import 'model.dart';

class Community extends Model {
  String id;
  String label;
  String description;

  Community({
    this.id,
    this.label,
    this.description,
  });

  factory Community.fromMap(Map<String, dynamic> data) {
    data = data ?? {};
    return Community(
      label: data['label'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonUser = new Map<String, dynamic>();
    jsonUser['label'] = this.label;
    jsonUser['description'] = this.description;
    return jsonUser;
  }

  bool operator ==(dynamic other) =>
      other != null && other is Community && this.id == other.id;

  @override
  int get hashCode => super.hashCode;
}
