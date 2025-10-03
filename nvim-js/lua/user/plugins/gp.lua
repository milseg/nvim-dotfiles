
local chat_system_prompt ="You are a general AI assistant.\n\n" 
          .. "The user provided the additional info about how they would like you to respond:\n\n" 
          .. "- If you're unsure don't guess and say you don't know instead.\n" 
          .. "- Ask question if you need clarification to provide better answer.\n" 
          .. "- Think deeply and carefully from first principles step by step.\n" 
          .. "- Zoom out first to see the big picture and then zoom in to details.\n" 
          .. "- Use Socratic method to improve your thinking and coding skills.\n" 
          .. "- Don't elide any code from your output if the answer requires coding.\n" 
          .. "- Take a deep breath; You've got this!\n"

local code_system_prompt = "You are an AI working as an expert code editor.\n\n" 
          .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n" 
          .. "GENERATE CLEAN CODE\n" 
          .. "START AND END YOUR ANSWER WITH:\n\n```"

local conf = {
  openai_api_key = require('localenv').openai_api_key,
  providers = {
    openai = {
      disable = true,
    },
    googleai = {
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:generateContent?key={{secret}}",
      secret = require('localenv').googleai_api_key,
    },
  },
  default_command_agent = "GeminiCoder", 
 	default_chat_agent = "GeminiSage", 
  agents = {
    { 
      name = "GeminiSage", 
      provider = "googleai",
      chat = true, 
      command = false, 
      -- string with model name or table with model name and parameters 
      model = { model = "gemini-2.5-pro", temperature = 1.1, top_p = 1 }, 
      -- system prompt (use this to specify the persona/role of the AI) 
      system_prompt = chat_system_prompt, 
    }, 
    { 
      name = "GeminiCoder", 
      provider = "googleai",
      chat = false, 
      command = true, 
      -- string with model name or table with model name and parameters 
      model = { model = "gemini-2.5-flash", temperature = 1.1, top_p = 1 }, 
      -- system prompt (use this to specify the persona/role of the AI) 
      system_prompt = code_system_prompt, 
    }, 
    { 
      name = "GeminiCoderPro", 
      provider = "googleai",
      chat = false, 
      command = true, 
      -- string with model name or table with model name and parameters 
      model = { model = "gemini-2.5-pro", temperature = 1.1, top_p = 1 }, 
      -- system prompt (use this to specify the persona/role of the AI) 
      system_prompt = code_system_prompt, 
    }, 
    { 
      name = "ChatGPT4", 
      provider = "openai",
      chat = true, 
      command = false, 
      -- string with model name or table with model name and parameters 
      model = { model = "gpt-4-1106-preview", temperature = 1, top_p = 1 }, 
      -- system prompt (use this to specify the persona/role of the AI) 
      system_prompt = chat_system_prompt, 
      disable = true,
    }, 
    { 
      name = "ChatGPT3-5", 
      provider = "openai",
      chat = true, 
      command = false, 
      -- string with model name or table with model name and parameters 
      model = { model = "gpt-3.5-turbo-1106", temperature = 1.1, top_p = 1 }, 
      -- system prompt (use this to specify the persona/role of the AI) 
      system_prompt = chat_system_prompt, 
    }, 
    {
      name = "CodeGPT4", 
      provider = "openai",
      chat = false, 
      command = true, 
      -- string with model name or table with model name and parameters 
      model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 }, 
      -- system prompt (use this to specify the persona/role of the AI) 
      system_prompt = code_system_prompt, 
    },
    { 
      name = "CodeGPT3-5",
      provider = "openai",
    },
  },
}

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
  config = function()
    vim.keymap.set('v', '<Leader>aw', ':GpRewrite ')
    vim.keymap.set('v', '<Leader>aa', ':GpAppend ')
    vim.keymap.set('v', '<Leader>ab', ':GpPrepend ')
    vim.keymap.set('v', '<Leader>ae', ':GpEnew ')
    vim.keymap.set('v', '<Leader>ap', ':GpChatPaste ')
    require("gp").setup(conf)
  end,
}