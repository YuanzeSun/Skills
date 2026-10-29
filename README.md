# Personal Codex Skills

这是一个 Codex skills 源码合集。每个 skill 保持独立目录，可以按需选择使用，仓库用于版本管理与跨环境同步。

## Skills

- `clear-report-writing`: 技术、实验与分析报告的写作、改写和审查。
- `ai-infra-experiments`: AI infra 性能、正确性和系统实验的设计、执行与复核。
- `personal-note-maintenance`: 中文技术笔记的分类重组、轻量改写、排版、误链接修复与查证审批；保留个人语气。

## 启用范围

仓库中保存源码，不代表所有 skill 都已安装或启用。`enabled-skills.txt` 控制链接脚本要启用的 skill，每行填写一个目录名；当前列表仅包含 `clear-report-writing`。新增 skill 不会自动加入启用列表。

## 目录约定

每个 skill 都有自己的 `SKILL.md`，相关的 `references/`、`scripts/` 和 `agents/` 放在该 skill 目录内。不要让运行中的 skill 依赖仓库根目录下未安装的共享文件。

## 按需启用

在仓库根目录运行下面的命令，会把 `enabled-skills.txt` 中列出的 skill 链接到 `$CODEX_HOME/skills` 或 `~/.codex/skills`：

```bash
./scripts/link-skills.sh
```

链接建立后，直接修改 `skills/<skill-name>/` 即可生效；提交并推送后，其他机器只需拉取仓库并运行同一个脚本。

## 日常更新

```bash
cd Skills
git pull --ff-only
./scripts/validate-skills.sh
git add skills/<skill-name>
git commit -m "skill-name: describe the change"
git push
```

校验脚本会调用当前 Codex 安装中的 `skill-creator` validator。它会校验仓库中的所有 skill，但不会启用未列入 `enabled-skills.txt` 的 skill。
