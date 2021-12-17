class Airline < ApplicationRecord
  has_many :reviews

  before_create :slugify
  
  def slugify
    slug = name.parameterize
  end
end
