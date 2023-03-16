import 'package:equatable/equatable.dart';
import '../entities/user.dart';

class UserModel extends Equatable{

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
  
  const UserModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      albumId: ((json['albumId'] ?? 0) as num).toInt(), 
      id: ((json['id'] ?? 0) as num).toInt(),
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  User toEntity()=> User(
    albumId : albumId,
    id : id,
    title : title,
    url : url,
    thumbnailUrl : thumbnailUrl, 
    
  );

  @override
  List<Object?> get props => [
    albumId,
    id,
    title,
    url,
    thumbnailUrl,
  ];

}