require 'spec_helper'

RSpec.describe TkAnnounce::Announcer do

  subject { described_class.new(db: Tempfile.new('tkannounce_spec')) }

  it { expect(subject.twitter).to be_a(Twitter::REST::Client) }
  it { expect(subject.vendors).to be_an(Array) }

  context 'with 6 vendors already in db' do
    let(:vendors) { 6.times.map { build(:vendor) } }
    before(:each) do
      subject.vendors = vendors.clone
      subject.db.save_vendors(vendors)
    end

    describe '#add_vendor' do
      it 'adds 1 item to vendors' do
        v = build(:vendor)
        expect { subject.add_vendor v }.to change { subject.vendors.length }.by(1)
      end
    end

    describe '#tweet_new_vendors!' do
      let(:new_vendors) { 3.times.map { build :vendor } }
      before(:each) do
        subject.twitter = instance_spy('Twitter::REST::Client')
        new_vendors.each {|v| subject.add_vendor v}
      end

      it 'tweets only those vendors that are not in the DB' do
        subject.tweet_new_vendors!
        expect(subject.twitter).to have_received(:update).exactly(3).times
        new_vendors.each do |v|
          expect(subject.twitter).to have_received(:update).with(v.name.to_regexp(literal: true))
          expect(subject.twitter).to have_received(:update).with(v.url.to_regexp(literal: true))
        end
      end
      it 'updates the DB to contain those vendors' do
        subject.tweet_new_vendors!
        expect(subject.vendors_in_db).to have(9).items
      end
    end

    describe '#vendors_in_db' do
      it 'contains vendors that are already in the DB' do
        expect(subject.vendors_in_db).to eq(vendors)
      end
      it %{doesn't contain vendors that have been added since} do
        subject.add_vendor(build :vendor)
        expect(subject.vendors_in_db).to eq(vendors)
      end
    end

    describe '#vendors_not_in_db' do
      let(:new_vendor) { build :vendor }
      before(:each) do
        subject.add_vendor(new_vendor)
      end
      it 'contains vendors added since' do
        expect(subject.vendors_not_in_db).to include(new_vendor)
      end
      it %{doesn't contain vendors that are in the DB} do
        expect(subject.vendors_not_in_db).to have(1).item
      end
    end
  end

end
