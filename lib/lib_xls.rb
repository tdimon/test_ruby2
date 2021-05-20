require 'spreadsheet'

class LibXls
  def initialize name_file
    @workbook = Spreadsheet.open name_file
  end

  def getListCompanies
    listCompanies = Array.new
    worksheets = @workbook.worksheets
    worksheets.each do |worksheet|
      worksheet.rows.each do |row|
        row_cells = row.to_a.map{ |v| v.methods.include?(:value) ? v.value : v }
        nameCompany = row_cells[0]
        if !nameCompany.empty?
          listCompanies << nameCompany
        end
      end
    end
    return listCompanies
  end
end