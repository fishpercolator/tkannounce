require 'tkannounce'

RSpec.describe TkAnnounce do

  subject { described_class.new(from_db: true) }

  it { expect(subject.twitter).to be_a(Twitter::REST::Client) }
  it { expect(subject.vendors).to be_an(Array) }

  describe '#add_vendor' do
    it 'adds 1 item to vendors' do
      v = build(:vendor)
      expect { subject.add_vendor v }.to change { subject.vendors.length }.by(1)
    end
  end

  describe '#tweet_new_vendors!' do
    it 'tweets only those vendors that are not in the DB'
    it 'updates the DB to contain those vendors'
  end

  describe '#vendors_from_db' do
    it 'contains vendors that are already in the DB'
    it %{doesn't contain vendors that have been added since}
  end

end
