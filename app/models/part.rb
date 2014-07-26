class Part < ActiveRecord::Base
  belongs_to :user
  belongs_to :sick
  belongs_to :progress

end
