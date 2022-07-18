class UserBean {
  String name;
  String address;

  UserBean({this.name, this.address});

  @override
  String toString() {
    return 'UserBean{name: $name, address: $address}';
  }
}
