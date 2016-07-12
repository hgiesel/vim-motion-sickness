require_relative 'spec_helper'

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
