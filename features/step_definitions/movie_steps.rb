# Add a declarative step here for populating the DB with movies.

#Before do
#  load File.dirname(__FILE__) + '/../../db/seeds.rb'
#end

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.

    condition = Hash.new()
    condition["title"] = movie["title"]
    condition["rating"] = movie["rating"]

    mov = Movie.find(:first, :conditions =>  condition)
    if (mov != nil)
      if (mov.release_date.to_s == ActiveSupport::TimeZone['UTC'].parse(movie["release_date"]).to_s)
        assert true
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
  assert page.html.match(/^(.*)#{e1}(.*)#{e2}(.*)$/m)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(", ")
  ratings.each do |rating|
    if (uncheck != nil)
      uncheck("ratings_" + rating)
    else
      check("ratings_" + rating)
    end
  end
end

Then /the following movies should be (in)?visible/ do |invisible, movies_table|    
  movies_table.hashes.each do |movie|
    title = movie["title"]
    rating = movie["rating"]
    release_date = dateconvert(movie["release_date"])
  
    if (invisible != nil)
      if page.respond_to? :should
        page.find('#movies').should have_no_content(title)
        page.find('#movies').should have_no_content(rating)
        page.find('#movies').should have_no_content(release_date)
      else
        assert page.find('#movies').has_no_content?(title)
        assert page.find('#movies').has_no_content?(rating)
        assert page.find('#movies').has_no_content?(release_date)
      end
    else
      if page.respond_to? :should
        page.find('#movies').should have_content(title)
        page.find('#movies').should have_content(rating)
        page.find('#movies').should have_content(release_date)
      else
        assert page.find('#movies').has_content?(title)
        assert page.find('#movies').has_content?(rating)
        assert page.find('#movies').has_content?(release_date)
      end
    end
  end
end

Then /I should see all of the movies/ do
  page.all('table#movies tr').count.should == 11
end

def dateconvert (str)
  return ActiveSupport::TimeZone['UTC'].parse(str).to_s
end
