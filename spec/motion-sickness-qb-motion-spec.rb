require_relative 'spec-helper'

RSpec.shared_examples "a qb mapping" do |map, mapped_chars|


  context "with the doc `foo#{mapped_chars[0]}bar#{mapped_chars[1]}'" do
    let :mock do
      Mock.new 'txt', "foo#{mapped_chars[0]}bar#{mapped_chars[1]}"
    end

    context 'with the cursor on b' do
      before :each do
        mock.feed 'fb'
      end

      describe "when you type `dq#{map}'" do
        before :each do
          mock.feed "dq#{map}"
        end

        it "deletes `foo#{mapped_chars[0]}bar#{mapped_chars[1]}'" do
          (expect mock.content).to eq ''
        end
      end
    end

    context 'with the cursor on f' do
      describe "when you type `dq#{map}'" do
        before :each do
          mock.feed "dq#{map}"
        end

        it "deletes `foo#{mapped_chars[0]}bar#{mapped_chars[1]}'" do
          (expect mock.content).to eq ''
        end
      end
    end

    context "with the cursor on #{mapped_chars[0]}" do
      before :each do
        mock.feed "f#{mapped_chars[0]}"
      end

      describe "when you type `dq#{map}'" do
        before :each do
          mock.feed "dq#{map}"
        end

        it "deletes `foo#{mapped_chars[0]}bar#{mapped_chars[1]}'" do
          (expect mock.content).to eq ''
        end
      end
    end

    context "with the cursor on #{mapped_chars[1]}" do
      before :each do
        mock.feed "f#{mapped_chars[1]}"
      end

      describe "when you type `dq#{map}'" do
        before :each do
          mock.feed "dq#{map}"
        end

        it "deletes `foo#{mapped_chars[0]}bar#{mapped_chars[1]}'" do
          (expect mock.content).to eq ''
        end
      end
    end
  end
end

RSpec.describe 'For the qb motion' do
  it_behaves_like "a qb mapping", 'b', ['(', ')']
end

RSpec.describe 'For the qB motion' do
  it_behaves_like "a qb mapping", 'B', ['{', '}']
end

RSpec.describe 'For the qr motion' do
  it_behaves_like "a qb mapping", 'r', ['[', ']']
end

RSpec.describe 'For the qa motion' do
  it_behaves_like "a qb mapping", 'a', ['<', '>']
end

RSpec.describe 'For the q<space> motion' do
end
