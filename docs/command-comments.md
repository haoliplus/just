# 命令注释修改记录

日期：2026-09-11（东八区）

## 方案

为主入口、各模块及混合 CLI 模板的命令添加中文说明，放在命令及其属性之前，使说明显示在 `just --list` 中。按现有命令内容描述用途、参数和占位行为。

## 执行情况

1. 检查项目文件：确认命令分布在主 justfile、check/config/doc/init/install 模块和模板中；justfiles/justfile 仅声明模块。
2. 补充说明：覆盖全部 54 个命令，包括初始化参数、安装工具用途、模板开发命令；link 和 route 明确为输出提示或示例。
3. 执行调整：首次批量修改将 default 误归到模块入口，脚本停止；核对后改为主 justfile，完成其余注释。
4. 验证列表：主入口的 `just --list --list-submodules`、config 模块及模板的独立 `--list` 均成功，中文说明显示正常。
5. 验证变更：逐文件与 HEAD 比较，剔除注释后内容一致；全部命令均有说明；`git diff --check` 通过。

## 结论

修改仅涉及说明注释，未执行安装、初始化或生成命令。现有命令正文保持一致。

## 追加 CPA 命令（2026-09-11）

- 方案：将 `${HOME}/.config/dotfiles/justfile` 中的 `cpa_key`、`cpa` 原样复制到当前主 justfile，保留注释和位置参数属性。
- 检查结果：两个命令直接调用 `uvx llm`，不依赖源文件的变量、其他 recipe 或相对路径。
- 执行结果：已复制两个命令；源文件保持原样。
- 验证结果：`just --list` 正常显示两个命令及说明；`just --dry-run cpa_key`、`just --dry-run cpa '测试问题'` 和 `git diff --check` 均通过。
- 结论：复制完成，命令解析正常；未实际写入密钥或调用远端 API。
