require 'rspec'
require 'rspec/expectations'
require 'vimrunner'
require 'vimrunner/rspec'

Vimrunner::RSpec.configure do |config|
  config.reuse_server = true

  config.start_vim do
    VIM = Vimrunner.start

    plugin_path = File.expand_path '..', (File.dirname __FILE__)
    VIM.add_plugin plugin_path, 'plugin/motion-sickness.vim'

    VIM
  end
end

RSpec.describe 'For basic remappings' do
  context 'the ir mapping' do
    it 'should select the inside of brackets' do
      write_file 'test.rb', 'foo[asdf]'

      VIM.edit 'test.rb'
      VIM.normal
      VIM.feedkeys 'ggfadir'
      VIM.write

      (expect (IO.read 'test.rb')).to eq <<~'EOF'
        foo[]
      EOF
    end
  end

  context 'the ar mapping' do
    it 'should select the whole brackets' do
      write_file 'test.rb', 'foo[as(d)f]'

      VIM.edit 'test.rb'
      VIM.normal
      VIM.feedkeys 'ggfddar'
      VIM.write

      (expect (IO.read 'test.rb')).to eq <<~'EOF'
        foo
      EOF
    end
  end

  context 'the ia mapping' do
    it 'should select the inside of chevrons' do
      write_file 'test.rb', 'foo< asdf >'

      VIM.edit 'test.rb'
      VIM.normal
      VIM.feedkeys 'ggfadia'
      VIM.write

      (expect (IO.read 'test.rb')).to eq <<~'EOF'
        foo<>
      EOF
    end
  end

  context 'the aa mapping' do
    it 'should select the whole chevrons' do
      write_file 'test.rb', 'foo< s((a)df >'

      VIM.edit 'test.rb'
      VIM.normal
      VIM.feedkeys 'ggfadaa'
      VIM.write

      (expect (IO.read 'test.rb')).to eq <<~'EOF'
        foo
      EOF
    end
  end
end

RSpec.describe 'i<symbol> and a<symbol> mappings' do
end

RSpec.describe 'qb motions' do
end

RSpec.describe 'iqb motions' do
end

RSpec.describe 'qd motions' do
end
