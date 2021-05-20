class AddRecordSetting < ActiveRecord::Migration[5.2]
  def change
    ApiSetting.create(account: "task2", token: "2c32219cd781be3ebe82aafbdab2e71639feff44")
  end
end
