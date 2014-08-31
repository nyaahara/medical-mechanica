require 'rails_helper'

RSpec.describe User, :type => :model do

  describe '#symptom' do
    it { should have_many(:symptom) }
  end

  describe User do
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should ensure_length_of(:nickname).is_at_most(50) }
    it { should ensure_length_of(:image_url).is_at_most(255) }
  end


describe '.find_or_create_from_auth_hash' do
    let(:auth_hash) do
      {
        provider: 'twitter',
        uid: 'uid',
        info: {
          nickname: 'netwillnet',
          image: 'http://example.com/netwillnet.jpg'
        }
      }
    end

    context '引数のproviderとuidに対応するUserが作成されていないとき' do
      it '引数で設定した属性のUserオブジェクトが返ること' do
        user = User.find_or_create_from_auth_hash(auth_hash)
        expect(user.provider).to eq 'twitter'
        expect(user.uid).to eq 'uid'
        expect(user.nickname).to eq 'netwillnet'
        expect(user.image_url).to eq 'http://example.com/netwillnet.jpg'
        expect(user).to be_persisted
      end

      it 'Userモデルのレコードが一件増えていること' do
        expect { User.find_or_create_from_auth_hash(auth_hash) }.
          to change { User.count }.from(0).to(1)
      end
    end

    context '引数のproviderとuidに対応するUserが作成されているとき' do
      let!(:created_user) { FactoryGirl.create :user, provider: 'twitter', uid: 'uid' }

      it '引数に対応するUserレコードのオブジェクトが返ること' do
        user = User.find_or_create_from_auth_hash(auth_hash)
        expect(user).to eq created_user
      end

      it 'Userモデルのレコード件数が変化していないこと' do
        expect { User.find_or_create_from_auth_hash(auth_hash) }.
          not_to change { User.count }
      end
    end
  end

end
 
