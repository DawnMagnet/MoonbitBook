# 附录 B 常见错误与报错解析（面向初学者）

记录典型报错模式：包含示例、可能原因与修复建议。不同编译器版本具体消息可能略有差异，核心思路不变。

## 1. 修改不可变绑定

```
let x = 5
x = 6  // 错误：x 不可变
```

原因：默认 `let` 创建不可变绑定。修复：`let mut x = 5` 或使用 shadowing：`let x = x + 1`。

## 2. 分支返回类型不一致

```
let msg = if cond { "ok" } else { 0 }
```

原因：`"ok"` 是 String，`0` 是 Int，类型不匹配。修复：两个分支返回同类型；或把数值转换为字符串：`0.to_string()`。

## 3. 未处理 Option 的 None 分支

```
fn width_or_default(w? : Int) -> Int { w } // 试图直接返回 w
```

原因：`w` 实际类型是 `Option[Int]`。必须匹配：

```
match w { Some(v)=>v  None=>10 }
```

## 4. 数组越界

```
let a = [1,2,3]
println(a[3])  // 索引从 0 起，最大 2
```

修复：检查长度或使用安全访问（若提供）。

## 5. 共享别名导致二维数组意外联动

```
let wrong = FixedArray::make(3, FixedArray::make(3,0))
wrong[0][1] = 9
println(wrong[2][1]) // 9 (意外)
```

修复：使用 `makei`：

```
FixedArray::makei(3, fn(_){ FixedArray::make(3,0) })
```

## 6. 闭包修改外部变量逻辑混乱

```
let mut x = 0
let f = fn(){ x = x + 1 } // 多处调用不易追踪
```

建议：若变化与外部无关，传入参数或返回新值而非副作用；或封装在单一工厂函数中。

## 7. 枚举 match 漏分支（假设编译器检查）

```
enum Weather { Sunny Rainy Cloudy }
match w { Sunny=>"walk" Rainy=>"read" } // 漏 Cloudy
```

修复：补全所有分支：`Cloudy=>"think"`。若有默认分支语法，也应谨慎使用避免吞别的情况。

## 8. 类型推断歧义

```
let v = []  // 空数组：元素类型未知
```

修复：显式注解：`let v : Array[Int] = []`。

## 9. 字符串插值语法错误

```
println("value={x}") // 少了反斜线或花括号配对
```

正确：`println("value=\{x}")`。

## 10. 使用内层变量出作用域

```
{
  let inner = 10
}
println(inner) // 未定义
```

修复：把需要的值在块末尾返回或提升声明位置。

## 11. 深嵌套 if 逻辑混乱

症状：阅读困难、易漏条件。
修复：早返回（若语法支持）、拆函数、用枚举 + match。

## 12. 循环忘记更新变量导致死循环

```
let mut i = 0
while i < 5 { println(i) } // i 未变化
```

修复：`i = i + 1` 或使用 for 范围。

## 13. 递归未收敛

```
fn bad(n : Int) -> Int { bad(n) }
```

原因：没有基准条件。修复：添加终止条件：`if n<=0 {0} else { bad(n-1) }`。

## 14. 误用 Byte 处理多字节字符

```
let b : Byte = b'兔' // 非 ASCII
```

修复：使用 `Char` 或 `String` 处理 Unicode。

## 15. 使用固定写死数值替代枚举

```
let status = 2 // 2 代表什么？
```

修复：定义枚举：`enum Status { Pending Running Done }`。

---

排查策略：

1. 先看编译器报错行与类型信息。
2. 问自己：是否把“打印”当成了“返回值”？
3. 是否遗漏了某个枚举分支或 Option 的 None？
4. 是否数组/范围边界错位？

---

建议持续整理你遇到的错误 → 私人“错误日记”有助于加速进步。
