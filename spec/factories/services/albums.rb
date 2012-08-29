FactoryGirl.define do
  factory :album, :class => Services::Album do
    title 'Test Album'
    artist 'Test Artist'
  end
end
