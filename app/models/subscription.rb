class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  validates_presence_of :title,
                        :price,
                        :status,
                        :frequency

  enum status: { inactive: 0, active: 1 }
end
