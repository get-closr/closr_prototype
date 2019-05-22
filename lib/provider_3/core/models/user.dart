class User {
  int id;
  final String name;
  final String username;


  User(this.id, this.username, this.name);

  User.initial()
      : id = 0,
        name = '',
        username = '';


  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    return data;
  }


}
