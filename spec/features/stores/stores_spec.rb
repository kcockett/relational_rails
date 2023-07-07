require "rails_helper"
describe "The stores pages" do
  before :each do
    @store1 = Store.create!(store_name: "Moab Tour Company", address1: "427 N. Main Street", address2: " ", city: "Moab", state: "UT", zip_code: "84532", currently_hiring: false, manager_name: "Brandon Daley", created_at: Time.now, updated_at: Time.now) 
    @store2 = Store.create!(store_name: "Estes Park ATV Rentals", address1: "222 East Elkhorn Ave", address2: " ", city: "Estes Park", state: "CO", zip_code: "80517", currently_hiring: true, manager_name: "Andy Hitch", created_at: Time.now, updated_at: Time.now)
  end
  describe "As a visitor" do
    describe "When I visit '/stores'" do
      it "I see the name of each parent record in the system" do
        visit "/stores"
        expect(page).to have_content(@store1.store_name)
        expect(page).to have_content(@store2.store_name)
      end
    end
    describe "When I visit '/stores/:id" do
      it "US2 - Then I see the parent with that id including the parent's attributes" do
        visit "/stores/#{@store1.id}"
        expect(page).to have_content(@store1.store_name)
        expect(page).to have_content(@store1.address1)
        expect(page).to have_content(@store1.address2)
        expect(page).to have_content(@store1.city)
        expect(page).to have_content(@store1.state)
        expect(page).to have_content(@store1.zip_code)
        expect(page).to have_content(@store1.manager_name)
        save_and_open_page
      end
    end
  end
end