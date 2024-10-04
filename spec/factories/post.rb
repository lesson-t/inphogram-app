require 'open-uri'

FactoryBot.define do
    factory :post do
        content { Faker::Lorem.characters(number: 10) }

        after(:build) do |post|
            image_url = Faker::LoremFlickr.image(size: "300x300", search_terms: ['nature'])
            post.photos.attach(
                io: URI.open(image_url),
                filename: 'random_image.jpg',
                content_type: 'image/jpg'
            ) 
        end
    end
end