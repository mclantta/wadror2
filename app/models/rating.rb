class Rating < ActiveRecord::Base
  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

  scope :recent, -> { last(5) }

  belongs_to :beer, touch: true
  belongs_to :user

  def to_s
    "#{beer.name} #{score}"
  end
end
