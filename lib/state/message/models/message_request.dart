class MessageRequest {
  final String id;
  final int limit;
  const MessageRequest(this.id, this.limit);

  @override
  operator ==(covariant MessageRequest other) =>
      id == other.id || limit == other.limit;

  @override
  int get hashCode => Object.hashAll([id, limit]);
}
