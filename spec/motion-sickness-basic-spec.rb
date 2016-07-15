require_relative 'spec-helper'

RSpec.shared_examples "a basic remapping" do |map, mapped_char, what_is_it|
  context "with a doc `foo#{mapped_char[0]}asdf#{mapped_char[1]}'" do
    let :mock do
      Mock.new 'txt', "foo#{mapped_char[0]}asdf#{mapped_char[1]}"
    end

    context "when you type `fddi#{map}'" do
      before :each do
        mock.feed "fddi#{map}"
      end

      it "deletes the inside of the #{what_is_it}s" do
        (expect mock.content).to eq "foo#{mapped_char[0]}#{mapped_char[1]}"
      end
    end

    context "when you type `fdda#{map}'" do
      before :each do
        mock.feed "fdda#{map}"
      end

      it "deletes all of the #{what_is_it}s" do
        (expect mock.content).to eq "foo"
      end
    end
  end
end

RSpec.describe "The `r' mapping" do
  it_behaves_like "a basic remapping", "r", ['[', ']'], 'bracket'
end

RSpec.describe "The `a' mapping" do
  it_behaves_like "a basic remapping", "a", ['<', '>'], 'chevron'
end
