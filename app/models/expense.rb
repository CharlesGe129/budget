class Expense < ApplicationRecord
  belongs_to :category
  scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }
end
