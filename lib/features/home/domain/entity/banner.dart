import 'package:equatable/equatable.dart';

class Banner extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final bool isShow;
  final String createdBy;
  final String updatedBy;
  final DateTime updatedAt;
  final DateTime createdAt;

  const Banner({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isShow,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    imageUrl,
    isShow,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
  ];
}
