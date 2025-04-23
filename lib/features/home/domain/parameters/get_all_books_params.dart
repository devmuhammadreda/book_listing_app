class GetAllBooksParams {
  final int page;
  final int? limit;
  final String? search;
  final String? topic;

  GetAllBooksParams({
    required this.page,
    this.limit,
    this.search,
    this.topic,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      if (limit != null) 'limit': limit,
      if (search != null) 'search': search,
      if (topic != null) 'topic': topic,
    };
  }
}
