require 'rails_helper'

RSpec.describe User, :type => :model do

  describe '#symptom' do
    it { should have_many(:symptom) }
  end

  describe User do
    it { should ensure_length_of(:nickname).is_at_most(50) }
    it { should ensure_length_of(:image_url).is_at_most(255) }
  end

  describe 'create_from_twitter_auth_hash' do
    let(:auth_hash) do
      {
          provider: 'twitter',
          uid: 'uid',
          info: {
              nickname: 'newuser',
              image: 'http://example.com/newuser.jpg'
          }
      }
    end

    context '新規登録の場合' do
      it 'Userモデルのレコード返ってくること' do
        user = User.create_from_twitter_auth_hash(auth_hash)
        expect(user.nickname).to eq 'newuser'
        expect(user.image_url).to eq 'http://example.com/newuser.jpg'
        expect(user).to be_persisted
      end
      it 'Userモデルのレコードが1件増えていること' do
        expect { User.create_from_twitter_auth_hash(auth_hash) }.to change { User.count }.from(0).to(1)
      end

    end
  end

  describe 'create_from_facebook_auth_hash' do
    let(:auth_hash) do
      {
          provider: 'facebook',
          uid: 'uid',
          info: {
              name: 'faceuser',
              image: 'http://example.com/faceuser.jpg'
          }
      }
    end

    context '新規登録の場合' do
      it 'Userモデルのレコード返ってくること' do
        user = User.create_from_facebook_auth_hash(auth_hash)
        expect(user.nickname).to eq 'faceuser'
        expect(user.image_url).to eq 'http://example.com/faceuser.jpg'
        expect(user).to be_persisted
      end
      it 'Userモデルのレコードが1件増えていること' do
        expect { User.create_from_facebook_auth_hash(auth_hash) }.to change { User.count }.from(0).to(1)
      end

    end
  end

  describe 'has_twitter?' do
    let(:twitter_user) { FactoryGirl.create(:twitter_user) }
    let(:facebook_user) { FactoryGirl.create(:facebook_user) }
    it 'twitter_userでtrueが返ってくること' do
      expect(twitter_user.has_twitter?).to be_truthy
    end
    it 'facebook_userでfalseが返ってくること' do
      expect(facebook_user.has_twitter?).to be_falsey
    end
  end

  describe 'has_facebook?' do
    let(:twitter_user) { FactoryGirl.create(:twitter_user) }
    let(:facebook_user) { FactoryGirl.create(:facebook_user) }
    it 'twitter_userでfalseが返ってくること' do
      expect(twitter_user.has_facebook?).to be_falsey
    end
    it 'facebook_userでtrueが返ってくること' do
      expect(facebook_user.has_facebook?).to be_truthy
    end

  end

  describe 'facebook_url' do
    let(:facebook_user) { FactoryGirl.create(:facebook_user) }
    it 'facebook_urlが返ってくること' do
      auth = facebook_user.auth.find_by_user_id(facebook_user.id)
      expect(facebook_user.facebook_url).to eq('https://facebook.com/'+auth.uid)
    end

  end
end
 
