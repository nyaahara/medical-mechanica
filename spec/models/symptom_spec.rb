require 'rails_helper'

RSpec.describe Symptom, :type => :model do
  
  describe '#user' do
    it { should belong_to(:user) }
  end

  describe '#part' do
    it { should have_many(:parts) }
  end


  describe '#created_by?' do
    
    let(:symptom) { FactoryGirl.create(:symptom) }
    subject { symptom.created_by?(user) }

    context '引数が nil なとき' do
      let(:user) { nil }
      it { should be_falsey }
    end

    context '#user_id と 引数の#id が同じとき' do
      let(:user) { double('user', id: symptom.user_id) }
      it { should be_truthy }
    end
  end
end
