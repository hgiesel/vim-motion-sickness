require_relative 'spec-helper'

RSpec.describe 'The `ir\' mapping' do
  context 'with a doc `foo[asdf]\'' do
    let :mock do
      Mock.new 'txt', 'foo[asdf]'
    end

    context 'when you type `fddir\'' do
      before :each do
        mock.feed 'fddir'
      end

      it 'deletes the inside of the brackets' do
        (expect mock.content).to eq "foo[]"
      end
    end
  end
end

RSpec.describe 'The `ar\' mapping' do
  context 'with a doc `foo[asd(d)fgh]\'' do
    let :mock do
      Mock.new 'txt', 'foo[asd(d)fgh]'
    end

    context 'when you type `fddar\'' do
      before :each do
        mock.feed 'ffdar'
      end

      it 'deletes the whole brackets' do
        (expect mock.content).to eq 'foo'
      end
    end
  end
end

RSpec.describe 'The `ia\' mapping' do
  context 'with a doc `foo< asd(dfgh >\'' do
    let :mock do
      Mock.new 'txt', 'foo< asd(dfgh >'
    end

    context 'when you type `fddia\'' do
      before :each do
        mock.feed 'ffdia'
      end

      it 'deletes the inner chevrons' do
        (expect mock.content).to eq 'foo<>'
      end
    end
  end
end

RSpec.describe 'the `aa\' mapping' do
  context 'with a doc `foo<asd>' do
    let :mock do
      Mock.new 'txt', 'foo<asd>'
    end

    context 'when you type `fadaa\'' do
      before :each do
        mock.feed 'fadaa'
      end

      it 'deletes the whole chevrons' do
        (expect mock.content).to eq 'foo'
      end
    end
  end
end
