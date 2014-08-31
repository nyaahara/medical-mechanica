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

        part_params = { parts_attributes: {"1407946283982" => FactoryGirl.attributes_for(:part)} }
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

        part_params = { parts_attributes: {"1407946283982" => nil} }
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
  
  describe 'GET #edit' do
    let!(:alice){ FactoryGirl.create :user }
    let!(:symptom) { FactoryGirl.create :symptom, user: alice }

    context '未ログインユーザがアクセスしたとき' do
      before { get :edit, user_id:alice.id, id: symptom.id }
      it_should_behave_like '認証が必要なページ'
    end


    context 'ログインユーザかつイベントを作成したユーザがアクセスしたとき' do
      before do
        login(alice)
        get :edit, user_id:alice.id, id: symptom.id
      end

      it '@symptomに、リクエストしたEventオブジェクトが格納されていること' do
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
        get :edit, user_id:alice.id, id: symptom.id
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
        patch :update, user_id:alice.id, id: symptom.id, symptom: FactoryGirl.attributes_for(:symptom)
      }
      it_should_behave_like '認証が必要なページ'
    end

########## ここまでコード書いた。下はコピペのまんま

    context 'ログインユーザかつイベントを作成したユーザがアクセスしたとき' do
      before { login(alice) }

      context 'かつパラメータが正しいとき' do
        before do
          p "pppp"
          # p FactoryGirl.attributes_for(:symptom)
          #p symptom
          FactoryGirl.attributes_for(:symptom)[:parts].each do |paaa|
            p paaa
          end

          symptom.parts.each do |paaa|
            p paaa
          end
          
          p FactoryGirl.attributes_for(:part)

          # p symptom.to_json
          #symptom.parts.each do |paaa|
            #p paaa.to_json
          #end
          # {:front_or_back=>"back", :x=>50, :y=>50, :memo=>"memo75"}

          p "-------"
          # part_params = { parts_attributes: {"1407946283982" => FactoryGirl.attributes_for(:part)} }
          # subject { post :create, user_id: alice.id, symptom: FactoryGirl.attributes_for(:symptom).merge(part_params) }
          #patch :update, user: symptom.id, symptom: attributes_for(:symptom, name: 'Rails勉強会', place: '都内某所', content: 'Railsを勉強しよう', start_time: Time.zone.local(2014, 1, 1, 10, 0), end_time: Time.zone.local(2014, 1, 1, 19, 0))
          
          symptom.parts[0][:front_or_back]="front"
          symptom.parts[0][:x]="5"
          symptom.parts[0][:y]="74"
          symptom.parts[0][:memo]="メモ"

          patch :update, user_id:alice.id, id: symptom.id, symptom: symptom
          # patch :update, user_id:alice.id, id: symptom.id
        end

        it 'Eventレコードが正しく変更されていること' do
          p symptom
          symptom.reload
          p symptom
          symptom.parts.each do |paaa|
            p paaa
          end
          p "afewahg;oiawjef"
          expect(symptom.parts[0].front_or_back).to eq('front')
        end

        it '@symptomのshowアクションにリダイレクトすること' do
          expect(response).to redirect_to(event_path(assigns[:symptom]))
        end
      end

      context 'かつパラメータが不正なとき' do
        it 'Eventレコードが変更されていないこと' do
          expect { patch :update, id: symptom.id, symptom: attributes_for(:symptom, name: '', place: '都内某所', content: 'Railsを勉強しよう', start_time: Time.zone.local(2014, 1, 1, 10, 0), end_time: Time.zone.local(2014, 1, 1, 19, 0)) }.not_to change { symptom.reload } 
        end

        it 'editテンプレートをrenderしていること' do
          patch :update, id: symptom.id, symptom: attributes_for(:symptom, name: '', place: '都内某所', content: 'Railsを勉強しよう', start_time: Time.zone.local(2014, 1, 1, 10, 0), end_time: Time.zone.local(2014, 1, 1, 19, 0))
          expect(response).to render_template :edit
        end
      end
    end

    context 'ログインユーザかつイベントを作成していないユーザがアクセスしたとき' do
      let!(:not_owner) { create :user }

      before do
        login(not_owner)                                                                                                                                                                                    
        patch :update, id: symptom.id, symptom: attributes_for(:symptom)
      end

      it 'error404テンプレートをrenderしていること' do
        expect(response).to render_template :error404
      end
    end
  end

end
