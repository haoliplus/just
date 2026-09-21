# mod install '{{justfile_directory()}}/justfiles/'
import? 'justfiles/justfile'

# 列出全局 just 命令
help:
  just -g --list

# 将当前项目软链接到 ~/.config/just，供全局 just 使用
install-global:
  mkdir -p ~/.config
  ln -sfn {{justfile_directory()}} ~/.config/just
  @echo "linked {{justfile_directory()}} -> ~/.config/just"

# 显示项目初始化命令的使用示例
init-help:
  just -f {{justfile_directory()}}/justfiles/init/mod.just init-help

# 生成 Bash、just、uv 混合 CLI 项目；dir 默认为项目名
hybrid-cli name dir='':
  just -f {{justfile_directory()}}/justfiles/init/mod.just hybrid-cli {{name}} {{ if dir != '' { dir } else { name } }}

# 生成 AI 图片或语音；args 透传生成类型及其参数
[positional-arguments]
generate *args:
  bash {{justfile_directory()}}/scripts/generate/run.sh "$@"

# 列出当前项目可用的命令和模块
default:
  just --list

# 交互输入 CPA API key，保存到 LLM 的用户级 keys.json，别名为 cpa。
cpa_key:
  @uvx llm keys set cpa

# 轻量单次调用：just cpa '你的问题'；先运行 just cpa_key 配置密钥。
[positional-arguments]
cpa message:
  @uvx llm openai endpoint https://cpa.aidoki.cn/v1 -m 'deepseek/deepseek-flash' --responses --key cpa -o reasoning_effort none -- "$1"

# 将 dotfiles 中的 Codex profile 合并到本机配置；支持 --check
[positional-arguments]
[no-cd]
generate-codex-profile +args:
  @"$HOME/.config/dotfiles/ai-agents/codex/generate-profile" "$@"

# 生成指定 Pi 预设；lite/full 后加 --check 仅检查
[positional-arguments]
[no-cd]
generate-pi-profile +args:
  @pi_node="$(mise which node --tool=node@lts)" && PATH="$(dirname "$pi_node"):$PATH" "$HOME/.config/dotfiles/ai-agents/pi/generage_pi_profile.sh" "$@"
