require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'answers' do
    it { should validate_presence_of :body }
    # it { should validate_presence_of :title }
    it { should belong_to(:question) }
  end
end
