FactoryBot.define do
    factory :post do
        content { Faker::Lorem.characters(number: 10) }

        after(:build) do |post|
            post.photos.attach(
                io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test1.png')),
                filename: 'test1.png',
                content_type: 'image/png'
            ) 
        end
    end
end