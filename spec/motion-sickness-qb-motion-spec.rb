require_relative 'spec-helper'

RSpec.describe 'For the qb motion' do
  context 'without extended reach' do
    context "with the doc `uvw foo(baz) xyz'" do
      let :mock do
        Mock.new 'txt', 'uvw foo(baz) xyz'
      end

      context 'with the cursor on b of baz' do
        before :each do
          mock.feed 'fb'
        end

        describe "when you type `dqb'" do
          before :each do
            mock.feed 'dqb'
          end

          it "deletes `foo(baz)'" do
            (expect mock.content).to eq 'uvw  xyz'
          end
        end
      end
    end
  end
  context 'with extended reach' do
  end
end

RSpec.describe 'For the qB motion' do
  context 'without extended reach' do
  end

  context 'with extended reach' do
  end
end

RSpec.describe 'For the qr motion' do
  context 'without extended reach' do
  end

  context 'with extended reach' do
  end
end

RSpec.describe 'For the qa motion' do
  context 'without extended reach' do
  end

  context 'with extended reach' do
  end
end

RSpec.describe 'For the q<space> motion' do
  context 'without extended reach' do
  end

  context 'with extended reach' do
  end
end


RSpec.describe 'For the Qb motion' do
  context 'without extended reach' do
  end

  context 'with extended reach' do
  end
end

RSpec.describe 'For the QB motion' do
  context 'without extended reach' do
  end

  context 'with extended reach' do
  end
end

RSpec.describe 'For the Qr motion' do
  context 'without extended reach' do
  end

  context 'with extended reach' do
  end
end

RSpec.describe 'For the Qa motion' do
  context 'without extended reach' do
  end

  context 'with extended reach' do
  end
end

RSpec.describe 'For the Q<space> motion' do
  context 'without extended reach' do
  end

  context 'with extended reach' do
  end
end
