def create_album(attributes = {})
  Dupe.create(:album, attributes)
end


Given /^no albums exist$/ do
end

Given /^an album exists with title "(.*?)" and artist "(.*?)"$/ do |title, artist|
  create_album(:title => title, :artist => artist)
end


When /^I create an album "(.*?)" by "(.*?)"$/ do |title, artist|
  visit new_album_path
  fill_in "Title", :with => title
  fill_in "Artist", :with => artist
  click_button "Create Album"
end

When /^I request the album "(.*?)"$/ do |title|
  visit albums_path
  click_link title
end

When /^I update the artist of the album "(.*?)" with "(.*?)"$/ do |title, artist|
  step %{I request the album "#{title}"}
  click_link "Edit"
  fill_in "Artist", :with => artist
  click_button "Update Album"
end

When /^I delete the album "(.*?)"$/ do |title|
  step %{I request the album "#{title}"}
  click_button "Delete"
end

When /^I search for "(.*?)"$/ do |search_string|
  visit search_results_path
  fill_in "q", :with => search_string
  click_button "Find"
end


Then /^I should have the album "(.*?)" by "(.*?)"$/ do |title, artist|
  visit albums_path
  step %{I should find the album "#{title}" by "#{artist}"}
end

Then /^I should see "(.*?)"$/ do |content|
  page.should have_content(content)
end

Then /^I should not see "(.*?)"$/ do |content|
  page.should_not have_content(content)
end

Then /^I should find the album "(.*?)" by "(.*?)"$/ do |title, artist|
  page.should have_content(title)
  page.should have_content(artist)
end
