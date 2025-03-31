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

	write("echo 'Probe status:'\n")
	write("x cert probe 2>&1 | awk '/status_text/ {print $2}'\n")

	write("echo 'Verify status:'\n")
	write("x cert verify 2>&1 | awk '/status_text/ {print $2}'\n")

	write("echo 'Manifest status:'\n")
	write("x manifest 2>&1 | awk '/status_text/ {print $2}'\n")

	write("oclea_info\n")

	expect("login: ")
end
