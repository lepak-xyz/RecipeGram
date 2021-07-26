class Recipe {
  final int id;
  final Map author;
  final String name;
  final String caption;
  final String image;
  final int heat;
  final List tags;
  final Map ingredients;
  final Map instructions;

  Recipe({
    required this.id,
    required this.author,
    required this.name,
    required this.caption,
    required this.image,
    required this.heat,
    required this.tags,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: int.parse(json['id']),
      author: json['author'],
      name: json['name'],
      caption: json['caption'],
      image: json['images'],
      heat: int.parse(json['heat']),
      tags: json['tags'],
      ingredients: json['ingredients'],
      instructions: json['instructions'],
    );
  }
}
