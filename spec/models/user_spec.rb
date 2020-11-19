require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'should have a secure password' do 
   it { should have_secure_password }
 end
  describe 'test associatios' do 
    it { should belong_to(:department) }
    it { should have_many(:comments) }
    it { should have_many(:tickets) }
    it { should have_many(:claims) }
    it { should have_many(:claimed_tickets) }
 end
   describe 'check validations' do 
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:email) }

 end

end
