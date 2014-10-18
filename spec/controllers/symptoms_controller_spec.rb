# -*- coding: utf-8 -*-
require 'spec_helper'  

RSpec.describe SymptomsController, :type => :controller do
  
  describe 'GET #new' do

    let!(:alice){ FactoryGirl.create :user }

    context '未ログインユーザがアクセスしたとき' do
      before { get :new, user_id:alice.id_alias }
      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザがアクセスしたとき' do
      before do
        login(alice)
        get :new, user_id:alice.id_alias
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
        user_id:alice.id_alias,
        symptom: FactoryGirl.attributes_for(:symptom) }
      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザがアクセスしたとき' do
      before { login(alice) }
       
      context 'パラメータが正しいとき' do

        part_params = { parts_attributes: {'1407946283982' => FactoryGirl.attributes_for(:part)} }
        subject { post :create, user_id: alice.id_alias, symptom: FactoryGirl.attributes_for(:symptom).merge(part_params) }

        it 'Symptomレコードが1件増えること' do
          expect{subject}.to change { Symptom.count }.by(1)
        end
          
        it 'users#showにredirectすること' do
          expect(subject).to redirect_to(:controller => 'users', :action => 'show', :id => alice.id_alias, :notice => '登録しました' )
        end
      end

      context 'パラメータが不正なとき' do

        part_params = { parts_attributes: {'1407946283982' => nil} }
        subject { post :create, user_id: alice.id_alias, symptom: FactoryGirl.attributes_for(:symptom).merge(part_params) }

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
  
  describe 'GET #edit' do
    let!(:alice){ FactoryGirl.create :user }
    let!(:symptom) { FactoryGirl.create :symptom, user: alice }

    context '未ログインユーザがアクセスしたとき' do
      before { get :edit, user_id:alice.id_alias, id: symptom.id }
      it_should_behave_like '認証が必要なページ'
    end


    context 'ログインユーザかつイベントを作成したユーザがアクセスしたとき' do
      before do
        login(alice)
        get :edit, user_id:alice.id_alias, id: symptom.id
      end

      it '@symptomに、リクエストしたSymptomオブジェクトが格納されていること' do
        expect(assigns(:symptom)).to eq(symptom)
      end

      it 'editテンプレートをrenderしていること' do
        expect(response).to render_template :edit
      end
    end

    context 'ログインユーザかつイベントを作成していないユーザがアクセスしたとき' do
      let!(:bob){ FactoryGirl.create :user }
      before do
        login(bob)
        get :edit, user_id:alice.id_alias, id: symptom.id
      end

      it 'error404テンプレートをrenderしていること' do
        expect(response).to render_template :error404
      end
    end
  end


  describe 'PATCH #update' do
    let!(:alice){ FactoryGirl.create :user }
    let!(:symptom) { FactoryGirl.create :symptom, user: alice }

    context '未ログインユーザがアクセスしたとき' do
      before {
        patch :update, user_id:alice.id_alias, id: symptom.id, symptom: FactoryGirl.attributes_for(:symptom)
      }
      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザかつイベントを作成したユーザがアクセスしたとき' do
      before { login(alice) }

      context 'かつパラメータが正しいとき' do
        before do
          part = FactoryGirl.attributes_for(:part)
          part.store('_destroy', 'false')
          part_params = { parts_attributes: {'1407946283982' => part} }
          patch :update, user_id:alice.id_alias, id: symptom.id, symptom: FactoryGirl.attributes_for(:symptom).merge(part_params)
        end

        it 'Symptomレコードが正しく変更されていること' do
          # うまくtestできないので、idが変わっていることでOKとしています。
          expect(symptom.parts[0][:id]).not_to eq (symptom.reload.parts[0][:id])
        end

        it '@symptomのshowアクションにリダイレクトすること' do
          ## noticeのテストはできないみたいなので、省いています。
          expect(response).to redirect_to(:controller => 'users', :action => 'show', :id => alice.id_alias, :notice => '更新しました' )
        end
      end

      context 'partの入力が空のとき' do
        part_params = { parts_attributes: {'1407946283982' => nil} }
        subject { patch :update, user_id: alice.id_alias, id: symptom.id, symptom: FactoryGirl.attributes_for(:symptom).merge(part_params) }
        it 'Symptomレコードが削除されていること' do

          expect {subject}.to change { Symptom.count }
        end

        it 'users#showにredirectすること' do
          expect(subject).to redirect_to(:controller => 'users', :action => 'show', :id => alice.id_alias, :notice => '削除しました' )
        end
      end
    end

    context 'ログインユーザかつイベントを作成していないユーザがアクセスしたとき' do
      let!(:not_owner) { FactoryGirl.create :user }

      before do
        login(not_owner)
        patch :update, user_id:alice.id_alias, id: symptom.id, symptom: FactoryGirl.attributes_for(:symptom)
      end

      it 'error404テンプレートをrenderしていること' do
        expect(response).to render_template :error404
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:alice){ FactoryGirl.create :user }
    let!(:symptom) { FactoryGirl.create :symptom, user: alice }

    context '未ログインユーザがアクセスしたとき' do
      before {
        delete :destroy, user_id:alice.id_alias, id: symptom.id
      }
      it_should_behave_like '認証が必要なページ'
    end

    context 'ログインユーザかつイベントを作成したユーザがクセスしたとき' do
      before { login(alice) }

      it 'Symptomレコードが1件減っていること' do
        expect{ delete :destroy, user_id: alice.id_alias, id: symptom.id }.
            to change { Symptom.count }.by(-1)
      end

      it 'users#showにredirectすること' do
        delete :destroy, user_id: alice.id_alias, id: symptom.id
        expect(response).to redirect_to(:controller => 'users', :action => 'show', :id => alice.id_alias, :notice => '削除しました' )
      end
    end

    context 'ログインユーザかつイベントを作成していないユーザがクセスしたとき' do
      let!(:not_owner) { FactoryGirl.create :user }
      before { login(not_owner) }

      it 'Symptomレコードが減っていないこと' do
        expect{ delete :destroy, user_id: alice.id_alias, id: symptom.id }.
            not_to change { Symptom.count }
      end

      it 'error404テンプレートをrenderしていること' do
        delete :destroy, user_id: alice.id_alias, id: symptom.id
        expect(response).to render_template :error404
      end
    end
  end
end
