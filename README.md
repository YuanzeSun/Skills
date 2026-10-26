# Personal Codex Skills

这是个人自用的 Codex skills 源码仓库。每个 skill 保持独立目录，GitHub 仓库作为版本库，203 节点上的工作副本作为主要编辑位置。

## Skills

- `clear-report-writing`: 技术、实验与分析报告的写作、改写和审查。
- `ai-infra-experiments`: AI infra 性能、正确性和系统实验的设计、执行与复核。

## 目录约定

每个 skill 都有自己的 `SKILL.md`，相关的 `references/`、`scripts/` 和 `agents/` 放在该 skill 目录内。不要让运行中的 skill 依赖仓库根目录下未安装的共享文件。

## 203 节点使用

仓库位于 `~/personal-codex-skills`。运行下面的命令会把仓库中的每个 skill 链接到 `$CODEX_HOME/skills` 或 `~/.codex/skills`：

```bash
./scripts/link-skills.sh
```

链接建立后，直接修改 `skills/<skill-name>/` 即可生效；提交并推送后，其他机器只需拉取仓库并运行同一个脚本。

## 日常更新

```bash
cd ~/personal-codex-skills
git pull --ff-only
./scripts/validate-skills.sh
git add skills/<skill-name>
git commit -m "skill-name: describe the change"
git push
```

校验脚本会调用当前 Codex 安装中的 `skill-creator` validator。它只检查结构和 frontmatter，不替代实际任务测试。
