# spec/factories/articles.rb
FactoryGirl.define do
  factory :photo do
    source "http://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Lake_Bondhus_Norway_2862.jpg/1280px-Lake_Bondhus_Norway_2862.jpg"
    caption "Lake Bondhus"
  end
end
