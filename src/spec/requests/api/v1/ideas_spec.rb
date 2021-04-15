require 'rails_helper'


describe Api::V1::IdeasController, type: :request do


  # ---------------------アイデア取得API------------------------
  describe 'GET #index' do
    it 'category_nameが指定されていない場合は全てのideasを返却' do 
      @ideas = FactoryBot.create_list(:idea, 10)

      get '/api/v1/ideas'
      json = JSON.parse(response.body)
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)      
      expect(json.length).to eq(Idea.count)
    end

    it 'category_nameが指定されている場合は該当するcategoryのideasの一覧を返却' do 
      expect do
        @idea_params = {
          idea_form: {
            categoty_name: "category_name"
          }
        }
        post "get '/api/v1/ideas'", params: @idea_params
        expect(response.status).to eq(200)
        expect(json.length).to eq(Idea.count)
      end
    end
  end


  # ---------------------アイデア登録API------------------------
  describe 'POST #create' do
    it 'category_nameとbodyがある場合はアイデア登録できる' do
        @idea_params = {
          idea_form: {
            categoty_name: "category_name",
            body: "category_body"
          }
        }
        expect do
        post "post '/api/v1/ideas'", params: @idea_params
        expect(response.status).to eq(201)
      end.to change {IdeaForm.count}.by(1)
    end

    it 'category_nameが空の場合はアイデア登録できる' do
      expect do
        @idea_params = {
          idea_form: {
            categoty_name: "",
            body: "category_body"
          }
        }
        post "post '/api/v1/ideas'", params: @idea_params
        expect(response.status).to eq(422)
      end
    end
    it 'bodyが空の場合はアイデア登録できる' do
      expect do
        @idea_params = {
          idea_form: {
            categoty_name: "category_name",
            body: ""
          }
        }
        post "post '/api/v1/ideas'", params: @idea_params
        expect(response.status).to eq(422)
      end
    end
  end
end