require 'rails_helper'

RSpec.describe Importer do
  it 'gets created with csv file and type' do
    expect(Importer.new(StringIO.new(''), type: :customers)).to be_an_instance_of(Importer)
  end

  context 'customers' do
    let(:data_file) do
      StringIO.new(<<~HEREDOC
          1;"Meier";"Hans";"Musterweg 12";12345;"Musterstadt";"655421";;;
          2;"Funk";"Manfred";"Nader Crest 29";12723;"West Madelynton";"024523";;;
          3;"Bruen";"Herminio";"Grady Valleys 24";25866;"Cadeport";"32402";;;
        HEREDOC
      )
    end

    subject { Importer.new(data_file, type: :customers) }

    it 'creates customers based on the file' do
      expect { subject.import! }.to change { Customer.count }.by(3)
      expect(Customer.first).to eq(
        Customer.new(
          id: 1,
          first_name: 'Hans',
          last_name: 'Meier',
          address: "Musterweg 12\n12345 Musterstadt",
          phone: '655421'
        ))
    end

    it 'updates already persisted customers' do
      Customer.create!(
        id: 1,
        first_name: 'Hans',
        last_name: 'Müller',
        phone: '12345'
      )

      expect { subject.import! }.to change { Customer.count }.by(2)
    end

    it 'logs the start and the result' do
      expect(Rails.logger).to receive(:info).exactly(5)

      subject.import!
    end

    context 'Invalid data' do
      let(:data_file) do
        StringIO.new(<<~HEREDOC
            1;"Meier";"Hans";"Musterweg 12";12345;"Musterstadt";"655421";;;
            2;;;"Nader Crest 29";12723;"West Madelynton";"024523";;;
          HEREDOC
        )
      end

      it 'skips entries where names or phone number is missing' do
        expect(Rails.logger).to receive(:error).once

        expect { subject.import! }.to change { Customer.count }.by(1)
        expect(Customer.last.first_name).to eq('Hans')
      end
    end
  end

  context 'wines' do
    let(:data_file) do
      StringIO.new(<<~HEREDOC
          1;"Rivaner";"Weiß -trocken-";"Rheinhessen";"1";4,00;"2015";24,00
          2;"Bacchus";"Weiß -feinherb-";"Rheinhessen";"1";4,00;"2015";24,00
          3;"Riesling";"Weiß -feinherb-";"Rheinhessen";"1";4,30;"2015";25,80
        HEREDOC
      )
    end

    subject { Importer.new(data_file, type: :wines) }

    it 'creates wines based on the wine file' do
      expect { subject.import! }.to change { Wine.count }.by(3)
      expect(Wine.last).to eq(
        Wine.new(
          id: 3,
          name: 'Riesling',
          volume: 1,
          bottle_price: 4.3,
          box_price: 25.80,
          year: 2015,
          from: 'Rheinhessen',
          wine_type: 'Weiß -feinherb-'
        ))
    end

    it 'updates already persisted wines' do
      Wine.create!(
        id: 3,
        name: 'Rivaner',
        volume: 1,
        bottle_price: 4.3,
        box_price: 25.80,
        year: 2015,
        from: 'Rheinhessen',
        wine_type: 'Weiß -feinherb-'
      )

      expect { subject.import! }.to change { Wine.count }.by(2)
      expect(Wine.find(3).name).to eq('Riesling')
    end

    it 'logs the start and the result' do
      expect(Rails.logger).to receive(:info).exactly(5).times

      subject.import!
    end

    context 'Invalid data' do
      let(:data_file) do
        StringIO.new(<<~HEREDOC
            1;"";"Weiß -trocken-";"Rheinhessen";"1";4,00;"2015";24,00
            4;"Rivaner";"Weiß -trocken-";"Rheinhessen";"1";;"2015";24,00
            7;"Rivaner";"Weiß -trocken-";"Rheinhessen";"1";4,00;"2015";
            5;"Bacchus";"Weiß -feinherb-";"Rheinhessen";;4,00;"2015";24,00
            9;"Riesling";"Weiß -feinherb-";"Rheinhessen";"1";4,30;"2015";25,80
          HEREDOC
        )
      end

      it 'skips entries where a field is missing' do
        expect(Rails.logger).to receive(:error).exactly(4)

        expect { subject.import! }.to change { Wine.count }.by(1)
        expect(Wine.last.name).to eq('Riesling')
      end
    end
  end
end
