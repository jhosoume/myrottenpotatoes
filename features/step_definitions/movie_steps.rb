Given("the following movies exist:") do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |movie_data|
    Movie.create! movie_data
  end
end

Given("I check all ratings") do
  Movie.all_ratings.each do |rating|
    check("ratings[#{rating}]")
  end
end

Then("I should see {string} before {string}") do |string, string2|
  assert page.body.index(string) < page.body.index(string2)
end

Given(/I check the following ratings: (.*)/) do |ratings_list|
  ratings_list.split(', ').each do |rating|
    check("ratings[#{rating}]")
  end
end

Given(/I uncheck the following ratings: (.*)/) do |ratings_list|
  ratings_list.split(', ').each do |rating|
    uncheck("ratings[#{rating}]")
  end
end

Then("I should see all of the movies") do
  assert (page.all('#movies tr').size - 1) == Movie.count()
end

