RSpec::Matchers.define :allow_mass_assignment_of do |attribute|
  match do |response|
    response.class.accessible_attributes.include?(attribute)
  end
  description { "allow mass assignment of :#{attribute}" }
  failure_message_for_should { "should allow mass assignment of :#{attribute}" }
  failure_message_for_should_not { "should not allow mass assignment of :#{attribute}" }
end
