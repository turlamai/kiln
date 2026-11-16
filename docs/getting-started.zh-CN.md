# 验证架构基础

[English](getting-started.md) · **简体中文**

Kiln 尚无固件编译器或受支持开发板。当前第一个可用结果，是通过检查的架构基础及本地文档手册。

## 要求与命令

在 macOS、Windows 或 Linux 上准备完整 Racket CS 9.3、Git 和终端。完整 Racket 提供 Scribble、RackUnit 及被引用的手册。安装包可能获取标准依赖，使用前请检查网络环境。运行检查不需要开发板、SDK、C 编译器、签名密钥或账号。将仓库克隆到通常使用的代码目录，进入仓库后执行：

```sh
racket kiln-tools/check-foundation.rkt
raco test kiln-test
raco pkg install --auto --name kiln --link "$PWD"
raco setup --check-pkg-deps --pkgs kiln
raco scribble --htmls --dest build/manual kiln-doc/kiln.scrbl
```

预期结果：检查器输出成功，RackUnit 通过，依赖检查正常退出，`build/manual/kiln/index.html` 可作为本地手册打开。完整英文技术规范见[文档导航](README.md)。这些结果验证文档结构与包元数据，不验证 MCU 代码。

## 数据、清理和故障恢复

链接包在 Racket 用户包注册表中指向你的工作副本。生成手册位于已忽略的 `build/`；Racket 也可能生成已忽略的 `compiled/` 目录。检查使用系统临时目录中的一次性测试文件，不上传诊断数据，也不连接硬件。当前基础不包含遥测、用户账号、付费激活或密钥存储。

若 `kiln` 已链接，先用 `raco pkg show kiln` 检查，不要覆盖其他工作副本。移动仓库后，用 `raco pkg remove kiln` 移除旧注册，再链接所需位置。清理生成手册时，通过文件管理器仅删除 `build/manual`。移除包注册不会删除源码工作副本。

缺少 Scribble/RackUnit 通常意味着安装了最小版 Racket：改用完整 CS 9.3，或通过 `raco pkg` 安装声明的依赖。链接检查错误会指出 Markdown 文件和目标；修复时检查两种语言的对应入口，再重新运行。通过 [Issues](https://github.com/turlamai/kiln/issues)报告缺陷，附上 commit 和脱敏输出；漏洞走[安全政策](../SECURITY.md)的私密入口。目前没有已发布安装包、自动更新机制、支持 SLA 或经过验证的硬件版本。
