class GetAllBooksParams {
  final int page;
  final int? limit;
  final String? search;

  GetAllBooksParams({
    required this.page,
    this.limit,
    this.search,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      if (limit != null) 'limit': limit,
      if (search != null) 'search': search,
    };
  }
}
