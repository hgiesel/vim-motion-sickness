require_relative 'bowling'
require_relative 'spec_helper'

RSpec::describe Bowling, '#score' do
  context 'with no strikes or spares' do
    it 'sums the pin count for each roll' do
      bowling = Bowling.new
      20.times { bowling.hit 4 }
      expect(bowling.score).to eq 80
    end
    it 'does something else' do
      bowling = Bowling.new
      expect(bowling.score).to eq 0
    end
  end
end
RSpec::describe 'Motion-sickness' do
  context 'with something' do
    it 'should do something' do
      write_file 'test.rb', <<-EOF
        def foo
          bar
        end
      EOF

      vim.edit 'test.rb'
      vim.insert 'Hello World!'
      vim.write

      expect(IO::read('test.rb')).to eq normalize_string_indent(<<-EOF)
        Hello World!def foo
          bar
        end

      EOF
    end
  end
end
