class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  validates_presence_of :title,
                        :price,
                        :status,
                        :frequency

  enum status: { inactive: 0, active: 1 }
  enum frequency: { weekly: 1, monthly: 2, yearly: 3}
end
