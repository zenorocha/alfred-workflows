on run theQuery
	tell application "Finder"
		try
			set targetFolder to (folder of front window as alias)
		on error
			set targetFolder to (path to home folder)
		end try
		set targetPath to quoted form of (the POSIX path of targetFolder)
		if (theQuery as string) is not "" then
			set theCommand to (theQuery as string)
		else
			set theCommand to "cd " & targetPath
		end if
	end tell
	
	tell application "Terminal"
		activate
		set terminalWindow to ""
		if (count of windows) is greater than 0 then
			repeat with theWindow in windows
				if theWindow is not busy then
					set terminalWindow to theWindow
					set frontmost of terminalWindow to true
					exit repeat
				end if
			end repeat
		end if
		if terminalWindow is not "" then
			do script theCommand in terminalWindow
		else
			do script theCommand
		end if
	end tell
end run