class Api::V1::IdeasController < ApplicationController
  def index
    @ideas = Idea.all
    render json: @ideas
  end

  def create
    idea = IdeaForm.new(idea_params)

    if idea.save
      render status: 201, json: { status: 201 }
    else
      render status: 422, json: { status: 422 }
    end    
  end

  private
  def idea_params
    params.require(:idea_form).permit(:category_name, :body)
  end
end
