# just 命令精简检查

日期：2026-09-11（东八区）

## 范围与步骤

1. 读取主 justfile、模块及安装脚本，核对命令的实际职责。
2. 使用本机 `mise list --installed` 对照已安装工具；未检查服务器，不推断服务器已迁移。
3. 使用 `just --dry-run` 核对路径展开，搜索仓库内脚本引用。
4. 整理删除候选和需确认项。本轮仅检查和留档，未删除命令、运行安装脚本或修改 mise 配置。

## 检查结果与建议

| 分类 | 命令 | 依据及建议 |
| --- | --- | --- |
| 优先删除候选 | install 的 fd、golang、just、nodejs、rg、yt-dlp | 本机 mise 已安装对应工具；旧脚本主要负责下载和安装，部分固定旧版本或 Linux 架构。 |
| 工具链安装候选 | install 的 cargo、uv | 本机 mise 已列出 rust 和 uv；cargo 脚本调用 rustup，uv 脚本还追加 Shell 配置。确认不再依赖这些引导步骤后删除。 |
| 旧管理器候选 | install asdf | 安装 asdf 并管理 Go、Python、Node；与用户采用 mise 的方向重复，待确认服务器是否仍用。 |
| 二进制重复但有配置职责 | install 的 caddy、rclone、singbox | 本机 mise 已安装对应工具；脚本分别涉及系统用户/服务、rclone 配置、sing-box 配置及服务，需确认这些职责是否仍保留。 |
| 非 mise 安装但另有来源 | install 的 nvim、fx、pip、zsh | 当前可执行文件分别来自 ~/.local/bin、Homebrew、mise Python、Homebrew；不能据此断言服务器无需脚本。 |
| 未确认使用情况 | install 的 alist、dufs、luarock | 未在本机 mise 已安装清单找到对应工具；需确认是否仍用。duf 与 dufs 是不同工具。 |
| 系统初始化职责 | install 的 basic、docker、tailscale、acme | 涉及系统依赖、Docker Engine、组网或证书工具；本机 mise 安装清单不能证明这些职责已被替代。 |
| 引导职责 | install mise | 新机器安装 mise 的入口，是否保留取决于本仓库是否继续承担机器初始化。 |
| 占位模块 | check、doc、config | link 只输出 Add nvim，route 只输出命令示例；config 未被模块入口导入。建议删除无实际用途的占位模块。 |
| 配置初始化 | init 的 zsh、nvim、tmux | 克隆个人配置并追加配置引用，不是单纯安装程序。需确认是否已统一迁移到 dotfiles。 |
| 项目初始化 | init 的 python、golang | Python 固定创建 demo，Go 固定示例模块名；需确认是否实际使用。 |
| 日常工作入口 | cpa、cpa_key、generate、hybrid-cli、init-help、install-global、help、default | 不属于软件安装职责，当前建议保留；CLI 模板中的开发命令也保留。 |

## 额外发现

- `doc help`、`init help`、`install help` 展开的文件路径分别是项目根目录下的 doc/mod.just、init/mod.just、install/mod.just，缺少 justfiles 目录。若模块保留，应修正。
- `check help` 路径展开正确。安装命令及 Go 模板路径也展开正确；未因模块文件所在位置推断其路径错误。
- `scripts/devenv/install/glow.sh` 和 `nvim010.sh` 没有 just 安装入口；引用搜索未发现其他仓库调用。glow 已由本机 mise 安装，可作为后续脚本清理候选。
- 本机 mise 同时列出 rg 和 ripgrep；本轮不修改外部 mise 配置。
- 补充路径检查中误用 `mise which rust`，该工具链没有名为 rust 的可执行文件，命令报错；不据此判断 Rust 安装损坏。cargo 当前解析到 mise shim。

## 待确认

优先确认是否继续保留 j4125、8845hs 等服务器初始化用途，再确定安装脚本的删除范围。其余需确认：配置初始化是否已迁移到 dotfiles，以及 alist、dufs、luarock、Python/Go 示例初始化是否仍在使用。

## 结论

本机已由 mise 管理的对应安装项共 11 项，其中 caddy、rclone、singbox 含额外配置职责。建议先精简纯安装入口和占位模块，再按使用情况处理服务器与配置初始化命令。删除清单尚未确认。

## 结合 mise 服务器初始化配置的复核

用户补充要求：结合 `~/.config/mise` 的服务器初始化能力确定精简范围。

### 执行与证据

1. 读取 config.toml、config.unix.toml、config.linux.toml、config.macos.toml、miserc.toml 及 dotfiles/linux/.zshrc。
2. 查看本机 `mise bootstrap --help`，确认安装的版本提供系统包、仓库、dotfiles、服务和远程 OpenSSH 初始化入口；没有执行 bootstrap。
3. 使用 `mise config ls` 确认本机加载主配置、unix 和 macos 配置。Linux 配置本轮仅静态检查，未连接服务器验证生效状态。
4. 检查当前 dotfiles/config/zshrc.sh，确认其加载个人配置及 zsh-autosuggestions，未看到 Oh My Zsh 加载入口。

### 职责对照

| just 职责 | mise 当前声明 | 结论 |
| --- | --- | --- |
| fd、Go、just、Node、rg、Rust/Cargo、uv、yt-dlp 安装 | config.toml 已声明对应工具 | 可作为首批删除候选，包含对应旧安装脚本。 |
| init nvim | unix 的 bootstrap.repos 克隆到同一个 ~/.config/nvim | 职责完全重复，可删除 recipe。注意 install nvim 安装程序，仍是另一项职责。 |
| init tmux | 克隆 ~/.config/tmux | 未声明 ~/.tmux.conf 的配置引用；保留到迁移完成。 |
| init zsh、install zsh | 克隆新路径 ~/.config/dotfiles、分发 .zshrc、激活 mise、设置登录 Shell | 新配置已承接个人 Shell 配置，但未声明安装 zsh 软件包；旧命令还安装 Oh My Zsh 并使用 ~/.dotfiles 路径，不能视为完全等价。 |
| install basic | apt build-essential / apk build-base 及部分其他包 | 没有覆盖旧脚本里的全部开发库及 curl/git/wget；暂保留。 |
| install singbox | 安装 sing-box，声明 systemd unit | unit 使用 ~/.local/bin/sing-box，未声明旧脚本的 /etc/sing-box/config.json，也未复现其参数和目录。声明存在不等于替代已验证。 |
| install caddy | 安装 caddy 工具 | 未声明对应服务、系统用户或配置文件；暂保留。 |
| install rclone | 安装 rclone 工具 | 未声明旧脚本写入的 /etc/rclone/rclone.conf；需确认该配置是否仍用。 |
| install docker、tailscale、acme、luarock、alist、dufs、fx、nvim | 未找到对应工具或 bootstrap 安装声明 | 暂保留，不能仅根据 mise 本身能力删除。 |
| install pip | Python 已交给 mise | 未核对服务器 pip 和旧脚本的 apt 后备安装需求；列为后续候选。 |
| install mise | mise 配置负责 mise 启动后的初始化 | 配置本身不等价于首次安装 mise；暂保留引导脚本。 |
| install-global | bootstrap.repos 克隆 ~/.config/just | 标准初始化路径已覆盖，但手动从其他目录链接仍有用途，保留。 |

### mise 配置中尚待核对的事项

- Linux 配置包含 `killall Dock || true`，属于 macOS 命令。
- .zshrc 模板仍加载 NVM 和 ~/.cargo/env；需确认是否还有必要。后者未做文件存在检查。
- sing-box unit 的二进制路径与 mise 默认版本安装目录不同，未验证服务器上是否有对应链接。
- `tasks.bootstrap` 的内容仅为 GitHub 登录检查；完整初始化能力来自 `mise bootstrap` 的配置阶段，不能把该 task 单独视为完整初始化。

### 调整后的首批方案

删除 install 下 fd、golang、just、nodejs、rg、cargo、uv、yt-dlp 共 8 个 recipe 及对应脚本；删除重复的 init nvim；删除 check/doc/config 占位模块及相关模块声明。asdf 仍待确认是否有遗留用途，其余安装与配置职责暂保留。若执行此方案，同时修正保留的 init/install 帮助路径并更新文档。

本轮结论为配置层面的职责对照，不代表 j4125、8845hs 已成功应用这些配置。未修改 mise 文件或删除 just 命令；等待确认具体精简方案。

## 首批清理执行结果

用户已确认执行上述首批方案。

1. 删除 install 的 fd、golang、just、nodejs、rg、cargo、uv、yt-dlp 共 8 个命令及对应安装脚本。
2. 删除 init nvim；保留 install nvim，其职责是安装 Neovim 程序。
3. 删除 check、doc、config 的模块文件，移除 doc/check 模块声明；config 原本没有声明。
4. 修正 init/install help 的路径，补上 justfiles 目录。
5. 更新 README，说明 mise 与 just 的职责及已移除入口。
6. 验证通过：`just --list --list-submodules`、`just init help`、`just install help`；保留的 16 个安装脚本引用均存在；`git diff --check` 通过。

结论：已完成确认范围内的清理。未执行安装脚本，未更改外部 mise 配置，未操作服务器。变更尚未提交。
