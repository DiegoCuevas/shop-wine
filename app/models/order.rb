class Order < ApplicationRecord
  include AASM
  
  belongs_to :user
  
  aasm column: :payment_status do
    state :unpaid, initial: true
    state :paid
    state :pending

    event :to_pay do
      transitions from: :not_pay, to: :paid
    end
    event :not_paid do
      transitions from: :not_pay, to: :pending
    end
  end
  aasm column: :order_status do
    state :received, initial: true
    state :in_preparation
    state :in_delivery
    state :delivered

    event :to_pay do
      transitions from: :not_pay, to: :paid
    end
    event :to_pay do
      transitions from: :not_pay, to: :pending
    end
  end
end
