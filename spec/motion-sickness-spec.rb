require 'rspec'
require 'rspec/expectations'
require 'vimrunner'
require 'vimrunner/rspec'

Vimrunner::RSpec.configure do |config|
  config.reuse_server = true

  config.start_vim do
    vim = Vimrunner.start

    plugin_path = File.expand_path '..', (File.dirname __FILE__)
    vim.add_plugin plugin_path, 'plugin/motion-sickness.vim'

    vim
  end
end

RSpec.describe 'For basic remappings' do
  context 'the ir mapping' do
    it 'should select the inside of brackets' do
      write_file 'test.rb', 'foo[asdf]'

      vim.edit 'test.rb'
      vim.normal
      vim.feedkeys 'ggfadir'
      vim.write

      (expect (IO.read 'test.rb')).to eq <<~'EOF'
        foo[]
      EOF
    end
  end

  context 'the ar mapping' do
    it 'should select the whole brackets' do
      write_file 'test.rb', 'foo[as(d)f]'

      vim.edit 'test.rb'
      vim.normal
      vim.feedkeys 'ggfddar'
      vim.write

      (expect (IO.read 'test.rb')).to eq <<~'EOF'
        foo
      EOF
    end
  end

  context 'the ia mapping' do
    it 'should select the inside of chevrons' do
      write_file 'test.rb', 'foo< asdf >'

      vim.edit 'test.rb'
      vim.normal
      vim.feedkeys 'ggfadia'
      vim.write

      (expect (IO.read 'test.rb')).to eq <<~'EOF'
        foo<>
      EOF
    end
  end

  context 'the aa mapping' do
    it 'should select the whole chevrons' do
      write_file 'test.rb', 'foo< s((a)df >'

      vim.edit 'test.rb'
      vim.normal
      vim.feedkeys 'ggfadaa'
      vim.write

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
