require 'rails_helper'

RSpec.describe Rook, type: :model do
  it "should return invalid input if destination is same as current position" do
    current_piece = FactoryGirl.create(:rook)
    expect(current_piece.obstructed?(3,3)).to eq("Error: invalid input")
  end

  it "should return invalid input if destination is out of bounds" do
    current_piece = FactoryGirl.create(:rook)
    expect(current_piece.obstructed?(3,10)).to eq("Error: invalid input")
  end

  it "should return invalid input if destination is not a valid hv move" do
    current_piece = FactoryGirl.create(:rook)
    expect(current_piece.obstructed?(5,6)).to eq("Error: invalid input")
  end

  it "should return true if there is an obstruction" do
    current_piece = FactoryGirl.create(:rook)
    another_piece = FactoryGirl.create(:piece, x_coordinate: 6, y_coordinate: 3)
    expect(current_piece.obstructed?(7,3)).to eq(true)
  end

  it "should return false if there is no obstruction" do
    current_piece = FactoryGirl.create(:rook)
    another_piece = FactoryGirl.create(:piece, x_coordinate: 1, y_coordinate: 7)
    expect(current_piece.obstructed?(3,4)).to eq(false)
  end

end
