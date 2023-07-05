require "rails_helper"
RSpec.describe "The stores pages" do
  it "US1: See the name of each parent record in the system" do
    store = Store.create!(store_name: "Moab Tour Company", address1: "427 N. Main Street", address2: null, city: "Moab", state: "UT", zip_code: "84532", currently_hiring: false, manager_name: "Brandon Daley", created_at: Time.now, updated_at: Time.now) 
    visit "/stores/"
  end
end