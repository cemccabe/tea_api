class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  validates_presence_of :title,
                        :price,
                        :status,
                        :frequency

  enum status: [:inactive, :active]
  enum frequency: [:weekly, :monthly, :yearly]
end
