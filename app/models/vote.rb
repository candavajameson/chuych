class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  #attr_accesible :value, :bookmark

  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }


  after_save :update_post

  def update_post
  	self.post.update_rank
  end
end
