FactoryGirl.define do
  factory :piece do 
    x_coordinate 0
    y_coordinate 0
  end

  factory :rook, parent: :piece, class: 'Rook' do
    x_coordinate 3
    y_coordinate 3
  end

  factory :bishop, parent: :piece, class: 'Bishop' do
    x_coordinate 3
    y_coordinate 3
  end

  factory :queen, parent: :piece, class: 'Queen' do
    x_coordinate 3
    y_coordinate 3
  end
end