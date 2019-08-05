namespace :import do
  desc "Import germany number plan"
  task germany_csv: :environment do
    Importers::CsvPhonesImporter.new(:germany_raw).import
  end
end
