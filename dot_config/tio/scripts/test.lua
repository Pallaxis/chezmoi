function Shell_Ready()
	expect("~]# ")
end

--os.execute("ffplay 10.71.0.73")
IP="10.71.0.73"
write(os.execute(string.format("alacritty -e ffplay %s", IP)))

--write("\n")
--
--if expect("~]# ", 100) == 0 then
--	write("\n")
--	expect("login: ")
--	write("root\n")
--	Shell_Ready()
--end
--write("clear\n")
--
--write("echo 'Probe status:'\n")
--write("x cert probe 2>&1 | awk '/status_text/ {print $2}'\n")
