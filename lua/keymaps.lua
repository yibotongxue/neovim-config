-- 快捷键映射
local opts = { noremap = true, silent = true }

-- 打开文件目录树
vim.keymap.set('n', ';n', ':NERDTreeToggle<CR>', opts)

-- 打开函数和变量目录树（假设使用的是 LSP 或其他插件）
vim.keymap.set('n', ';m', ':SymbolsOutline<CR>', opts)

-- 窗口跳转
vim.keymap.set('n', ';h', '<C-w>h', opts)
vim.keymap.set('n', ';l', '<C-w>l', opts)
vim.keymap.set('n', ';k', '<C-w>k', opts)
vim.keymap.set('n', ';j', '<C-w>j', opts)

-- 保存文件
vim.keymap.set('n', ';w', ':write<CR>', opts)

-- 获取当前窗口的buffer数量
local function get_current_window_buffers()
  local bufnr = vim.api.nvim_win_get_buf(0) -- 获取当前窗口的buffer编号
  local buffers = {}
  for i = 1, vim.fn.bufnr('$') do
    if vim.fn.buflisted(i) == 1 then
      table.insert(buffers, i)
    end
  end
  return #buffers -- 返回buffer的数量
end

vim.keymap.set('n', ';q', function() 
    local win_count = #vim.api.nvim_list_wins()
    local buf_count = get_current_window_buffers()
    if buf_count > 1 then
        vim.cmd('bdelete')
    elseif win_count > 1 then
        vim.cmd('close')
    else 
        vim.cmd('quit')
    end
end, opts)

-- 向上/下翻半屏
vim.keymap.set('n', ';u', '½<C-u>', opts)
vim.keymap.set('n', ';d', '½<C-d>', opts)

-- 光标快速跳转到行首/行末
vim.keymap.set('n', ';1', '^', opts)
vim.keymap.set('n', ';2', 'g_', opts)

-- 快速切换 .h 和 .cpp 文件（需要一个插件或手动设置）
vim.keymap.set('n', ';a', ':e %:r.h<CR>', opts)

-- 打开新文件
vim.keymap.set('n', ';e', ':e<CR>', opts)

-- 切回 shell
vim.keymap.set('n', ';z', '<C-Z>', opts)

-- 在 Neovim 中打开终端，并使用 ;z 快捷键
-- vim.api.nvim_set_keymap('n', ';z', ':term<CR>', { noremap = true, silent = true })

-- 水平分屏并打开文件目录
vim.keymap.set('n', ';s', ':split<CR>:NERDTreeToggle<CR>', opts)

-- 竖直分屏并打开文件目录
vim.keymap.set('n', ';v', ':vsplit<CR>:NERDTreeToggle<CR>', opts)

-- 查找关键字
-- vim.keymap.set('n', ';fw', ':Ack!<Space>', opts)

-- 查找文件名
-- vim.keymap.set('n', ';ff', ':FZF<CR>', opts)

-- 光标按顺序跳转各个窗口
vim.keymap.set('n', ';gg', '<C-w>w', opts)

-- 字符对齐（通常需要插件支持，例如 `vim-easy-align`）
vim.keymap.set('n', ';t', ':EasyAlign<Space>', opts)

-- 打开文件树
vim.keymap.set('n', ';n', ':NERDTreeToggle<CR>', opts)

-- 快速注释选中块
vim.keymap.set('v', 'gc', ':Commentary<CR>', opts)
-- 快速注释当前行
vim.keymap.set('n', 'gcc', ':Commentary<CR>', opts)
