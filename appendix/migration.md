# 附录 E 迁移指南（从 Python / JS / C++ 到 MoonBit）

帮助已有其它语言背景的读者快速建立“迁移映射”。不假设高深底层知识，只对常见心智差异做对照。

---

## 总览心智对照

| 方面       | Python        | JavaScript         | C++             | MoonBit                   |
| ---------- | ------------- | ------------------ | --------------- | ------------------------- | ---- | ------ |
| 可变性默认 | 可变          | 可变               | 可变 (可 const) | 默认不可变（需 mut）      |
| 函数返回   | `return` 明确 | `return`           | `return`        | 最后表达式即返回值        |
| 空值表示   | `None`        | `undefined/null`   | `nullptr`       | 使用 `Unit` 或 `Option`   |
| 集合常用   | list/dict     | Array/Object       | vector/map      | Array/FixedArray/枚举匹配 |
| 异步模型   | asyncio       | Promise/event loop | 线程/库         | （视语言支持：并发章节）  |
| 多行字符串 | 三引号        | 反引号模板         | 原始字符串      | `#                        | `/`$ | ` 前缀 |

---

## 1. 变量与不可变

Python/JS/C++ 习惯：一开始就可修改。MoonBit：`let` 不可变 → 若需要修改，显式 `mut`，减少无意状态变化。

```moonbit expr
let mut count = 0
count = count + 1
```

迁移技巧：先尝试用不可变链式写法；只在性能或确实需要状态累积时加 `mut`。

---

## 2. 函数返回值风格

Python：

```python
def add(x,y):
    return x+y
```

MoonBit：

```moonbit expr
fn add(x : Int, y : Int) -> Int { x + y }
```

少写样板，更适合表达式组合。迁移时注意：函数体最后“裸值”即返回，不要再写伪造 `return`。

---

## 3. 可选值处理

Python：用 `None`；JS：`undefined/null`；C++：指针或 `std::optional`。
MoonBit：`Option[T]` 搭配模式匹配。

```moonbit expr
fn head(arr : Array[Int]) -> Option[Int] { if arr.length()==0 { None } else { Some(arr[0]) } }
fn main { println(match head([1,2]) { Some(v)=>v None=>-1 }) }
```

优势：编译器强迫显式处理 `None`。

---

## 4. 集合操作与高阶函数

Python `map/filter`, JS 同名, C++ `<algorithm>`：MoonBit 可类似：

```moonbit expr
let squares = [1,2,3].map(n => n*n)
let evens = [1,2,3,4].filter(n => n%2==0)
```

迁移注意：链式调用仍保持纯函数风格，修改原数组需明确赋值。

---

## 5. 字符串与模板

Python f-string：`f"val={x}"`；JS 模板：`` `val=${x}` ``；MoonBit：`"val=\{x}"`。
多行：MoonBit 用 `#|` 保留原样；`$|` 支持插值。

---

## 6. 枚举 vs 魔法数字

C++/JS/Python 习惯用数字或字符串表示状态：MoonBit 推荐枚举 + match：

```moonbit expr
enum Status { Pending Running Done }
fn label(s : Status) -> String { match s { Pending=>"pending" Running=>"running" Done=>"done" } }
```

迁移收益：减少拼写错误与不可穷尽的字符串常量。

---

## 7. 错误处理心智

若 MoonBit 尚未提供复杂异常机制，可用返回枚举或 `Option` 表示：

```moonbit expr
enum ParseResult { Ok(Int) Error(String) }
fn parse_digit(s : String) -> ParseResult {
  if s == "0" { Ok(0) } else { Error("unsupported") }
}
```

迁移策略：把 Python/JS 的 “抛异常” 转为返回结构体/枚举，让调用者 match 分支。

---

## 8. 并发/异步（占位）

若 MoonBit 支持线程/任务：心理模型接近 Go（轻量任务）或 Rust（显式同步）。若暂未成熟：可先用纯逻辑 + 外部脚本调度。迁移时谨慎共享 `mut` 状态。

---

## 9. 性能与内存对比

C++ 需手动/RAII；Python/JS 自动 GC；MoonBit（假设）具自动管理 + 默认不可变减少意外共享。迁移建议：减少不必要的中间可变对象，使用表达式组合。

---

## 10. 典型迁移示例

Python：统计偶数和

```python
sum(x for x in arr if x%2==0)
```

MoonBit：

```moonbit expr
[1,2,3,4].filter(n => n%2==0).fold(0, fn(acc,n){ acc+n })
```

---

## 心态调整清单

- 少写“命令式步骤”，多写“表达式变换”。
- 遇到“可能为空” → 立刻考虑 Option。
- 用枚举表意而非字符串标签。
- 尝试先用不可变，最后再优化为 `mut`。

---

后续：随着语言特性补充（模块系统、标准库 IO、并发原语），再增补更细粒度迁移指南。
