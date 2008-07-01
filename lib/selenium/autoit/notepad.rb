autoit = AutoIt.load
autoit.Run('Notepad.exe')
autoit.WinWaitActive('Untitled - Notepad')
autoit.Send('some text')
autoit.WinClose('Untitled - Notepad')
autoit.WinWaitActive('Notepad', 'Do you want to save')
autoit.Send('!n')
