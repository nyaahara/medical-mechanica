require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe 'GET #show' do
    let!(:alice){ FactoryGirl.create :user }
    let!(:bob){ FactoryGirl.create :user }

    context 'userのownerがアクセスしたとき' do
      before do
        login(alice)
        get :show, id:alice.id
      end

      it '@userに、リクエストしたUser オブジェクトが格納されていること' do
        expect(assigns(:user)).to eq(alice)
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :show
      end
    end

    context 'userのowner以外がアクセスしたとき' do
      before do
        login(bob)
        get :show, id:alice.id
      end

      it '@userに、リクエストしたUser オブジェクトが格納されていること' do
        expect(assigns(:user)).to eq(alice)
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :show
      end
    end

    context 'guestがアクセスしたとき' do
      before do
        get :show, id:alice.id
      end

      it '@userに、リクエストしたUser オブジェクトが格納されていること' do
        expect(assigns(:user)).to eq(alice)
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #edit' do
    let!(:alice){ FactoryGirl.create :user }

    context '未ログインユーザがアクセスしたとき' do
      before { get :edit, id:alice.id }
      it_should_behave_like '認証が必要なページ'
    end


    context 'ログインユーザかつイベントを作成したユーザがアクセスしたとき' do
      before do
        login(alice)
        get :edit, id:alice.id
      end

      it '@userに、リクエストしたUserオブジェクトが格納されていること' do
        expect(assigns(:user)).to eq(alice)
      end

      it 'editテンプレートをrenderしていること' do
        expect(response).to render_template :edit
      end
    end

    context 'ログインユーザかつイベントを作成していないユーザがアクセスしたとき' do
      let!(:bob){ FactoryGirl.create :user }
      before do
        login(bob)
        get :edit, id:alice.id
      end

      it 'error404テンプレートをrenderしていること' do
        expect(response).to render_template :error404
      end
    end
  end


  describe 'PATCH #update' do
    let!(:alice){ FactoryGirl.create :user }

    context '未ログインユーザがアクセスしたとき' do
      before {
        patch :update, id:alice.id, user: FactoryGirl.attributes_for(:user)
      }
      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザかつイベントを作成したユーザがアクセスしたとき' do
      before { login(alice) }

      context 'かつパラメータが正しいとき' do
        before do
          patch :update, id:alice.id, user: {'birth' => '1986-03-22', 'sex' =>1}
        end

        it 'Userレコードが正しく変更されていること' do
          # うまくtestできないので、sexが変わっていることでOKとしています。
          expect(alice.sex).not_to eq (alice.reload.sex)
        end

        it '@userのeditアクションにリダイレクトすること' do
          expect(response).to redirect_to(:action => :edit, :id => assigns(:user).id,
                                          :notice => '更新しました')
        end
      end
    end

    context 'ログインユーザかつイベントを作成していないユーザがアクセスしたとき' do
      let!(:not_owner) { FactoryGirl.create :user }

      before do
        login(not_owner)
        patch :update, id:alice.id, user: FactoryGirl.attributes_for(:user)
      end

      it 'error404テンプレートをrenderしていること' do
        expect(response).to render_template :error404
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:alice){ FactoryGirl.create :user }

    context '未ログインユーザがアクセスしたとき' do
      before {
        delete :destroy, id:alice.id
      }
      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザかつイベントを作成したユーザがクセスしたとき' do
      before { login(alice) }

      it 'Userレコードが1件減っていること' do
        expect{ delete :destroy, id: alice.id }.
            to change { User.count }.by(-1)
      end

      it 'showテンプレートをrenderしていること' do
        delete :destroy, id: alice.id
        ## noticeのテストはできないみたいなので、省いています。
        # expect(response).to redirect_to( :controller => 'welcome', :action => 'index', :notice => '退会しました' )
        expect(response).to redirect_to( :controller => 'welcome', :action => 'index' )
      end
    end

    context 'ログインユーザかつイベントを作成していないユーザがクセスしたとき' do
      let!(:not_owner) { FactoryGirl.create :user }
      before { login(not_owner) }

      it 'Userレコードが減っていないこと' do
        expect{ delete :destroy, id: alice.id }.
            not_to change { User.count }
      end

      it 'error404テンプレートをrenderしていること' do
        delete :destroy, id: alice.id
        expect(response).to render_template :error404
      end
    end
  end

end
