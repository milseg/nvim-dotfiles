return {
  "robitx/gp.nvim",
  event = 'VeryLazy',
  keys = {
    { '<Leader>an', ':GpChatNew<CR>'},
    { '<Leader>af', ':GpChatFinder<CR>'},
    { '<Leader>ar', ':GpChatRespond<CR>'},
    { '<Leader>as', ':GpStop<CR>'},
    { '<Leader>at', ':GpChatToggle<CR>'},
    { '<Leader>aw', ':GpRewrite '}, -- prompts for code rewriting
    { '<Leader>aa', ':GpAppend '}, -- prompts for code append
    { '<Leader>ab', ':GpPrepend '}, -- prompts for code prepend
    { '<Leader>ae', ':GpEnew '}, -- prompts for code in new buffer
    { '<Leader>ap', ':GpChatPaste '}, -- paste selected text to last chat
  },
  opts = {
    openai_api_key = require('localenv').openai_api_key,
    agents = {
      { 
        name = "ChatGPT4", 
        chat = true, 
        command = false, 
        -- string with model name or table with model name and parameters 
        model = { model = "gpt-4-1106-preview", temperature = 1, top_p = 1 }, 
        -- system prompt (use this to specify the persona/role of the AI) 
        system_prompt = "You are a general AI assistant.\n\n" 
          .. "The user provided the additional info about how they would like you to respond:\n\n" 
          .. "- If you're unsure don't guess and say you don't know instead.\n" 
          .. "- Ask question if you need clarification to provide better answer.\n" 
          .. "- Think deeply and carefully from first principles step by step.\n" 
          .. "- Zoom out first to see the big picture and then zoom in to details.\n" 
          .. "- Use Socratic method to improve your thinking and coding skills.\n" 
          .. "- Don't elide any code from your output if the answer requires coding.\n" 
          .. "- Take a deep breath; You've got this!\n", 
      }, 
      { 
        name = "ChatGPT3-5", 
        chat = true, 
        command = false, 
        -- string with model name or table with model name and parameters 
        model = { model = "gpt-3.5-turbo-1106", temperature = 1.1, top_p = 1 }, 
        -- system prompt (use this to specify the persona/role of the AI) 
        system_prompt = "You are a general AI assistant.\n\n" 
          .. "The user provided the additional info about how they would like you to respond:\n\n" 
          .. "- If you're unsure don't guess and say you don't know instead.\n" 
          .. "- Ask question if you need clarification to provide better answer.\n" 
          .. "- Think deeply and carefully from first principles step by step.\n" 
          .. "- Zoom out first to see the big picture and then zoom in to details.\n" 
          .. "- Use Socratic method to improve your thinking and coding skills.\n" 
          .. "- Don't elide any code from your output if the answer requires coding.\n" 
          .. "- Take a deep breath; You've got this!\n", 
      }, 
      {
        name = "CodeGPT4", 
        chat = false, 
        command = true, 
        -- string with model name or table with model name and parameters 
        model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 }, 
        -- system prompt (use this to specify the persona/role of the AI) 
        system_prompt = "You are an AI working as a code editor.\n\n" 
          .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n" 
          .. "START AND END YOUR ANSWER WITH:\n\n```", 
      },
      { 
        name = "CodeGPT3-5"
      },
    }
  },
  config = function()
    vim.keymap.set('v', '<Leader>aw', ':GpRewrite ')
    vim.keymap.set('v', '<Leader>aa', ':GpAppend ')
    vim.keymap.set('v', '<Leader>ab', ':GpPrepend ')
    vim.keymap.set('v', '<Leader>ae', ':GpEnew ')
    vim.keymap.set('v', '<Leader>ap', ':GpChatPaste ')
  end,
}