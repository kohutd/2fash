function __2fash_using_no_command
	set cmd (commandline -opc)

	if [ (count $cmd) -eq 1 ]
		return 0
	end
	return 1
end

function __2fash_using_command
	set cmd (commandline -opc)

	if [ (count $cmd) -eq 2 ]
		if  contains $cmd[2] $argv
			return 0
		end
	end
	return 1
end

function __2fash_command_has_enough_parameters
  set cmd (commandline -opc)

  if [ (count $cmd) -ge (math $argv[1] + 2) ]; and contains $cmd[2] $argv[2..-1]
    return 0
  end
  return 1
end

function __2fash_list_accounts
	find $HOME/.2fash/accounts/* -maxdepth 0 -type d -printf "%f\n"
end

# help
complete -c 2fash -f -n "__2fash_using_no_command" \
	-a "help" \
	-d "show help"
complete -c 2fash -f -n '__2fash_command_has_enough_parameters 0 h help'

# init
complete -c 2fash -f -n "__2fash_using_no_command" \
	-a "init" \
	-d "add a new account"
complete -c 2fash -f -n '__2fash_command_has_enough_parameters 0 i init'

# list
complete -c 2fash -f -n "__2fash_using_no_command" \
	-a "list" \
	-d "print accounts"
complete -c 2fash -f -n '__2fash_command_has_enough_parameters 0 ls list'

# remove
complete -c 2fash -f -n "__2fash_using_no_command" \
	-a "remove" \
	-d "remove account"
complete -c 2fash -f -n "__2fash_using_command rm remove" -a "(__2fash_list_accounts)"
complete -c 2fash -f -n '__2fash_command_has_enough_parameters 1 rm remove'

# code
complete -c 2fash -f -n "__2fash_using_no_command" \
	-a "code" \
	-d "get code for account"
complete -c 2fash -f -n "__2fash_using_command c code" -a "(__2fash_list_accounts)"
complete -c 2fash -f -n '__2fash_command_has_enough_parameters 1 c code'