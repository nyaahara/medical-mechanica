require 'rails_helper'

describe SymptomsController do
  describe 'GET #show' do
    let!(:symptom) { create :symptom }
    let!(:bob) { create :user, nickname: 'bob' }
    let!(:alice) { create :user, nickname: 'alice' }
    let!(:ticket_bob) { create :ticket, symptom: symptom, user: bob }
    let!(:ticket_alice) { create :ticket, symptom: symptom, user: alice }

    context 'ユーザがアクセスしたとき' do
      before { get :show, id: symptom.id }

      it '@symptom に、リクエストした Symptom オブジェクトが格納されていること' do
        expect(assigns(:symptom)).to eq(symptom)
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :show
      end
    end

  end

  describe 'GET #new' do
    context '未ログインユーザがアクセスしたとき' do
      before { get :new }

    end

    context 'ログインユーザがアクセスしたとき' do
      before do
        user = create :user
        login(user)
        get :new
      end

      it 'ステータスコードとして200が返ること' do
        expect(response.status).to eq(200)
      end

      it '@symptomに、新規Symptomオブジェクトが格納されていること' do
        expect(assigns(:symptom)).to be_a_new(Symptom)
      end

      it 'newテンプレートをrenderしていること' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do
    context '未ログインユーザがアクセスしたとき' do
      before { post :create, symptom: attributes_for(:symptom) }

    end

    context 'ログインユーザがアクセスしたとき' do
      let!(:bob) { create :user, nickname: 'bob' }
      before { login(bob) }

      context 'パラメータが正しいとき' do
        it 'Symptomレコードが1件増えること' do
          expect { post :create, symptom: attributes_for(:symptom) }.
            to change { Symptom.count }.by(1)
        end

        it '@symptomのshowアクションにリダイレクトすること' do
          post :create, symptom: attributes_for(:symptom)
          expect(response).to redirect_to(symptom_path(assigns[:symptom]))
        end
      end

      context 'パラメータが不正なとき' do
        it 'Symptomレコードの件数に変化がないこと' do
          expect { post :create, symptom: attributes_for(:invalid_symptom) }.
            not_to change { Symptom.count }
        end

        it 'newテンプレートをrenderしていること' do
          post :create, symptom: attributes_for(:invalid_symptom)
          expect(response).to render_template :new
        end
      end
    end
  end
end
