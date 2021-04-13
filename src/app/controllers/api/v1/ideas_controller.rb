class Api::V1::IdeasController < ApplicationController
  def index
  end

  def create
    idea = IdeaForm.new(idea_params)

    if idea.save
      render status: 201, json: { status: 201 }
    else
      render status: 422, json: { status: 422 }
    end    
  end
end
