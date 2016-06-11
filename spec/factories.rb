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
end
