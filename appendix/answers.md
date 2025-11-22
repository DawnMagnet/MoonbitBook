# 附录 D 练习参考答案（节选）

仅提供部分关键练习的参考实现与思路。请先自行完成，再对照。并非唯一正确写法；重点在可读性、错误处理与表达式风格。

## 第 4 章（选）

**练习 4-1**

```moonbit expr
fn square(n : Int) -> Int { n*n }
fn hello(name : String) -> String { "Hello, \{name}" }
fn main { println(square(5)); println(hello("MoonBit")) }
```

思路：最后表达式返回值，避免多余变量。

**练习 4-4**

```moonbit expr
fn area(width? : Int, height? : Int) -> String {
  let w = match width { Some(v)=>v None=>10 }
  let h = match height { Some(v)=>v None=>10 }
  "\{w}x\{h}"
}
```

**练习 4-8 compose**

```moonbit expr
fn compose(f : (Int)->Int, g : (Int)->Int) -> (Int)->Int {
  fn(x){ f(g(x)) }
}
```

## 第 5 章（选）

**练习 5-6**

```moonbit expr
fn main {
  let t = (42, "hi", true)
  let (a,b,c) = t
  println(a)
}
```

**练习 5-9 safe_head**

```moonbit expr
fn safe_head(arr : Array[Int]) -> Option[Int] { if arr.length()==0 { None } else { Some(arr[0]) } }
```

## 第 6 章（选）

**练习 6-2（mutation → 不可变）**

```moonbit expr
fn main {
  let step1 = 0 + 1
  let step2 = step1 + 5
  println(step2)
}
```

**练习 6-5 嵌套作用域**

```moonbit expr
fn main {
  let value = 1
  {
    let value = 2
    {
      let value = 3
      println(value) // 3
    }
    println(value)   // 2
  }
  println(value)     // 1
}
```

## 第 7 章（选）

**练习 7-1 abs**

```moonbit expr
fn abs(n : Int) -> Int { if n>=0 { n } else { -n } }
```

**练习 7-4 找首个被 7 整除**

```moonbit expr
fn first_div7(start : Int) -> Int {
  let mut x = start
  while true {
    if x % 7 == 0 { return x } // 若语言无 return，可改写成循环外绑定
    x = x + 1
  }
}
```

**练习 7-7 count_positive**

```moonbit expr
fn count_positive(a : Array[Int]) -> Int { a.fold(0, fn(acc,n){ if n>0 { acc+1 } else { acc } }) }
```

## 思路提示

- Option：模式匹配分离 Some/None。
- 递归：先写基例，再写递归步骤。
- 部分应用：下划线是未来要补的参数。

## 后续章节答案

待章节撰写完成后逐步补充（模块/测试/构建/并发/性能）。

---

保持练习：尝试用不同风格重写以上答案（命令式 vs 函数式）。
