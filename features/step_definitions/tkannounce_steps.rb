def tkannounce
  if !@tkannounce
    @tkannounce = TkAnnounce::Announcer.new(db: Tempfile.new('tkannounce_cucumber'))
    allow(@tkannounce).to receive(:twitter).and_return(instance_spy('Twitter::REST::Client'))
  end
  @tkannounce
end

Given('the database is empty') do
end

Given(/^the database contains (\d+) items$/) do |items|
  vendors = items.to_i.times.map {build(:vendor)}
  tkannounce.db.save_vendors(vendors)
end

When(/^a new vendor appears with the name '(.*)'$/) do |vendor_name|
  tkannounce.add_vendor build(:vendor, name: vendor_name)
end

When(/^the scheduled task runs$/) do
  tkannounce.tweet_new_vendors!
end

Then(/^I should see a tweet announcing '(.*)'$/) do |vendor_name|
  expect(tkannounce.twitter).to have_received(:update).with(/\Q#{vendor_name}/)
end
