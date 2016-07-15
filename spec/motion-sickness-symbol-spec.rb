require_relative 'spec-helper'

RSpec.describe 'The i<sym> mapping' do
  context 'with the doc `foo **foobar**\'' do
    let :mock do
      Mock.new 'txt', 'foo **foobar**'
    end

    context 'with the cursor on b' do
      before :each do
        mock.feed 'fb'
      end

      context 'when you type `di*\'' do
        before :each do
          mock.feed 'di*'
        end

        it 'deletes `foobar\'' do
          (expect mock.content).to eq 'foo ****'
        end

        context 'and type it again' do
          before :each do
            mock.feed 'di*'
          end

          it 'deletes `foobar\'' do
            (expect mock.content).to eq 'foo ****'
          end
        end
      end

      context 'when you type `yi*\'' do
        before :each do
          mock.feed 'yi*'
        end

        it 'the cursor is on the f of `foobar\'' do
          pos = (mock.command 'echo col(\'.\')').to_i
          (expect pos).to eq 7
        end
      end
    end
  end
end
