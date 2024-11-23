local ls = require("luasnip") -- 引入 LuaSnip
local s = ls.snippet -- 创建片段
local i = ls.insert_node -- 插入节点
local t = ls.text_node -- 文本节点

-- 定义 Dart 语言的代码片段
ls.add_snippets("dart", {
  -- Stateless Widget snippet
  s("clsl", {
    t("class "),
    i(1, "HomePage"),
    t(" extends StatelessWidget {"),
    t({ "", "  const " }),
    i(1),
    t("({super.key});"),
    t({ "", "", "  @override", "  Widget build(BuildContext context) {", "    return Scaffold(" }),
    t({ "", "      appBar: " }),
    i(2, "// AppBar"),
    t(","),
    t({ "", "      body: " }),
    i(3, "// Body"),
    t({ "", "    );", "  }", "}" }),
  }),

  -- Stateful Widget snippet
  s("clsf", {
    t("class "),
    i(1, "HomePage"),
    t(" extends StatefulWidget {"),
    t({ "", "  const " }),
    i(1),
    t("({super.key});"),
    t({ "", "", "  @override", "  State<" }),
    i(1),
    t("> createState() => _"),
    i(2, "SomePage"),
    t("();"),
    t({ "", "}", "", "class _" }),
    i(2),
    t(" extends State<"),
    i(1),
    t("> {"),
    t({ "", "", "  void _" }),
    i(3, "methodName"),
    t("() {"),
    t({ "", "    setState(() {", "      " }),
    i(5, "// Update State"),
    t({ "", "    });", "  }" }),
    t({ "", "", "  @override", "  Widget build(BuildContext context) {", "    return Scaffold(" }),
    i(4, "// Body"),
    t({ "", "    );", "  }", "}" }),
  }),
})
