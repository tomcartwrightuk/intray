class SharedItem < ActiveRecord::Base
  attr_accessible :shared_with_id, :resource_id, :user_id
  belongs_to :resource, :polymorphic => true
  belongs_to :sharer, :class_name => "User"
  belongs_to :shared_with, :class_name => "User"

  validates_uniqueness_of :resource_id, :scope => [:shared_with_id]
  validates :user_id, :presence => true
  validates :shared_with_id, :presence => true
end
