class Airline < ApplicationRecord
  has_many :reviews, dependent: :destroy

  before_save :slugify
  
  def slugify
    self.slug = name.parameterize
  end

  def calculate_average
    return 0 unless self.reviews.size.positive?

    avg = self.reviews.average(:score).to_f.round(2) * 100
    update_column(:average_score, avg)
  end
end
