Given('the database is empty') do
  @tkannounce = TkAnnounce::Announcer.new(db: Tempfile.new('tkannounce_cucumber'))
  allow(@tkannounce).to receive(:twitter).and_return(instance_spy('Twitter::REST::Client'))
end

Given(/^the database contains (\d+) items$/) do |items|
  step 'the database is empty'
  items.to_i.times do
    @tkannounce.db.add_vendor build(:vendor)
  end
end

When(/^a new vendor appears with the name '(.*)'$/) do |vendor_name|
  @tkannounce.add_vendor build(:vendor, name: vendor_name)
end

When(/^the scheduled task runs$/) do
  @tkannounce.tweet_new_vendors!
end

Then(/^I should see a tweet announcing '(.*)'$/) do |vendor_name|
  expect(@tkannounce.twitter).to have_received(:update).with(/\Q#{vendor_name}/)
end
