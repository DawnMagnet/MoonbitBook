# MoonBit Book 目录（面向初学者）

## 前言

- 适读对象与学习目标
- 学习建议（在线环境 + VSCode；边读边跑）
- 如何使用本书（以练为主、逐章推进）

## 第 I 部分 基础与环境（快速上手）

1. 第 1 章 编程与 MoonBit 简介（对应：`1.md`）

   - 1.1 什么是编程语言
   - 1.2 编译型与解释型语言
   - 1.3 MoonBit 的定位与多后端（Wasm/C/LLVM/JS）
   - 练习：比较你熟悉的语言与 MoonBit 的异同

2. 第 2 章 环境准备与第一个程序（对应：`2.mbt.md`）
   - 2.1 在线快速体验（try.moonbitlang.cn）
   - 2.2 安装 VSCode 与 MoonBit 插件
   - 2.3 安装 MoonBit 编译器（moon）
   - 2.4 Hello World：`main.mbt`
   - 2.5 工程结构与 `moon new` 模板（lib 与 main）
   - 练习：创建工程、运行、执行内置测试

## 第 II 部分 语法与语言核心（逐步掌握）

1. 第 3 章 数据类型（对应：`3.types.mbt.md`）

   - Unit / Bool / 数字类型（Int/Int64/UInt/Float/Double）
   - 字符串与插值、多行字符串
   - Char / Byte / Bytes
   - 元组 / 数组（Array 与 FixedArray）、索引与解构
   - 练习：字面量与类型转换综合题

2. 第 4 章 函数与程序结构（从入门到规范）（对应：`4.functions.mbt.md`）

   - 函数定义与调用：`fn`、`main`、`init`
   - 参数与返回值、类型注解
   - 带标签参数、可选参数与默认值
   - 局部函数、匿名函数、箭头函数
   - 练习：`greet`、`add`、带标签/可选参数示例

3. 第 5 章 变量、常量与作用域（对应：`5.variables.mbt.md`）

   - `let`（默认不可变）与 `mut`
   - `const` 编译期常量
   - 作用域、生命周期与命名
   - 练习：修复不可变/可变绑定错误

4. 第 6 章 控制流（对应：`6.control-flow.mbt.md`）

   - `let`（默认不可变）与 `mut`
   - `const` 编译期常量
   - 作用域、生命周期与命名
   - 练习：修复不可变/可变绑定错误

5. 第 7 章 函数进阶（闭包/高阶函数/递归）

   - 匿名函数与闭包（捕获环境）
   - 高阶函数（map/filter/reduce）
   - 递归与 `letrec`（相互递归）
   - 练习：`create_counter`、`apply_twice`、尾递归改写

## 第 III 部分 高级特性与项目实战

1. 第 8 章 数据结构与标准库（实用工具）

   - 匿名函数与闭包（捕获环境）
   - 高阶函数（map/filter/reduce）
   - 递归与 `letrec`（相互递归）
   - 练习：`create_counter`、`apply_twice`、尾递归改写

2. 第 9 章 模块、包与依赖管理（工程化）

   - 常用容器与操作（视标准库支持补充）
   - 字符串/字节/IO
   - JSON/序列化/时间日期（如适用）
   - 练习：文件词频统计并输出 JSON

3. 第 10 章 测试与调试

   - `moon.mod.json` 与包结构
   - 依赖声明与发布
   - 多模块工程（lib/main 分离）
   - 练习：抽取功能为库包并在另一项目引用

4. 第 11 章 构建、部署与目标平台

   - 单元测试（`*_test.mbt`）
   - 调试方法（断点/日志）
   - 常见错误与排查（类型错误、未初始化等）
   - 练习：为既有库补齐单测并通过

5. 第 12 章 并发与异步（如语言/运行时支持）
   - 使用 `moon` 构建/运行/发布
   - 目标后端：Wasm、C、LLVM、JS 简介
   - 在浏览器/服务器/边缘设备运行示例
   - 练习：编译为 Wasm 并在浏览器运行

## 第 IV 部分 进阶专题（选读）

1. 第 13 章 性能与内存

   - 线程/异步 API、通信与并发数据结构
   - 练习：并发任务示例或调度器

2. 第 14 章 （预留扩展章节）
   - 性能剖析与优化思路
   - 内存/对象生命周期与 GC（如适用）
   - 练习：优化慢函数并给出对比

## 附录

- A 语法速查表（关键字、字面量、运算符）
- B 常见错误与报错解析（面向初学者）
- C 推荐资源与扩展阅读（官网、文档、社区）
- D 练习答案（关键练习的参考实现）
- E 迁移指南（从 Python/JS/C++ 到 MoonBit）

—

说明：

- 已有内容：`1.md`、`2.mbt.md`、`3.types.mbt.md`、`4.functions.mbt.md`、`5.variables.mbt.md`、`6.control-flow.mbt.md` 覆盖第 1–6 章。
- 后续章节建议文件名：`7.advanced-functions.mbt.md`、`8.stdlib-data.mbt.md`、`9.modules-packages.mbt.md`、`10.testing-debug.mbt.md`、`11.build-deploy.mbt.md`、`12.concurrency.mbt.md`、`13.performance.mbt.md`、`14.extra.mbt.md`（预留）。
