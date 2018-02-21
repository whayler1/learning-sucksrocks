When(/^I search for (.*)$/) do |term|
  @scores ||= {}
  @scores[term] = RockScore.for_term(term)
end

Then(/^apple should have a higher score then microsoft$/) do
  pending # Write code here that turns the phrase above into concrete actions
end