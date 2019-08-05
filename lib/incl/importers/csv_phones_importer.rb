require 'csv'

module Importers
  class CsvPhonesImporter
    CONVERTION = {
      prefix: 'prefix',
      max_length: 'max len',
      min_length: 'min len',
      usage: 'usage',
      comment: 'comment',
    }.freeze

    BATCH_MAX_SIZE = 100

    attr_reader :file_name

    def initialize(file_name)
      @file_name = file_name
      @batch_size = 0
      @batch = []
    end

    def import
      read_file do |entry|
        add_to_batch(entry)
        save_batch if @batch_size >= BATCH_MAX_SIZE
      end
      save_batch
    end

    private

    def add_to_batch(entry)
      @batch << entry
      @batch_size += 1
    end

    def save_batch
      NumberPlanEntry.transaction do
        NumberPlanEntry.create!(@batch)
      end
      @batch_size = 0
      @batch = []
    end

    def read_file
      CSV.read(file_path, headers: true).each_with_index do |row, row_num|
        yield(convert_entry(row))
      end
    end

    def convert_entry(row)
      CONVERTION.map do |attr_name, key_name|
        [attr_name, row[key_name]]
      end.to_h
    end

    def file_path
      @file_path ||= source_dir.join("#{file_name}.csv").to_s
    end

    def source_dir
      @source_dir ||= Rails.root.join('data/source')
    end
  end
end
