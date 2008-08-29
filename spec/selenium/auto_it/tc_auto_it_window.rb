require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

if RUBY_PLATFORM =~ /^rwin/
  require 'selenium/auto_it'
  module Selenium
    describe AutoItWindow do
      it 'should control notepad' do
        autoit = AutoIt.load
        autoit.Run('Notepad.exe')
        window = AutoItWindow.new(autoit, 'Untitled - Notepad')
        window.wait_for_activation
        window.send_keys('some text')
        window.close
        confirm = AutoItWindow.wait_for(autoit, 'Notepad', 'Do you want to save')
        confirm.send_keys('!n')
      end
    end
  end
end
