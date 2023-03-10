require 'roo'

class UserImportService
  attr_reader  :file_path, :import_id

  def initialize(file_path, import_id)
    @file_path = file_path
    @import_id = import_id
  end

  def run
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = build_user(row)
      user.save!
    end

    find_import.update(status: :completed, total_rows: spreadsheet.last_row)
  rescue StandardError => e
    find_import.update(status: :failed, error_messages: e.message)
  end

  private

  def open_spreadsheet
    case File.extname(file_path)
    when '.xls' then Roo::Excel.new(file_path)
    when '.xlsx' then Roo::Excelx.new(file_path)
    else raise "Tipo de arquivo não suportado: #{import_id}"
    end
  end

  def build_user(row)
    User.new(
      full_name: row['nome'],
      email: row['email'],
      role: row['funcao'],
      password: row['senha']
    )
  end

  def find_import
    @find_import ||= Import.find(import_id)
  end
end
