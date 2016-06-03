require 'rails_helper'

RSpec.describe Bishop, type: :model do
  it "should return invalid input if destination is same as current position" do
    current_piece = FactoryGirl.create(:bishop)
    expect(current_piece.obstructed?(3,3)).to eq("Error: invalid input")
  end

  it "should return invalid input if destination is out of bounds" do
    current_piece = FactoryGirl.create(:bishop)
    expect(current_piece.obstructed?(8,8)).to eq("Error: invalid input")
  end

  it "should return invalid input if destination is not a valid diagonal move" do
    current_piece = FactoryGirl.create(:bishop)
    expect(current_piece.obstructed?(3,7)).to eq("Error: invalid input")
  end

  it "should return true if there is an obstruction" do
    current_piece = FactoryGirl.create(:bishop)
    another_piece = FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 5)
    expect(current_piece.obstructed?(7,7)).to eq(true)
  end

  it "should return false if there is no obstruction" do
    current_piece = FactoryGirl.create(:bishop)
    another_piece = FactoryGirl.create(:piece, x_coordinate: 2, y_coordinate: 4)
    expect(current_piece.obstructed?(5,1)).to eq(false)
  end
end
