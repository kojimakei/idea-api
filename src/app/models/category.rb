class Category < ApplicationRecord
  has_many :ideas

  def categories?
    render status: 404, json: { status: 404 } if Category.nil?
  end
end
