require 'rails_helper'

RSpec.describe Post do

  let(:valid_attributes) { { "title" => "title",
			     "body" => "body" } }
  

  let(:invalid_attributes) { { "title" => "",
			     "body" => "" } }

    it "has a valid factory"  do
	expect(FactoryGirl.create(:post)).to be_valid
    end
  it "is invalid with empty title" do 
	  expect( Post.create(invalid_attributes)).to_not be_valid
  end
end

