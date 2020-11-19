require 'rails_helper'

RSpec.describe Ticket, type: :model do
    describe 'test associatios' do 
    it { should belong_to(:department) }
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:claims) }
    it { should have_many(:agents) }
 end
   describe 'check validations' do 
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:subject) }
 end
end
