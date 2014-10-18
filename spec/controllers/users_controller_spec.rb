require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe 'GET #show' do
    let!(:alice){ FactoryGirl.create :user }
    let!(:symptom){ FactoryGirl.create :symptom, user: alice }

    context '自分自身がアクセスしたとき' do
      before do
        login(alice)
        get :show, id:alice.id_alias
      end

      it '@userに、リクエストしたUser オブジェクトが格納されていること' do
        expect(assigns(:user)).to eq(alice)
      end

      it '@symptoms に、userのsymptomが格納されていること' do
        expect(assigns(:symptoms)).to match_array([symptom])
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :show
      end
    end

    context '他のユーザがアクセスしたとき' do
      let!(:bob){ FactoryGirl.create :user }
      before do
        login(bob)
        get :show, id:alice.id_alias
      end

      it '@userに、リクエストしたUser オブジェクトが格納されていること' do
        expect(assigns(:user)).to eq(alice)
      end

      it '@symptoms に、userのsymptomが格納されていること' do
        expect(assigns(:symptoms)).to match_array([symptom])
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :show
      end
    end

    context 'guestがアクセスしたとき' do
      before do
        get :show, id:alice.id_alias
      end

      it '@userに、リクエストしたUser オブジェクトが格納されていること' do
        expect(assigns(:user)).to eq(alice)
      end

      it '@symptoms に、userのsymptomが格納されていること' do
        expect(assigns(:symptoms)).to match_array([symptom])
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :show
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:alice){ FactoryGirl.create :user }

    context '未ログインユーザがアクセスしたとき' do
      before {
        delete :destroy, id:alice.id_alias
      }
      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザかつイベントを作成したユーザがクセスしたとき' do
      before { login(alice) }

      it 'Userレコードが1件減っていること' do
        expect{ delete :destroy, id: alice.id_alias }.
            to change { User.count }.by(-1)
      end

      it 'showテンプレートをrenderしていること' do
        delete :destroy, id: alice.id_alias
        ## noticeのテストはできないみたいなので、省いています。
        # expect(response).to redirect_to( :controller => 'welcome', :action => 'index', :notice => '退会しました' )
        expect(response).to redirect_to( :controller => 'welcome', :action => 'index' )
      end
    end

    context 'ログインユーザかつイベントを作成していないユーザがクセスしたとき' do
      let!(:not_owner) { FactoryGirl.create :user }
      before { login(not_owner) }

      it 'Userレコードが減っていないこと' do
        expect{ delete :destroy, id: alice.id_alias }.
            not_to change { User.count }
      end

      it 'error404テンプレートをrenderしていること' do
        delete :destroy, id: alice.id_alias
        expect(response).to render_template :error404
      end
    end
  end

end
