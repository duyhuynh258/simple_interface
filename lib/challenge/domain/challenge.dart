class Challenge {
  const Challenge({
    required this.description,
  });

  /// Content of a challenge.
  final String description;

  Challenge copyWith({
    String? description,
  }) {
    return Challenge(
      description: description ?? this.description,
    );
  }
}
