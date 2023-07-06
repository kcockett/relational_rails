require "rails_helper"
describe "The stores pages" do
  # US1:  As a visitor
  # When I visit '/parents'
  # Then I see the name of each parent record in the system
  describe "As a visitor" do
    describe "US1 - When I visit '/parents'" do
      it "I see the name of each parent record in the system" do
        store1 = Store.create!(store_name: "Moab Tour Company", address1: "427 N. Main Street", address2: " ", city: "Moab", state: "UT", zip_code: "84532", currently_hiring: false, manager_name: "Brandon Daley", created_at: Time.now, updated_at: Time.now) 
        store2 = Store.create!(store_name: "Estes Park ATV Rentals", address1: "222 East Elkhorn Ave", address2: " ", city: "Estes Park", state: "CO", zip_code: "80517", currently_hiring: true, manager_name: "Andy Hitch", created_at: Time.now, updated_at: Time.now)
        
        visit "/stores"
        expect(page).to have_content(store1.store_name)
        expect(page).to have_content(store2.store_name)
      end
    end
  end
end