require 'rails_helper'

RSpec.describe Claim, type: :model do
 describe 'test associatios' do 
 	it { should belong_to(:claimed_ticket).class_name('Ticket') }
    it { should belong_to(:agent).class_name('User') }   
 end
  
end
