local M = {}

---@type table<string, { default: string, choices: string[] }>
M.models = {
  openrouter = {
    default = "minimax/minimax-m2.5",
    choices = {
      "minimax/minimax-m2.5",
      "claude-3.5-sonnet",
      "claude-3.7-sonnet",
      "claude-3.7-sonnet-thought",
      "gpt-4o-2024-08-06",
      "gemini-2.0-flash-001",
    },
  },
  yunwu = {
    default = "claude-sonnet-4-6",
    choices = {
      "claude-sonnet-4-6",
      "claude-opus-4-6-thinking",
      "gemini-3-pro-preview",
    },
  },
  deepseek = {
    default = "deepseek-chat",
    choices = {
      "deepseek-chat",
      "deepseek-reasoner",
    },
  },
}

--- 追踪当前活跃的 adapter 名称（从 strategies.lua 读取初始值）
---@type string
M.active_adapter = require("plugins.codecompanion.strategies").chat.adapter or "openrouter"

--- 追踪每个 adapter 当前选中的模型
---@type table<string, string>
M.current = {}
for name, config in pairs(M.models) do
  M.current[name] = config.default
end

--- 获取 adapter 当前使用的模型
---@param adapter_name string
---@return string
function M.get_current_model(adapter_name)
  return M.current[adapter_name] or M.models[adapter_name].default
end

--- 通用模型选择器，弹出 vim.ui.select 浮窗切换模型
--- 切换模型时会同时切换对应的 adapter，并通过 CodeCompanionChat 命令开启新会话
---@param adapter_name string
function M.select_model(adapter_name)
  local config = M.models[adapter_name]
  if not config then
    vim.notify("未知的 adapter: " .. adapter_name, vim.log.levels.ERROR)
    return
  end

  -- 构建带有当前选中标记的显示列表
  local display_items = {}
  for _, model in ipairs(config.choices) do
    local prefix = (model == M.current[adapter_name]) and "● " or "  "
    table.insert(display_items, prefix .. model)
  end

  vim.ui.select(display_items, {
    prompt = "🤖 Select " .. adapter_name .. " Model:",
  }, function(choice, idx)
    if choice and idx then
      local new_model = config.choices[idx]
      M.current[adapter_name] = new_model
      M.active_adapter = adapter_name

      -- 使用 CodeCompanion 命令接口开启新会话，确保 adapter + model 正确
      vim.cmd("CodeCompanionChat adapter=" .. adapter_name .. " model=" .. new_model)

      vim.notify("✅ [" .. adapter_name .. "] → " .. new_model)
    end
  end)
end

--- 弹出 adapter 选择器，先选 adapter 再选模型
function M.select_adapter_and_model()
  local adapter_names = vim.tbl_keys(M.models)
  table.sort(adapter_names)

  -- 构建显示列表: adapter 名 + 当前模型 + 活跃标记
  local display_items = {}
  for _, name in ipairs(adapter_names) do
    local active = (name == M.active_adapter) and " ★" or ""
    table.insert(display_items, name .. "  [" .. M.current[name] .. "]" .. active)
  end

  vim.ui.select(display_items, {
    prompt = "🔌 Select Adapter:",
  }, function(_, idx)
    if idx then
      M.select_model(adapter_names[idx])
    end
  end)
end

return M
