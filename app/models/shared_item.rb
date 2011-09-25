class SharedItem < ActiveRecord::Base
	belongs_to :share_points, :polymorphic => true
	belongs_to :resource, :polymorphic => true
	belongs_to :user
	validates_uniqueness_of :resource_id, :scope => [:shared_with_id]
end
