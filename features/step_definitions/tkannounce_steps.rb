Given(/^the stored information is already up\-to\-date$/) do
  @tkannounce = TkAnnounce.new(from_db: true)
  # Mock up the internal twitter as a spy
  allow(@tkannounce).to receive(:twitter).and_return(instance_spy('Twitter::REST::Client'))
end

When(/^a new vendor appears with the name '(.*)'$/) do |vendor_name|
  @tkannounce.add_vendor build(:vendor, name: vendor_name)
end

When(/^the scheduled task runs$/) do
  @tkannounce.tweet_new_vendors!
end

Then(/^I should see a tweet announcing '(.*)'$/) do |vendor_name|
  expect(@tkannounce.twitter).to have_received(:update).with(/vendor_name/)
end
