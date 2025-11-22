# 附录 A 语法速查表（Cheat Sheet）

快速参考，不作深入解释。详细请回各章节。示例均为最小片段。

## 关键字（部分）

`fn` `let` `mut` `const` `match` `enum` `for` `while` `break` `continue` `and` (相互递归) `true` `false`

## 基本类型

`Unit ()` `Bool` `Int/Int64/UInt/UInt64` `Float/Double` `String` `Char` `Byte` `Bytes` `Array[T]` `FixedArray[T]` `Option[T]`

## 函数定义

```moonbit expr
fn add(x : Int, y : Int) -> Int { x + y }
```

无参可省括号：`fn main { ... }`

## 标签 & 可选参数

```moonbit expr
fn create(name~ : String, age~ : Int = 18, score? : Int) {
  // score? 实际类型 Option[Int]
}
```

调用：`create(name="A")` 或 `create(name="B", score=99)`。

## 部分应用

```moonbit expr
fn add(x : Int, y : Int) -> Int { x + y }
let inc = add(1, _)
```

## 匿名/箭头函数

`fn(x){ x*2 }` / `x => x*2`

## 闭包

```moonbit expr
fn make(start : Int) -> () -> Int {
  let mut c = start
  fn(){ c = c + 1; c }
}
```

## 枚举 + match

```moonbit expr
enum Weather { Sunny Rainy }
fn advise(w : Weather) -> String { match w { Sunny=>"Walk" Rainy=>"Read" } }
```

## if 表达式

```moonbit expr
let kind = if x>0 {"pos"} else {"non-pos"}
```

## while

```moonbit expr
while n>0 { n = n - 1 }
```

## for C 风格

```moonbit expr
for i=0; i<10; i=i+1 { println(i) }
```

## for..in & 范围

```moonbit expr
for v in [1,2,3] { println(v) }
for i in 0..<5 { println(i) }   // 0..4
for i in 0..=5 { println(i) }   // 0..5
```

## 数组与索引

```moonbit expr
let a = [1,2,3]
a[1] = 10
```

## 元组

```moonbit expr
let t = (true, 42)
let b = t.0
let (flag,num) = t
```

## Option 模式匹配

```moonbit expr
match maybe { Some(v)=>v  None=>0 }
```

## 二维 FixedArray 正确构造

```moonbit expr
let grid = FixedArray::makei(5, fn(_){ FixedArray::make(5,0) })
```

## 常量

```moonbit expr
const PI = 3.14
```

## Shadowing

```moonbit expr
let x = 5
let x = x + 1  // 新绑定
```

## Bytes

```moonbit expr
let b : Bytes = b"\x61\x62"
```

## 字符串插值

```moonbit expr
println("val=\{x}")
```

## 多行字符串

```moonbit expr
let s =
  #| line1
  #| line2
```

`$|` 版本支持插值。

---

使用顺序建议：函数 → 基础类型 → 控制流 → 组合/枚举 → 高阶/闭包 → 模块/工程化。
