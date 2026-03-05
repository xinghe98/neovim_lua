return {
  spinner = {
    -- enabled = true, -- 这是默认值
    opts = {
      -- style = "cursor-relative",
      style = "fidget",
      ["cursor-relative"] = {
        -- spinner 文本字符
        text = "",
        -- 替代方案: text = "",

        -- 动画的高亮位置（start_col, end_col 对）
        hl_positions = {
          { 0, 3 }, -- 第一个圆
          { 3, 6 }, -- 第二个圆
          { 6, 9 }, -- 第三个圆
        },

        -- 动画间隔（毫秒）
        interval = 100,

        -- Highlight groups
        hl_group = "Title", -- 激活高亮
        hl_dim_group = "NonText", -- 暗淡背景
      },
    },
  },
}
