class Category < ApplicationRecord
  before_validation :normalize_name

  validates :name, presence: true

  def to_s
    name.titleize
  end

  private

  def normalize_name
    self.name = name.to_s.downcase
  end
end
