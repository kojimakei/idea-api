class IdeaForm

  include ActiveModel::Model

  attr_accessor :body, :category_name

  validates :body, presence: true
  validates :category_name, presence: true

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      category = Category.find_or_create_by!(name: category_name)
      idea = Idea.new(body: body, category: category)
      idea.save!
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
end