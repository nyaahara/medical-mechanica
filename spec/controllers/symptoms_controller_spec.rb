# -*- coding: utf-8 -*-
require 'spec_helper'  

RSpec.describe SymptomsController, :type => :controller do
  
  describe 'GET #index' do
    let!(:alice){ FactoryGirl.create :user }
    let!(:bob){ FactoryGirl.create :user }
    let!(:symptom){ FactoryGirl.create :symptom, user: alice }

    context 'symptomのownerがアクセスしたとき' do
      before do
        login(alice)
        get :index, user_id:alice.id
      end

      it '@ownerに、リクエストしたUser オブジェクトが格納されていること' do
        expect(assigns(:owner)).to eq(alice)
      end 

      it '@symptoms に、ownerのsymptomが格納されていること' do
        expect(assigns(:symptoms)).to match_array([symptom])
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :index
      end
    end

    context 'symptomのowner以外がアクセスしたとき' do
      before do
        login(bob)
        get :index, user_id:alice.id
      end

      it '@ownerに、リクエストしたUser オブジェクトが格納されていること' do
        expect(assigns(:owner)).to eq(alice)
      end 

      it '@symptoms に、ownerのsymptomが格納されていること' do
        expect(assigns(:symptoms)).to match_array([symptom])
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :index
      end
    end

    context 'guestがアクセスしたとき' do
      before do
        get :index, user_id:alice.id
      end

      it '@ownerに、リクエストしたUser オブジェクトが格納されていること' do
        expect(assigns(:owner)).to eq(alice)
      end 

      it '@symptoms に、ownerのsymptomが格納されていること' do
        expect(assigns(:symptoms)).to match_array([symptom])
      end

      it 'showテンプレートをrenderしていること' do
        expect(response).to render_template :index
      end
    end
  end
  
  describe 'GET #new' do

    let!(:alice){ FactoryGirl.create :user }

    context '未ログインユーザがアクセスしたとき' do
      before { get :new, user_id:alice.id }
      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザがアクセスしたとき' do
      before do
        login(alice)
        get :new, user_id:alice.id
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
    let!(:alice){ FactoryGirl.create :user }

    context '未ログインユーザがアクセスしたとき' do
      before { post :create,
        user_id:alice.id,
        symptom: FactoryGirl.attributes_for(:symptom) }
      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザがアクセスしたとき' do
      before { login(alice) }
       
      context 'パラメータが正しいとき' do

        part_params = { parts_attributes: {aaa: FactoryGirl.attributes_for(:part)} }
        subject { post :create, user_id: alice.id, symptom: FactoryGirl.attributes_for(:symptom).merge(part_params) }

        it 'Symptomレコードが1件増えること' do
          expect{subject}.to change { Symptom.count }.by(1)
        end
          
        it '@symptomのindexアクションにリダイレクトすること' do
          expect(subject).to redirect_to :action => :index, :user_id => assigns(:symptom).id,
            :notice => '登録しました'
        end
      end
       
      context 'パラメータが不正なとき' do

        part_params = { parts_attributes: {aaa: nil} }
        subject { post :create, user_id: alice.id, symptom: FactoryGirl.attributes_for(:symptom).merge(part_params) }

        it 'Symptomレコードの件数に変化がないこと' do
          expect{ subject }.
          not_to change { Symptom.count }
        end
         
        it 'newテンプレートをrenderしていること' do
          expect(subject).to render_template :new
        end
      end
    end
  end

end
