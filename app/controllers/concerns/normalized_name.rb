module NormalizedName extend ActiveSupport::Concern
  included do
    before_validation :normalize_name

    validates :name, presence: true

    def to_s
      name.titleize
    end

    private

    # Refactor opportunity: make this smarter to disregard things like dashes, words squished together, etc.
    def normalize_name
      self.name = name.to_s.downcase
    end
  end
end
