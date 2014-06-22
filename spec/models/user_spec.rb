require 'rails_helper'

RSpec.describe User, :type => :model do

  describe User do
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should ensure_length_of(:nickname).is_at_most(50) }
    it { should ensure_length_of(:image_url).is_at_most(255) }
    it { should ensure_inclusion_of(:sex).in_range(0..1) }
  end

end
 
