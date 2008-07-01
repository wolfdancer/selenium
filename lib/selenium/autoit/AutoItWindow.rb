$:.unshift File.join(File.dirname(__FILE__))

require 'AutoIt'

class AutoItWindow
  def initialize(autoit, title, text=nil)
    @autoit = autoit
    @title = title
    @text = text
  end

  def activate
    @autoit.WinActivate(@title, @text)
  end

  def active?
    1 == @autoit.WinActive(@title, @text)
  end

  def state
    AutoItWindowState.new(@autoit.WinGetState(@title, @text))
  end

  def type(keys)
    activate_if_needed
    @autoit.Send(keys)
  end

  def activate_if_needed
    winstate = state
    activate unless winstate.active?
  end
end

class AutoItWindowState
  def initialize(state)
    @state = state
  end

  def exists?
    @state & 1 > 0
  end

  def visible?
    @state & 2 > 0
  end

  def enabled?
    @state & 4 > 0
  end

  def active?
    @state & 8 > 0
  end

  def minimized?
    @state & 16 > 0
  end

  def maxmized?
    @state & 32 > 0
  end
end
