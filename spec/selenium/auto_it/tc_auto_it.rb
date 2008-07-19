require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

if RUBY_PLATFORM =~ /^rwin/
  require 'selenium/auto_it'
  require 'spec'

  module Selenium
    describe AutoIt do
      it 'should control notepad' do
        autoit = AutoIt.load
        autoit.Run('Notepad.exe')
        autoit.WinWaitActive('Untitled - Notepad')
        autoit.Send('some text')
        autoit.WinClose('Untitled - Notepad')
        autoit.WinWaitActive('Notepad', 'Do you want to save')
        autoit.Send('!n')
      end
    end
  end
end
