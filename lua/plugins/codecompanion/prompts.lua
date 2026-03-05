return {
  ["Git Commit (CN)"] = {
    strategy = "chat",
    description = "生成中文 Git 提交信息",
    opts = {
      index = 5,
      is_slash_cmd = true,
      short_name = "commit_cn",
      auto_submit = true,
    },
    prompts = {
      {
        role = "user",
        content = function()
          return "请根据以下暂存代码的变动（git diff --staged），生成一个 Git 提交信息。\n\n"
            .. "要求：\n"
            .. "1. 使用中文。\n"
            .. "2. 遵循 Conventional Commits 规范 (feat, fix, docs, style, refactor, perf, test, chore)。\n"
            .. "3. 格式为：`<type>(<scope>): <subject>`。\n"
            .. "4. 需要来一些详细说明条目,但忽略掉一下插件、模块依赖的更新说明 \n\n"
            .. "5. 直接给结果，其他什么都不要说 \n\n"
            .. "Diff 内容:\n"
            .. vim.fn.system("git diff --staged")
        end,
      },
    },
  },
}
