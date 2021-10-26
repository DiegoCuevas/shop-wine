class Account < ApplicationRecord
  belongs_to :user
  has_ancestry

  scope :filter_user, lambda { |user| where(user_id: user) if user.present? }
  enum type_account: [:asset, :passive, :lost, :profit]
  
  def self.filter params
    all
    .filter_user(params[:user_id])
    .arrange_serializable do |parent, children|
      if children.count > 0
        {
          parent_id: parent.parent_id,
          id: parent.code,
          label: parent.name,
          value: parent,
          _children: children
        }
      else
        {
          parent_id: parent.parent_id,
          id: parent.code,
          label: parent.name,
          value: parent,
        }
      end
    end
    .sort_by{|e| e[:id]}
  end
  def self.all_parents user_id
    all.filter_user(user_id).where.not(id: 1)
  end
end
