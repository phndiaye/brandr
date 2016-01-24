FactoryGirl.define do
  factory :hunt do
    image Rack::Test::UploadedFile.new(File.open('spec/assets/Cartman.jpg'))
    user { create(:user) }
  end
end
