function Shell_Ready()
	expect("~]# ")
end

write("\n")

while true do
	if expect("~]# ", 100) == 0 then
		write("\n")
		expect("login: ")
		write("root\n")
		Shell_Ready()
	end
	write("clear\n")

	write("PROBE=$(x cert probe 2>&1 | awk '/status_text/ {print $2}')\n")
	write([[echo -e "\e[33mProbe status: ${PROBE}\e[0m"]])
	write("\n")

	write("VERIFY=$(x cert verify 2>&1 | awk '/status_text/ {print $2}')\n")
	write([[echo -e "\e[33mVerify status: ${VERIFY}\e[0m"]])
	write("\n")

	write("MANIFEST=$(x manifest 2>&1 | awk '/status_text/ {print $2}')\n")
	write([[echo -e "\e[33mManifest status: ${MANIFEST}\e[0m"]])
	write("\n")

	write("oclea_info\n")

	expect("login: ")
end
