class User < ApplicationRecord
  validates :email , uniqueness: { case_sensetive: false }, format:{ with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, multiline:true}
  scope :filter_user, lambda { |id| where(id: id) if id.present? }
  def self.search id
    all.filter_user(id)
  end
end
