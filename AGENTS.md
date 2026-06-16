# AGENTS.md — SimpleGit-Provider

## CMD 脚本编写提醒

### 1. `cmd /c` 引号剥离陷阱

`cmd /c "script.cmd" "arg"` — 当 `/c` 后面的字符串以 `"` 开头时，cmd 会剥离**整个字符串的首尾 `"`**，导致内部引号错乱。`/S` 标志无法避免此行为。

**正确调用方式（二选一）：**

```cmd
:: 方案 A — 使用 call（最健壮，脚本路径可含空格）
cmd /c call "script.cmd" "arg with spaces"

:: 方案 B — 脚本路径不加外层引号（仅当路径无空格）
cmd /c script.cmd "arg with spaces"
```

原理：`call` 首字符是 `c`，不触发首尾引号剥离。

### 2. 异步启动 VS Code

`start "" "path\to\Code.exe" %*` 是最简可靠的异步启动方式。`%*` 在 `start` 命令行上**原生保留原始引号边界**，含空格的路径如 `"D:\1 2 3"` 会被正确传递。

### 3. 避免的写法

| 问题写法 | 原因 |
|----------|------|
| `setlocal EnableDelayedExpansion` + `start` | 在 LabVIEW 调起的 cmd 下可能触发"内存资源不足" |
| `for /f` + `reg query` + 管道（`^\|`） | 受限环境下转义不稳定 |
| `set VAR=%*` 后传入 PowerShell | `set` 对含内嵌双引号的值处理不可靠 |
| `%*` 直接拼入 `powershell -Command "..."` | cmd 层引用与 PS 层引用冲突 |
| `shift` + `goto` 循环收集参数 | 某些调用方下可能死循环 |

### 4. VS Code 检测顺序

1. `if exist` 检查标准安装路径（零外部命令，优先）：
   - `%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe`（用户安装，64-bit）
   - `%ProgramW6432%\Microsoft VS Code\Code.exe`（系统安装，64-bit，WOW64 安全）
   - `%ProgramFiles%\Microsoft VS Code\Code.exe`
   - `%ProgramFiles(x86)%\Microsoft VS Code\Code.exe`
2. `where code` 仅作后备（外部命令，PATH 极大时可能耗时）

### 5. 脚本设计原则

- **极简优先**：零 `setlocal`、零循环、零外部命令
- **找到即退出**：每个分支 `start` + `exit`，不攒变量
- **不依赖注册表**：`if exist` 覆盖所有标准安装路径即可
