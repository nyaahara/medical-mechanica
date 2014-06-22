require 'rails_helper'

RSpec.describe Symptom, :type => :model do

  describe Symptom do
    describe '#created_at' do

      context '初回利用するとき' do
        it '登録できること' do
          symptom = FactoryGirl.create(:symptom)
          expect(symptom.save).to be_truthy
        end
      end

      context '前の登録から59分経過したとき' do
        before do
          @symptom1 = FactoryGirl.create(:symptom)
          @symptom1.save
        end
        it ':created_atの入力エラーとなること' do
          symptom = Symptom.new(
                 owner_id: @symptom1[:owner_id],
                 created_at: @symptom1[:created_at] + 60 * 59)
          symptom.send(:elapsed?)
          expect(symptom.errors[:created_at]).to be_present
        end
      end

      context '前の登録から60分経過したとき' do
        before do
          @symptom1 = FactoryGirl.create(:symptom)
          @symptom1.save
        end
        it ':created_atの入力エラーとなること' do
          symptom = Symptom.new(
                 owner_id: @symptom1[:owner_id],
                 created_at: @symptom1[:created_at] + 60 * 60)
          symptom.send(:elapsed?)
          expect(symptom.errors[:created_at]).to be_blank
        end
      end

      context '前の登録から61分経過したとき' do
        before do
          @symptom1 = FactoryGirl.create(:symptom)
          @symptom1.save
        end
        it ':created_atの入力エラーとなること' do
          symptom = Symptom.new(
                 owner_id: @symptom1[:owner_id],
                 created_at: @symptom1[:created_at] + 60 * 61)
          symptom.send(:elapsed?)
          expect(symptom.errors[:created_at]).to be_blank
        end
      end

    end
  end
end
