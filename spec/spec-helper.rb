require 'rspec'
require 'rspec/expectations'
require 'vimrunner'
require 'vimrunner/rspec'

class Mock
  attr_accessor :name

  Vimrunner::RSpec.configure do |config|
    config.reuse_server = true

    config.start_vim do
      VIM = Vimrunner.start

      plugin_path = File.expand_path '..', (File.dirname __FILE__)
      VIM.add_plugin plugin_path, 'plugin/motion-sickness.vim'

      VIM
    end
  end

  def initialize type, content
    self.name = "test.#{type}"

    File.open self.name, 'w' do |file|
      file.write "#{content}"
    end

    VIM.edit self.name
  end

  def normal string
    VIM.write
    VIM.normal string
  end

  def feed string
    VIM.write
    VIM.feedkeys string
  end

  def insert string
    VIM.write
    VIM.insert string
  end

  def command string
    VIM.write
    VIM.command string
  end

  def content
    VIM.write
    (IO.read self.name).strip
  end

  private :name=
end
