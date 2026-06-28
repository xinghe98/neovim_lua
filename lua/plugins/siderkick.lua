local function send_to_terminal(sequence)
  return function()
    local job = vim.b.terminal_job_id
    if job then
      vim.api.nvim_chan_send(job, sequence)
    end
  end
end

return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      mux = {
        backend = "zellij",
        enabled = false,
      },
      win = {
        keys = {
          stopinsert = {
            "<c-q>",
            function()
              require("config.input_method").to_en({ remember = false })
              vim.cmd.stopinsert()
            end,
            mode = "t",
            desc = "进入 Sidekick 普通模式并切英文",
          },
          insert_a = {
            "a",
            function()
              require("config.input_method").to_zh({ force = true })
              vim.cmd.startinsert()
            end,
            mode = "n",
            desc = "进入 Sidekick 输入并切中文",
          },
          opencode_page_up = { "<PageUp>", send_to_terminal("\027[5~"), mode = "n", desc = "opencode 向上翻页" },
          opencode_page_down = { "<PageDown>", send_to_terminal("\027[6~"), mode = "n", desc = "opencode 向下翻页" },
          opencode_half_page_up = { "<C-u>", send_to_terminal("\027\021"), mode = "n", desc = "opencode 向上半页" },
          opencode_half_page_down = { "<C-e>", send_to_terminal("\027[6~"), mode = "n", desc = "opencode 向下翻页" },

          -- Sidekick CLI 处于终端模式时也沿用全局的窗口方向键。
          -- 显式注册 <leader> 组合，避免 leader（空格）被直接输入到 CLI。
          -- nav_left_leader = { "<leader>n", "nav_left", mode = "t", desc = "聚焦左侧窗口" },
          -- nav_down_leader = { "<leader>e", "nav_down", mode = "t", desc = "聚焦下方窗口" },
          -- nav_up_leader = { "<leader>u", "nav_up", mode = "t", desc = "聚焦上方窗口" },
          -- nav_right_leader = { "<leader>i", "nav_right", mode = "t", desc = "聚焦右侧窗口" },
        },
      },
    },
  },
  keys = {
    -- 普通模式的 <Tab> 已用于缩进，因此用 ]a 跳转或应用下一条 AI 编辑建议。
    -- ] 前缀也延续了 Neovim 中“跳到下一项”的习惯。
    {
      "]a",
      function()
        require("sidekick").nes_jump_or_apply()
      end,
      desc = "AI 跳转/应用下一条编辑建议",
    },

    -- 高频入口：在编辑区和 Sidekick CLI 之间快速切换焦点。
    {
      "<c-.>",
      function()
        require("sidekick.cli").focus()
      end,
      mode = { "n", "t", "i", "x" },
      desc = "AI 聚焦/返回 Sidekick",
    },

    -- 延续 CodeCompanion 的 <leader>a 分组：
    -- aa 是 AI 主入口，as 负责选择模型/工具，ac 打开可执行的 AI 操作。
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "AI 打开/隐藏 Sidekick",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select({ filter = { installed = true } })
      end,
      desc = "AI 选择 CLI 工具",
    },
    {
      "<leader>ac",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "AI 选择操作提示词",
    },

    -- ad 在普通模式中 detach 会话；在可视模式中延续 CodeCompanion 的习惯，
    -- 把选中内容添加并发送给当前 AI CLI。
    -- {
    --   "<leader>ad",
    --   function()
    --     require("sidekick.cli").close()
    --   end,
    --   desc = "AI 断开当前 CLI 会话",
    -- },
    {
      "<leader>ad",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = "x",
      desc = "AI 发送选中内容",
    },

    -- 发送上下文时使用直观的 this/file 助记键。
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "n", "x" },
      desc = "AI 发送当前位置上下文",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "AI 发送当前文件",
    },
  },
}
