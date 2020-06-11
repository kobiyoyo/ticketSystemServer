require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'test association' do
  	 it { should belong_to(:user) }
  	 it { should belong_to(:ticket) }
  end
  describe 'test validation' do
  	  it { should validate_presence_of(:content) }
  end
end
