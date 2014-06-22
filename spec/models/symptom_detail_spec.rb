require 'rails_helper'

RSpec.describe SymptomDetail, :type => :model do

  describe SymptomDetail do
    describe '#created_at' do
      # enumsの範囲を超える値をエラーとする。
      it { should validate_presence_of(:part) }
      it { should ensure_inclusion_of(:part).in_range(0..50) }

      it { should validate_presence_of(:kind) }
      it { should ensure_inclusion_of(:kind).in_range(0..3) }

      it { should validate_presence_of(:level) }
      it { should ensure_inclusion_of(:level).in_range(1..5) }
    end


  end
end
