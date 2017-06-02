namespace :import do
  task wines: :environment do
    Rails.logger = Logger.new(STDOUT)

    file_name = ARGV[1]

    file = File.open(file_name, 'r')

    Importer.new(file, type: :wines).import!
  end

  task customers: :environment do
    Rails.logger = Logger.new(STDOUT)

    file_name = ARGV[1]

    file = File.open(file_name, 'r')

    Importer.new(file, type: :customers).import!
  end
end
