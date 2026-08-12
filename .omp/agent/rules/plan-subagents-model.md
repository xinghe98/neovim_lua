---
name: plan-subagents-model
description: 制定与执行计划时必须合理使用子 agent 分工；计划末尾写明并确认每个子 agent 的模型，执行时按清单落实、核对，不得把清单当摆设
alwaysApply: true
---

# 子 Agent 分工与模型确认（计划与执行）

「计划中写明子 agent 与模型」不是目的，目的是**执行时也如此**：执行计划必须实际按分工派发子 agent、实际按确认过的模型运行。本规则同时约束计划制定与计划执行。

## 1. 计划阶段：合理加入子 agent 使用

- 计划必须把工作分解为可并行的独立切片，并为每个切片指派合适的子 agent；纯文字分解、全部由主 agent 串行单干的计划视为不合格。
- 按切片性质选择 agent 类型，不滥用、不凑数：
  - `scout`：只读调研、摸清未知代码/目录结构——便宜快速，探索性工作优先指派。
  - `librarian`：外部库/API 的源码级研究。
  - `task`：常规实现、多步修改；可并行拆多个实例。
  - `designer`：UI/UX 设计与视觉打磨。
  - `reviewer`：代码审查。
  - `security-reviewer`：安全审计。
  - `sonic`：纯机械、低推理的批量更新或数据收集。
- 真正独立的切片必须并行（单批 `tasks[]` 扇出），不得串行化；有依赖关系的切片才安排先后执行；单批不超过 32 个子 agent。
- 切片需要共享父会话全部上下文、或属于琐碎改动（单文件小改、单个符号重命名）时，可不派子 agent，但计划中须说明理由。

## 2. 计划阶段：末尾写明并确认每个子 agent 的模型

计划末尾必须包含「子 Agent 与模型清单」小节，逐条列出计划中的每个子 agent：

| Agent 标识 | 类型 | 负责切片 | 模型（具体选择器） | 依据 |
|---|---|---|---|---|
| ScoutA | scout | 摸清后端认证模块 | `@smol` → xai-oauth/grok-4.5:high | modelRoles.smol |
| WorkerB | task | 实现 X 接口 | opencode-go/deepseek-v4-flash:max | 继承主会话模型 |

- 模型必须写具体选择器（`provider/modelId`，可带 `:thinking` 后缀；或已解析的 `@role` 别名），禁止只写「默认模型」「自动」等模糊表述。
- 解析依据，优先级从高到低：
  1. `task.agentModelOverrides[agent 名]`（settings / config.yml）；
  2. agent 定义 frontmatter 的 `model:` 字段（`~/.omp/agent/agents/*.md`、项目 `.omp/agents/*.md`）；
  3. 父会话当前激活模型（未显式固定时的默认继承）。
- `@role` 别名经 `modelRoles` 展开，具体值以 `~/.omp/agent/config.yml` 的 `modelRoles` 为准（文末附当前快照）。
- 「确认」= 逐个核对上述解析链：写出的模型真实存在于模型注册表、角色已映射、provider 有可用凭据；核对时实际读取 `config.yml` 与相关 agent 定义文件，不得凭记忆填写。
- 若计划要求某子 agent 必须使用特定模型，而现有配置无法保证（无 override、frontmatter 未固定），计划必须写明固定方式（agent frontmatter `model:` 或 `task.agentModelOverrides`），不得装作已固定。

## 3. 执行阶段：按清单落实分工与模型

- 执行必须实际按计划的切片扇出子 agent：独立切片以单批 `tasks[]` 并行执行，不得由主 agent 串行单干，不得把清单只当计划文书。每个子 agent 的任务描述必须自包含（验收标准、跨切片契约、上下文要点），因为子 agent 看不到父会话对话。
- 子 agent 派发后、产出验收前，核对实际运行模型与清单一致：用 Alt+A（Agent Hub）或 hub 快照查看每个子 agent 的实际模型。发现不一致（继承默认模型、override 未生效、retry fallback 切换等）时：
  - 优先修正配置（agent frontmatter `model:` 或 `task.agentModelOverrides`）后重新派发；
  - 无法修正的，更新清单并注明实际模型与原因，不得默默偏离。
- 执行中新增或变更切片、需要新子 agent 时，先补入清单（写明模型与依据）再派发；执行期间发生的模型切换（fallback、prewalk 交接、临时提升）必须记录在最终汇报中。
- 收尾时对照清单逐项核对：每个子 agent 实际使用的模型与清单一致，作为完成标准之一；不一致且未记录说明的，不得视为完成。

## 参考：当前 modelRoles 快照（2026-08-09，以 config.yml 为准）

| role | 模型 |
|---|---|
| default | opencode-go/deepseek-v4-flash:max |
| plan | openai-codex/gpt-5.6-terra:xhigh |
| task | opencode-go/deepseek-v4-flash:max |
| smol | xai-oauth/grok-4.5:high |
| tiny | deepseek/deepseek-v4-flash:max |
| slow | openai-codex/gpt-5.6-sol:xhigh |
| designer | xai-oauth/grok-4.5:xhigh |
| commit | opencode-go/deepseek-v4-flash:max |
