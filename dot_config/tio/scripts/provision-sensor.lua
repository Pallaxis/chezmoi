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

	write("hydra_provision -i 0 -s 0x0101 0x0401 -s 0x0401 0x0a00 -s 0x0402 0x05a0 -s 0x0403 0x001e -s 0x0103 0x0101\n")
	write("hydra\n")

	expect("login: ")
end
