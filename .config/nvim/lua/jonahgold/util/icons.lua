if vim.env.TERM ~= "xterm-256color" then
	return {
		kind = {
			Text = " ",
			Method = " ",
			Function = " ",
			Constructor = " ",
			Field = " ",
			Variable = " ",
			Class = " ",
			Interface = " ",
			Module = " ",
			Package = " ",
			Property = " ",
			Unit = " ",
			Value = " ",
			Enum = " ",
			Keyword = " ",
			Snippet = " ",
			Color = " ",
			File = " ",
			Reference = " ",
			Folder = " ",
			EnumMember = " ",
			Constant = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
			Array = " ",
			Number = " ",
			String = " ",
			Boolean = " ",
			Object = " ",
			Null = " ",
			Key = " ",
			Macro = " ",
		},
		type = {
			Array = " ",
			Number = " ",
			String = " ",
			Boolean = " ",
			Object = " ",
		},
		documents = {
			File = " ",
			NewFile = " ",
			EmptyFolder = " ",
			Folder = " ",
			OpenFolder = " ",
		},
		git = {
			Add = " ",
			Mod = " ",
			Remove = " ",
			Ignore = " ",
			Rename = " ",
			Diff = " ",
			Branch = " ",
			Repo = "",
			Octoface = " ",
			Copilot = " ",
			CopilotError = " ",
			CopilotWarning = "𥉉",
		},
		dap = {
			Debug = " ",
			DebugAll = " ",
			Start = " ",
			Pause = " ",
			Continue = " ",
			Stop = " ",
			Restart = " ",
			Disconnect = " ",
			StepInto = " ",
			StepOut = " ",
			StepOver = " ",
			StepBack = " ",
			Stackframe = " ",
			StackframeActive = " ",
			Breakpoint = " ",
			ConditionBreakpoint = " ",
			LogPoint = " ",
			RejectedBreakpoint = " ",
		},
		ui = {
			Lock = " ",
			EmptyCircle = " ",
			SlashCircle = " ",
			ErrorCircle = " ",
			PassCircle = " ",
			QuestionMarkCircle = " ",
			InfoCircle = " ",
			FilledCircle = " ",
			Close = " ",
			Dash = " ",
			Search = " ",
			Lightbulb = " ",
			Project = " ",
			Dashboard = " ",
			Stopwatch = " ",
			History = " ",
			Comment = " ",
			Tag = " ",
			Bug = " ",
			Code = " ",
			Telescope = " ",
			Gear = " ",
			Package = " ",
			List = " ",
			TaskList = " ",
			SignIn = " ",
			SignOut = " ",
			Check = " ",
			Fire = " ",
			Note = " ",
			BookMark = " ",
			Pencil = " ",
			Table = " ",
			Calendar = " ",
			Download = " ",
		},
		border = {
			Horizontal = "─",
			Vertical = "│",
			TopLeft = "┌",
			TopRight = "┐",
			BottomRight = "┘",
			BottomLeft = "└",
			Cross = "┼",
			BottomIS = "┴",
			TopIS = "┬",
			LeftIS = "├",
			RightIS = "┤",
		},
		triangle = {
			Up = " ",
			Right = " ",
			Down = " ",
			Left = " ",
		},
		chevron = {
			Up = " ",
			Right = " ",
			Down = " ",
			Left = " ",
		},
		arrow = {
			Up = " ",
			Right = " ",
			Down = " ",
			Left = " ",
		},
		fold = {
			Down = " ",
			Up = " ",
			Fold = " ",
		},
		diagnostics = {
			Error = " ",
			Warn = " ",
			Info = " ",
			Question = " ",
			Hint = " ",
		},
		misc = {
			Vim = " ",
			Squirrel = " ",
			Watch = " ",
			Smiley = " ",
			Package = " ",
			Keyboard = "  ",
			Sleep = "󰒲 ",
			Terminal = " ",
		},
	}
else
	return {
		kind = {
			Text = " ",
			Method = " ",
			Function = " ",
			Constructor = " ",
			Field = " ",
			Variable = " ",
			Class = " ",
			Interface = " ",
			Module = " ",
			Package = " ",
			Property = " ",
			Unit = " ",
			Value = " ",
			Enum = " ",
			Keyword = " ",
			Snippet = " ",
			Color = " ",
			File = " ",
			Reference = " ",
			Folder = " ",
			EnumMember = " ",
			Constant = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
			Array = " ",
			Number = " ",
			String = " ",
			Boolean = " ",
			Object = " ",
			Null = " ",
			Key = " ",
			Macro = " ",
		},
		type = {
			Array = " ",
			Number = " ",
			String = " ",
			Boolean = " ",
			Object = " ",
		},
		documents = {
			File = " ",
			NewFile = " ",
			EmptyFolder = " ",
			Folder = " ",
			OpenFolder = " ",
		},
		git = {
			Add = " ",
			Mod = " ",
			Remove = " ",
			Ignore = " ",
			Rename = " ",
			Diff = " ",
			Branch = " ",
			Repo = " ",
			Octoface = " ",
			Copilot = " ",
			CopilotError = " ",
			CopilotWarning = " ",
		},
		ui = {
			Lock = " ",
			EmptyCircle = " ",
			SlashCircle = " ",
			ErrorCircle = " ",
			PassCircle = " ",
			QuestionMarkCircle = " ",
			InfoCircle = " ",
			FilledCircle = " ",
			Close = " ",
			Dash = " ",
			Search = " ",
			Lightbulb = " ",
			Project = " ",
			Dashboard = " ",
			Stopwatch = " ",
			History = " ",
			Comment = " ",
			Tag = " ",
			Bug = " ",
			Code = " ",
			Telescope = " ",
			Gear = " ",
			Package = " ",
			List = " ",
			TaskList = " ",
			SignIn = " ",
			SignOut = " ",
			Check = " ",
			Fire = " ",
			Note = " ",
			BookMark = " ",
			Pencil = " ",
			Table = " ",
			Calendar = " ",
			Download = " ",
		},
		border = {
			Horizontal = "─",
			Vertical = "│",
			TopLeft = "┌",
			TopRight = "┐",
			BottomRight = "┘",
			BottomLeft = "└",
			Cross = "┼",
			BottomIS = "┴",
			TopIS = "┬",
			LeftIS = "├",
			RightIS = "┤",
		},
		triangle = {
			Up = " ",
			Right = " ",
			Down = " ",
			Left = " ",
		},
		chevron = {
			Up = " ",
			Right = " ",
			Down = " ",
			Left = " ",
		},
		arrow = {
			Up = " ",
			Right = " ",
			Down = " ",
			Left = " ",
		},
		fold = {
			Down = " ",
			Up = " ",
			Fold = " ",
		},
		diagnostics = {
			Error = " ",
			Warn = " ",
			Info = " ",
			Question = " ",
			Hint = " ",
		},
		misc = {
			Vim = " ",
			Squirrel = " ",
			Watch = " ",
			Smiley = " ",
			Package = " ",
			Keyboard = "  ",
			Sleep = "󰒲 ",
			Terminal = " ",
		},
	}
end