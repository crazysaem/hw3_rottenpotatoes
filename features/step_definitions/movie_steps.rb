# Add a declarative step here for populating the DB with movies.

Before do
  load File.dirname(__FILE__) + '/../../db/seeds.rb'
end

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    # puts movie
    condition = Hash.new()
    condition["title"] = movie["title"]
    condition["rating"] = movie["rating"]
    # puts condition
    mov = Movie.find(:first, :conditions =>  condition)
    if (mov != nil)
      if (mov.release_date.to_s == ActiveSupport::TimeZone['UTC'].parse(movie["release_date"]).to_s)
        assert true
        puts "true"
      else
        assert false
      end
    else
      assert false
    end
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end
