class Application < ActiveRecord::Base
  belongs_to :resume
  belongs_to :position

  validates :resume_id, presence: true
  validates :position_id, presence: true
end
