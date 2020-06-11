require 'rails_helper'

RSpec.describe Department, type: :model do
 describe 'test associatios' do 
    it { should have_many(:users) }
    it { should have_many(:tickets) }
 end
   describe 'check validations' do 
    it { should validate_presence_of(:title) }
 end
end
