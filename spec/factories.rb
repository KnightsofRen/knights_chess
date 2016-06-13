FactoryGirl.define do
  factory :game do
  end

  factory :piece do
    x_coordinate 3
    y_coordinate 3
    association :game
  end

  factory :king do
    x_coordinate 4
    y_coordinate 0
    association :game
  end

  factory :pawn do
    x_coordinate 0
    y_coordinate 1
    association :game
  end
end
