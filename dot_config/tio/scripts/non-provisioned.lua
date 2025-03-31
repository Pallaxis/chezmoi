-- Tests both hydra and non hydra streaming, before wiping hydra
-- Assumes you have the IP already, as it shouldn't change while testing sensors.

function shell_ready()
	expect("~]# ")
end

write("\n")

while true do
	if expect("~]# ", 100) == 0 then
		write("\n")
		expect("login: ")
		write("root\n")
		shell_ready()
	end
	write("clear\n")
	shell_ready()

	write("hydra_provision -i 0 -s 0x0101 0x0103 -s 0x0401 0x0780 -s 0x0402 0x0438 -s 0x0403 0x001e -s 0\n")
	shell_ready()

	write("oclea_gstreamer_interactive_example -r\n")
	expect(">>>")
	sleep(6)

	write("exit\n")
	shell_ready()

	write("hydra_provision -i 0 -e\n")

	expect("login: ")
end
