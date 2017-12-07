require 'csv'

class Importer
  def initialize(file, type:)
    @csv_file = CSV.new(file, col_sep:";")
    @type = type
  end

  def import!
    case @type
    when :customers
      import_customers!
    when :wines
      import_wines!
    end
  end

  private

  def import_customers!
    Rails.logger.info 'Start import of customers'

    successful = 0

    @csv_file.each_with_index do |row, index|
      customer = Customer.find_or_initialize_by(id: row[0].to_i)

      customer.attributes = {
        first_name: row[2],
        last_name: row[1],
        address: row[3].to_s + "\n" + row[4].to_s + ' ' + row[5].to_s,
        phone: row[6],
        email: row[7]
      }

      Searchkick.callbacks(false) do
        if customer.valid?
          customer.save!
          successful += 1
          Rails.logger.info "Saved Nr. #{customer.id}: #{customer.full_name}"
        else
          Rails.logger.error "Invalid data: ID: #{customer.id} #{customer.errors.full_messages}"
        end
      end
    end

    Customer.reindex

    Rails.logger.info "Successfully imported #{successful} customers"
  end

  def import_wines!
    Rails.logger.info 'Start import of wines'

    successful = 0

    @csv_file.each_with_index do |row, index|
      wine = Wine.find_or_initialize_by(id: row[0].to_i)

      wine.attributes = {
        name: row[1],
        volume: row[4].try(:gsub, ',', '.').to_f,
        bottle_price: row[5].to_f,
        box_price: row[7].to_f,
        year: row[6].to_i,
        from: row[3],
        wine_type: row[2]
      }

      Searchkick.callbacks(false) do
        if wine.valid?
          wine.save!
          successful += 1
          Rails.logger.info "Saved Nr. #{wine.id}: #{wine.name}"
        else
          Rails.logger.error "Invalid data: ID: #{wine.id} #{wine.errors.full_messages}"
        end
      end
    end

    Wine.reindex

    Rails.logger.info "Successfully imported #{successful} wines"
  end
end
