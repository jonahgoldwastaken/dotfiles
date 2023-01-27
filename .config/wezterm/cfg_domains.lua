local cfg = {}

cfg.ssh_domains = {
	{
		name = "taart.local",
		remote_address = "taart.local:1200",
		multiplexing = "None",
		username = "taart",
		assume_shell = "Posix",
	},
	{
		name = "jonahmeijers.com",
		remote_address = "jonahmeijers.com",
		multiplexing = "None",
		username = "jonahgold",
		assume_shell = "Posix",
	}
}

return cfg
