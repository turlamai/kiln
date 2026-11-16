# Kiln

[English](README.md) · **简体中文**

面向可靠 MCU 产品研发、正在设计中的 Racket 原生嵌入式平台。

**当前状态：架构基础阶段。** 仓库提供规范、治理及可执行文档检查。尚无 MCU 编译器、目标运行时、受支持开发板或固件版本。商业级交付是工程目标，不是当前成熟度声明。

## 技术方向

开发机使用普通 `#lang racket/base` 模块、Racket 官方 expander、包系统、RackUnit 和 Scribble。通过明确的运行时能力 profile、可验证的中间表示生成 C，再交给固定版本的交叉工具链。设备端仅保留小型 C runtime 和硬件适配层。不支持的语义必须报错；整数溢出、求值顺序和尾调用不能悄悄变成 C 语义。

复用 Racket 生态**不等于**任意 Racket 包都能在 MCU 上运行。主机宏依赖与目标运行时依赖分别审查兼容性和信任边界。不计划创建新 Scheme 方言或包管理器。

## 从这里开始

当前没有可烧录产物。先阅读[架构](docs/architecture.md)、[语言契约](docs/language-contract.md)及[路线图](docs/roadmap.md)；三者为英文技术真源。使用 Racket CS 9.3 验证本阶段基础：

```sh
racket kiln-tools/check-foundation.rkt
raco test kiln-test
raco pkg install --auto --name kiln --link "$PWD"
raco setup --check-pkg-deps --pkgs kiln
raco scribble --htmls --dest build/manual kiln-doc/kiln.scrbl
```

本地安装包仅含文档，尚未发布到 catalog。这些命令不验证 MCU 行为。前置要求、产物位置和清理方式见[入门与恢复](docs/getting-started.zh-CN.md)。

## 范围与限制

| 领域 | 当前证据 | 后续门禁 |
| --- | --- | --- |
| 主机工具 | macOS、Windows、Linux 的基础 CI | 三平台复现同一目标固件 |
| 语言 | 拟定能力与拒绝规则 | 对照固定版本桌面 Racket 的差分测试 |
| 原生产物 | 已选择 C 作为首个后端 | IR 校验、C 语义与 ELF 产物检查 |
| 硬件 | 尚无已验证目标 | 一个 Cortex-M 参考板，再到真实产品 |
| 实时性 | 无时序保证 | 具体板卡的栈、中断与时序证据 |
| 商业使用 | MIT 源码权利 | 单独决策经过验证的分发与支持服务 |

RISC-V、RTOS adapter、VM 及行业集成留待后续评估。Kiln 是专业基础设施，不纳入移动应用宿主。未来若开发图形工具，须沿用家族 Rivet 或 Glaze 路线并先做原型；二者均不作为设备端 runtime 依赖。

## 参与和反馈

提案与缺陷使用 [Issues](https://github.com/turlamai/kiln/issues)；检查方法见英文[贡献指南](CONTRIBUTING.md)；漏洞通过[安全政策](SECURITY.md)中的私密入口报告。诊断数据须先脱敏、检查，再主动分享。当前基础工具不会自动上传数据。

英文[文档导航](docs/README.md)指向需求、ADR、验证、风险、治理和下一步交接。技术规范以英文为唯一真源；本 README 与入门指南提供完整中文入口。

采用 [MIT](LICENSE)。第三方授权独立适用，见[第三方政策](THIRD_PARTY_NOTICES.md)。当前没有付费版本、支持 SLA 或认证承诺。
