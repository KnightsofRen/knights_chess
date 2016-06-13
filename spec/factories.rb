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
    association :game
  end
end
