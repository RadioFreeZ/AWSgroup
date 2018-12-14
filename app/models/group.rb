class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  validates :name, :description, :owner, :presence => true
end