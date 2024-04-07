## assert
# 断言，通产用于代码中进行断言操作。当条件为false时，assert 会抛出一个异常，提醒开发者存在问题。需要注意的是，在生产环境中，assert语句会被自动忽略，因此不会对应用程序的性能产生任何影响。因此，我们可以放心地在开发和调试阶段广泛使用assert语句来确保程序的正确性。
```
assert(condition, [message]);
如：
double divide(double a, double b) {
  assert(b != 0, "除数不能为0！");
  return a / b;
}

```