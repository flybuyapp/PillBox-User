class SuggestionPost {
  dynamic id;
  dynamic name;
  dynamic weight;
  dynamic parent;
  // String? term; // Change to String?

  SuggestionPost({
    required this.id,
    required this.name,
    required this.weight,
    required this.parent,
    // required this.term,
  });

  factory SuggestionPost.fromJson(Map<String, dynamic> json) {
    return SuggestionPost(
      id: json['id'].toString(),
      name: json['name'].toString(),
      weight: json['weight'].toString(),
      parent: json['parent'].toString(),
      // term: json['term']?.toString(), // Handle potential null value
    );
  }
}
