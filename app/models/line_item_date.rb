class LineItemDate < ApplicationRecord
  belongs_to :quote
    has_many :line_items, dependent: :destroy
  
    validates :date, presence: true, uniqueness: { scope: :quote_id }
    scope :ordered, -> { order(date: :asc) }
end


# class LineItem < ApplicationRecord
#   belongs_to :line_item_date

#   validates :name, presence: true
#   validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
#   validates :unit_price, presence: true, numericality: { greater_than: 0 }

#   delegate :quote, to: :line_item_date

#   def total_price
#     quantity * unit_price
#   end
# end
