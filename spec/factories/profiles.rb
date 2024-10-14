# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  birthday     :date
#  gender       :integer
#  introduction :text
#  subscribed   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
FactoryBot.define do
    factory :profile do
      introduction { Faker::Lorem.characters(number: 100) }
      gender { Profile.genders.keys.sample }
      birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    end
end
