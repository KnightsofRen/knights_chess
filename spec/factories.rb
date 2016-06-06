FactoryGirl.define do
  factory :game do
  end

  factory :piece do
    x_coordinate 3
    y_coordinate 3
    association :game
  end
end
