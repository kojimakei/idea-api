require 'rails_helper'


describe Api::V1::IdeasController, type: :request do


  # ---------------------アイデア取得API------------------------
  describe 'GET #index' do
    before do
      @ideas = FactoryBot.create_list(:idea, 3)
      @idea_params =
        {
          "category_name": "test"
        }
    end
    it 'category_nameがパラメータに指定されていない場合は全てのideasを返却' do
      get '/api/v1/ideas'
      expect(response).to have_http_status "200" # リクエスト成功を表す200が返ってきたか確認する。
    end

    it 'category_nameが指定されている場合は該当するcategoryのideasの一覧を返却' do
      get '/api/v1/ideas', params: @idea_params
      pp response.body
      expect(response).to have_http_status "200"
    end
    
    it '登録されていないカテゴリーのリクエストの場合はステータスコード404を返却' do
      idea_params =
        {
          "category_name": "category"
        }
      get '/api/v1/ideas', params: idea_params # ダミーデータにないパラメータ
      expect(response).to have_http_status "404"
    end
  end


  # ---------------------アイデア登録API------------------------
  describe 'POST #create' do
    before do
      @idea_params = FactoryBot.attributes_for(:idea_form)
    end
    it 'category_nameとbodyがある場合はアイデア登録できる' do
      expect {
        post '/api/v1/ideas', params: { idea_form: @idea_params}
      }.to change(Idea, :count).by(1)
    end
    it 'リクエストのcategory_nameが存在しない場合、新たにカテゴリーを追加し、アイデア登録をおこなう' do
      # @idea_paramsとは異なるパラメータ(データ)を用意
      #=> すでに存在しないcategory_nameでもアイデア登録できるかどうか
      another_idea_params = FactoryBot.attributes_for(:idea_form, categoty_name: "category_name", body: "category_body")
      expect {
        post '/api/v1/ideas', params: { idea_form: another_idea_params}
      }.to change(Idea, :count).by(+1)
    end
    it 'category_nameが空の場合、アイデア登録に失敗しステータスコード422を返却' do
      idea_params = {
        idea_form: {
          categoty_name: "",
          body: "category_body"
        }
      }
      post '/api/v1/ideas', params: { idea_form: idea_params}
      expect(response).to have_http_status "422"
    end
    it 'bodyが空の場合、アイデア登録に失敗しステータスコード422を返却' do
      idea_params = {
        idea_form: {
          categoty_name: "category_name",
          body: ""
        }
      }
      post '/api/v1/ideas', params: { idea_form: idea_params}
      expect(response).to have_http_status "422"
    end
  end
end