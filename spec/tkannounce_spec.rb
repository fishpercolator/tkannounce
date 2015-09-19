require 'tkannounce'

RSpec.describe TkAnnounce do

  subject { described_class.new(from_db: true) }

  it { expect(subject.twitter).to be_a(Twitter::REST::Client) }
  it { expect(subject.vendors).to be_an(Array) }

  context '#add_vendor' do
    it { expect { subject.add_vendor build(:vendor)}.to change { subject.vendors.length }.by(1) }
  end

end
