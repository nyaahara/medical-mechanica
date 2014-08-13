require 'rails_helper'

RSpec.describe Part, :type => :model do

  describe '#symptom' do
    it { should belong_to(:symptom) }
  end

  describe '#memo' do
    it { should ensure_length_of(:memo).is_at_most(1000) }
  end

  describe '#x' do
    it { should validate_presence_of(:x) }
    it { should ensure_inclusion_of(:x).in_range(1..310) }
  end

  describe '#y' do
    it { should validate_presence_of(:y) }
    it { should ensure_inclusion_of(:y).in_range(1..658) }
  end

  describe '#front_or_back' do
    it { should validate_presence_of(:front_or_back) }
  end

end
