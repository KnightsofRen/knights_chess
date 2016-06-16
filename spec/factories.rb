FactoryGirl.define do
  factory :game do
  end

  factory :piece do
    x_coordinate 3
    y_coordinate 3
    captured false
    association :game
  end

  factory :king do
    x_coordinate 4
    y_coordinate 0
    association :game
  end

  factory :queen do
    x_coordinate 3
    y_coordinate 0
    association :game
  end

  factory :pawn do
    x_coordinate 0
    y_coordinate 1
    association :game
  end

  factory :knight do
    x_coordinate 4
    y_coordinate 3
    association :game
  end

  factory :rook do
    x_coordinate 4
    y_coordinate 4
    association :game
  end

  factory :bishop do
    x_coordinate 4
    y_coordinate 4
  end
end
