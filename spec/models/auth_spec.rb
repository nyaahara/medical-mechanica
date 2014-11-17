require 'rails_helper'

RSpec.describe Auth, :type => :model do

  describe '#create_from_auth_hash' do
    context 'facebookにて新規登録' do
      let(:facebook_auth_hash) do
        {
            provider: 'facebook',
            uid: 'uid1',
            info: {
                name: 'facebook User',
                image: 'http://example.com/facebookuser.jpg'
            }
        }
      end
      let(:facebook_user) {
        user = User.new
        user.id = 2
        user
      }
      it 'authレコードが新規作成されていること' do
        auth = Auth.create_from_auth_hash(facebook_auth_hash,facebook_user)
        expect(auth.provider).to eq 'facebook'
        expect(auth.uid).to eq 'uid1'
        expect(auth.user_id).to eq facebook_user.id
      end
      it 'authレコードが１件増えていること' do
        expect{Auth.create_from_auth_hash(facebook_auth_hash,facebook_user)}.to change {Auth.count}.from(0).to(1)
      end
    end

    context 'twitterにて新規登録時' do
      let(:twitter_auth_hash) do
        {
            provider: 'twitter',
            uid: 'uid0',
            info: {
                nickname: 'newuser',
                image: 'http://example.com/newuser.jpg'
            }
        }
      end
      let(:twitter_user) {
        user = User.new
        user.id = 1
        user
      }
      it 'authレコードが新規作成されていること' do
        auth = Auth.create_from_auth_hash(twitter_auth_hash,twitter_user)
        expect(auth.provider).to eq 'twitter'
        expect(auth.uid).to eq 'uid0'
        expect(auth.user_id).to eq twitter_user.id
      end
      it 'authレコードが１件増えていること' do
        expect{Auth.create_from_auth_hash(twitter_auth_hash,twitter_user)}.to change {Auth.count}.from(0).to(1)
      end
    end
  end
end
