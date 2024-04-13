class UserModel {
  final String user_id;
  final String user_avatar;
  final String user_name;
  UserModel({
    required this.user_id,
    required this.user_avatar,
    required this.user_name,
  });

  UserModel copyWith({
    String? user_id,
    String? user_avatar,
    String? user_name,
  }) {
    return UserModel(
      user_id: user_id ?? this.user_id,
      user_avatar: user_avatar ?? this.user_avatar,
      user_name: user_name ?? this.user_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'user_avatar': user_avatar,
      'user_name': user_name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_id: map['user_id'] as String,
      user_avatar: map['user_avatar'] as String,
      user_name: map['user_name'] as String,
    );
  }
}
