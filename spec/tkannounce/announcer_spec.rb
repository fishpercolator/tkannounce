require 'spec_helper'

RSpec.describe TkAnnounce::Announcer do

  subject { described_class.new(db: Tempfile.new('tkannounce_spec')) }

  it { expect(subject.twitter).to be_a(Twitter::REST::Client) }
  it { expect(subject.vendors).to be_an(Array) }

  describe '#add_vendor' do
    it 'adds 1 item to vendors' do
      v = build(:vendor)
      expect { subject.add_vendor v }.to change { subject.vendors.length }.by(1)
    end
  end

  describe '#tweet_new_vendors!' do
    let(:vendors_not_in_db) { subject.vendors - subject.vendors_in_db }
    it 'tweets only those vendors that are not in the DB' do
      pending
      subject.tweet_new_vendors!
      expect(subject.twitter).to have_received(:update).exactly(vendors_not_in_db.length).times
      vendors.not_in_db.each {|v| expect(subject.twitter).to have_received(:update).with(v.name.to_regexp)}
    end
    it 'updates the DB to contain those vendors'
  end

  describe '#vendors_in_db' do
    it 'contains vendors that are already in the DB'
    it %{doesn't contain vendors that have been added since}
  end

end
