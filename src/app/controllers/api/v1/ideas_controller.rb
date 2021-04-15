class Api::V1::IdeasController < ApplicationController
  before_action :all_ideas, only: [:index]
  attr_accessor :category_name

  def index
    category = Category.joins(:ideas).where(name: params[:category_name]) # カテゴリーが存在しているか親子関係をもちいて検索
    if category.blank?
      # 登録されていないカテゴリーのリクエストの場合はステータスコード404
      render status: 404, json: { status: 404 }
    else
      # category_nameが指定されている場合、該当するcategoryのideasの一覧で返す
      idea = Idea.where(category_id: category) # アイデアテーブルで該当するものを絞り込み
      @ideas = idea.map {|idea| {"id": idea.id, "category": idea.category.name, "body": idea.body}} # レスポンス用にmapで変換
      render json: @ideas
    end
  end

  def create
    @idea = IdeaForm.new(idea_params)
    if @idea.save
      render status: 201, json: { status: 201 }
    else
      render status: 422, json: { status: 422 }
    end
  end

  private

  def idea_params
    params.require(:idea_form).permit(:category_name, :body)
  end

  def all_ideas
    if params[:category_name].nil?
    # category_nameが指定されていない場合は全てのideasを返す
      category = Category.joins(:ideas)
      idea = Idea.where(category_id: category) # アイデアテーブルで該当するものを絞り込み
      ideas = idea.map {|idea| {"id": idea.id, "category": idea.category.name, "body": idea.body}} 
      render json: ideas
    end
  end
end