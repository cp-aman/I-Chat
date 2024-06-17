// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;
  final String email;
  final List<String> friends;
  UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isOnline,
    required this.email,
    required this.friends,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'email': email,
      'friends': friends,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      profilePic: map['profilePic'] as String,
      isOnline: map['isOnline'] as bool,
      email: map['email'] as String,
      friends: List<String>.from(
        (map['friends'] as List<String>),
      ),
    );
  }

  UserModel copyWith({
    String? name,
    String? uid,
    String? profilePic,
    bool? isOnline,
    String? email,
    List<String>? friends,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      isOnline: isOnline ?? this.isOnline,
      email: email ?? this.email,
      friends: friends ?? this.friends,
    );
  }
}
