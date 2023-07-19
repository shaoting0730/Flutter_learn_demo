class UserProvider {
  UserProvider._();

  static final UserProvider _instance = UserProvider._();

  static UserProvider get instance => _instance;

  factory UserProvider() => _instance;

  void init() {
    print('做相应初始化');
  }

  int get age => 10+1;

}


  UserProvider.instance.init();
  print(UserProvider.instance.age);