require 'csv'
require 'date'

CSV.generate do |csv|
  csv_column_names = ["出社時間""退社時間"]
  csv << csv_column_names
    @dates.each do |date|
     if date.started_at.present? && date.finished_at.present?
      csv_column_values = [
        date.started_at.strftime("%R"),
        date.finished_at.strftime("%R")
       ]
      csv << csv_column_values
      end
     end
end