abstract class ViewConfigurable {
  Map<String, dynamic> toJson();

  ViewConfigurable merge(Map<String, dynamic> updates);
}
