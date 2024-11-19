-- 自动关闭空的标签页
vim.api.nvim_create_autocmd("BufDelete", {
    callback = function()
        if #vim.api.nvim_list_bufs() == 0 then
            vim.cmd("tabclose")
        end
    end,
})

-- 自动将当前文件所在目录设置为 NERDTree 根目录
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("silent! lcd " .. vim.fn.expand('%:p:h'))
  end
})

-- 自动插入文件头
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = {"*.cpp", "*.cc", "*.h", "*.sh", "*.java", "*.go"},
  callback = function()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand("%:t")
    local author = "林毅波"
    local mail = "linyibo_2024@163.com"
    local time = os.date("%c")

    -- 根据文件类型插入不同的头部
    if filetype == "sh" then
      vim.fn.append(0, "#########################################################################")
      vim.fn.append(1, "# File Name:    " .. filename)
      vim.fn.append(2, "# Author:       " .. author)
      vim.fn.append(3, "# mail:         " .. mail)
      vim.fn.append(4, "# Created Time: " .. time)
      vim.fn.append(5, "#########################################################################")
      vim.fn.append(6, "#!/bin/bash")
      vim.fn.append(7, "")
    else
      vim.fn.append(0, "/* ************************************************************************")
      vim.fn.append(1, "> File Name:     " .. filename)
      vim.fn.append(2, "> Author:        " .. author)
      vim.fn.append(3, "> Created Time:  " .. time)
      vim.fn.append(4, "> Description:   ")
      vim.fn.append(5, " ************************************************************************/")
      vim.fn.append(6, "")
    end

    -- 跳转到文件末尾
    vim.cmd("normal G")
  end
})

-- 自动设置快捷键
vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
            vim.api.nvim_buf_set_keymap(
                0,
                "n",
                "<F5>",
                ":w<CR>:split<CR>:te time python3 %<CR>i",
                { silent = true, noremap = true }
            )
        end,
    })

vim.api.nvim_create_autocmd("FileType", {
        pattern = "c",
        callback = function()
            -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
            vim.api.nvim_buf_set_keymap(
                0,
                "n",
                "<F5>",
                "<ESC>:w<CR>:split<CR>:te gcc -std=c11 -Wshadow -Wall -o ./bin/ % -g  && time ./%:t:r.out<CR>i",
                { silent = true, noremap = true }
            )
        end,
    })

vim.api.nvim_create_autocmd("FileType", {
        pattern = {"cc", "cpp"},
        callback = function()
            -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
            vim.api.nvim_buf_set_keymap(
                0,
                "n",
                "<F5>",
                "<ESC>:w<CR>:split<CR>:te g++ -std=c++17 -Wshadow -Wall -o %:t:r.out % -g  && time ./%:t:r.out<CR>i",
                { silent = true, noremap = true }
            )
        end,
    })
