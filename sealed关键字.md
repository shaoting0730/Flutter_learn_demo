### `sealed` 关键字,创建封闭类，封闭类只能在同一个库文件中被继承。
```
sealed class Animal {
  void makeNoise() => print('Unknown animal noise!');
}

class Dog extends Animal {
  void makeNoise() => print('Bark!'); 
}

class Cat extends Animal {
  void makeNoise() => print('Meow!'); 
}

```
Animal是一个封闭类(sealed class)。只有在同一个文件中,Dog和Cat类才能继承它.
封闭类(sealed class)是隐式抽象的,不能被直接实例化。因为封闭类隐式地被视为抽象类.

