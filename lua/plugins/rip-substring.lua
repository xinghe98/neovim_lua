return {
  {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    keys = {
      {
        "<C-h>",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
      },
    },
    config = function()
      require("rip-substitute").setup({
        notification = {
          onSuccess = true,
          icon = "",
        },
        debug = false, -- extra notifications for debugging
        popupWin = {
          title = " rip-substitute",
          border = "single",
          matchCountHlGroup = "Keyword",
          noMatchHlGroup = "ErrorMsg",
          hideSearchReplaceLabels = false,
          ---@type "top"|"bottom"
          position = "bottom",
        },
        prefill = {
          ---@type "cursorWord"| false
          normal = "cursorWord",
          ---@type "selectionFirstLine"| false does not work with ex-command (see README).
          visual = "selectionFirstLine",
          startInReplaceLineIfPrefill = false,
        },
        keymaps = { -- normal & visual mode, if not stated otherwise
          abort = "q",
          confirmAndSubstituteInBuffer = "<CR>",
          insertModeConfirmAndSubstituteInBuffer = "<C-Enter>",
          prevSubst = "<Up>",
          nextSubst = "<Down>",
          toggleFixedStrings = "<C-f>", -- ripgrep's `--fixed-strings`
          toggleIgnoreCase = "<C-c>", -- ripgrep's `--ignore-case`
          openAtRegex101 = "R",
        },
      })
    end,
  },
}
