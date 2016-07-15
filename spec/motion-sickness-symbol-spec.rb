require_relative 'spec-helper'

RSpec.shared_examples "a <sym> mapping" do |symbol|
  context "with the doc `foo x#{symbol}#{symbol}foobar#{symbol}#{symbol}'" do
    let :mock do
      Mock.new "txt", "foo x#{symbol}#{symbol}foobar#{symbol}#{symbol}"
    end

    context 'with the cursor on b' do
      before :each do
        mock.feed 'fb'
      end

      context "when you type `da#{symbol}'" do
        before :each do
          mock.feed "da#{symbol}"
        end

        it "deletes `#{symbol}foobar#{symbol}'" do
          (expect mock.content).to eq "foo x#{symbol}#{symbol}"
        end

        context 'and type it again' do
          before :each do
            mock.feed "da#{symbol}"
          end

          it "deletes `#{symbol}#{symbol}foobar#{symbol}#{symbol}'" do
            (expect mock.content).to eq 'foo x'
          end
        end
      end

      context "when you type `ya'#{symbol}" do
        before :each do
          mock.feed "ya#{symbol}"
        end

        it "the cursor is on the first #{symbol} of `#{symbol}foobar#{symbol}'" do
          pos = (mock.command "echo col('.')").to_i
          (expect pos).to eq 7
        end
      end

      context "when you type `di#{symbol}'" do
        before :each do
          mock.feed "di#{symbol}"
        end

        it "deletes `foobar'" do
          (expect mock.content).to eq "foo x#{symbol}#{symbol}#{symbol}#{symbol}"
        end

        context 'and type it again' do
          before :each do
            mock.feed "di#{symbol}"
          end

          it "deletes `foobar'" do
            (expect mock.content).to eq "foo x#{symbol}#{symbol}#{symbol}#{symbol}"
          end
        end
      end

      context "when you type `yi#{symbol}'" do
        before :each do
          mock.feed "yi#{symbol}"
        end

        it "the cursor is on the f of `foobar'" do
          pos = (mock.command "echo col('.')").to_i
          (expect pos).to eq 8
        end
      end
    end
  end

  context "with the doc `foo a#{symbol}#{symbol}b#{symbol}#{symbol}'" do
    let :mock do
      Mock.new 'txt', "foo a#{symbol}#{symbol}b#{symbol}#{symbol}"
    end

    context 'with the cursor on b' do
      before :each do
        mock.feed 'fb'
      end

      context "when you type `da#{symbol}'" do
        before :each do
          mock.feed "da#{symbol}"
        end

        it "deletes `#{symbol}b#{symbol}'" do
          (expect mock.content).to eq "foo a#{symbol}#{symbol}"
        end

        context 'and type it again' do
          before :each do
            mock.feed "da#{symbol}"
          end

          it "deletes `#{symbol}#{symbol}b#{symbol}#{symbol}'" do
            (expect mock.content).to eq 'foo a'
          end
        end
      end

      context "when you type `ya#{symbol}'" do
        before :each do
          mock.feed "ya#{symbol}"
        end

        it "the cursor is on the second #{symbol}" do
          pos = (mock.command "echo col('.')").to_i
          (expect pos).to eq 7
        end
      end

      context "when you type `di#{symbol}'" do
        before :each do
          mock.feed "di#{symbol}"
        end

        it "deletes `b'" do
          (expect mock.content).to eq "foo a#{symbol}#{symbol}#{symbol}#{symbol}"
        end

        context "and type it again" do
          before :each do
            mock.feed "di#{symbol}"
          end

          it "deletes `b'" do
            (expect mock.content).to eq "foo a#{symbol}#{symbol}#{symbol}#{symbol}"
          end
        end
      end

      context "when you type `yi#{symbol}'" do
        before :each do
          mock.feed "yi#{symbol}"
        end

        it "the cursor is on the b" do
          pos = (mock.command "echo col('.')").to_i
          (expect pos).to eq 8
        end
      end
    end
  end
end

RSpec.describe 'The * symbol mapping' do
  it_behaves_like "a <sym> mapping", "*"
end

['*', '_', '-', ':', '@', '!', '?', '/', '|'].each do |char|
  RSpec.describe "The #{char} symbol mapping" do
    it_behaves_like "a <sym> mapping", char
  end
end
