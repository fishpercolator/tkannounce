require 'spec_helper'

RSpec.describe TkAnnounce::DB do

  context 'with new file' do
    subject { described_class.new(Tempfile.new('tkannounce_rspec')) }

    it 'creates the schema' do
      expect { subject.sql.execute('select * from vendors') }.not_to raise_error
    end

    describe '#vendors' do
      it 'gets all the vendors in the db' do
        vendors = 6.times.map { build(:vendor) }
        subject.save_vendors(vendors)

        expect(subject.vendors).to eq(vendors)
      end
    end

    describe '#save_vendors' do
      it 'empties the db if there are no vendors' do
        subject.save_vendors([])
        from_db = subject.sql.execute('select * from vendors')
        expect(from_db).to be_empty
      end
      it 'updates the db to the given list of vendors' do
        vendors = 6.times.map { build(:vendor) }
        subject.save_vendors(vendors)
        from_db = subject.sql.execute('select * from vendors')
        expect(from_db).to have(6).items
        vendors.each do |v|
          expect(from_db).to include([v.name, v.url])
        end
        # Do it again to make sure it's not additive
        vendors = 3.times.map { build(:vendor) }
        subject.save_vendors(vendors)
        from_db = subject.sql.execute('select * from vendors')
        expect(from_db).to have(3).items
      end
    end

  end

  context 'with extant file' do
    let (:file) { support_file 'example.sql' }
    subject { described_class.new(File.open(file)) }

    it 'opens the DB' do
      expect(subject.sql.execute('select * from vendors')).to have(4).items
    end
  end

end
