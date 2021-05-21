require 'rails_helper'

RSpec.describe Company, type: :model do
  it "should be valid" do
    result = Company.createCompaniesFromFile?('123.xls')
    expect(result).to be true
  end

end
