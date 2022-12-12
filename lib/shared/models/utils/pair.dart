class Pair<E, F> {
  final E first;
  final F second;

  const Pair(this.first, this.second);

  factory Pair.fromJson(Map<String, dynamic> json) =>
      Pair(json.keys.first as E, json.values.first as F);

  Map<String, String> toJson() =>
      {first.toString(): second.toString()};

  @override
  String toString() {
    return 'Pair{first: $first, second: $second}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second;

  @override
  int get hashCode => first.hashCode ^ second.hashCode;

  Pair<E, F> copyWith({E? first, F? second}) =>
      Pair(first ?? this.first, second ?? this.second);
}
