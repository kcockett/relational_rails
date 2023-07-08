require "rails_helper"
describe "The vehicles pages" do
  before :each do
    @store1 = Store.create!(store_name: "Moab Tour Company", address1: "427 N. Main Street", address2: " ", city: "Moab", state: "UT", zip_code: "84532", currently_hiring: false, manager_name: "Brandon Daley", created_at: "2003-03-15 08:20:00+00", updated_at: Time.now) 
    @store2 = Store.create!(store_name: "Estes Park ATV Rentals", address1: "222 East Elkhorn Ave", address2: " ", city: "Estes Park", state: "CO", zip_code: "80517", currently_hiring: true, manager_name: "Andy Hitch", created_at: "2008-09-25 18:20:00+00", updated_at: Time.now)
    @vehicle1 = Vehicle.create!(model_year: 2019, make: "Yamaha", model: "WR250F", mileage: 0, repairs_needed: false, store_id: @store1.id, seating: 1, last_service_date: "2023-02-21 12:30:00+00", engine_hours: 150)
    @vehicle2 = Vehicle.create!(model_year: 2022, make: "CFMoto", model: "CForce 600 Touring", mileage: 425, repairs_needed: true, store_id: @store1.id, seating: 2, last_service_date: "2003-02-10 18:20:00+00", engine_hours: 0)
    @vehicle3 = Vehicle.create!(model_year: 2016, make: "Polaris", model: "Ace 900 SE", mileage: 525, repairs_needed: true, store_id: @store2.id, seating: 1, last_service_date: "2023-05-25 12:00:00+00", engine_hours: 0)
  end

  describe "As a visitor" do
    describe "US3 - When I visit '/vehicles'" do
      it "I see each vehicle in the system including the vehicle attributes" do
        visit "/vehicles"

        expect(page).to have_content(@vehicle1.model_year)
        expect(page).to have_content(@vehicle2.model_year)
        expect(page).to have_content(@vehicle1.make)
        expect(page).to have_content(@vehicle1.model)
        expect(page).to have_content(@vehicle3.model)
        expect(page).to have_content(@vehicle1.mileage)
        expect(page).to have_content(@vehicle1.store_id)
        expect(page).to have_content(@vehicle1.seating)
        expect(page).to have_content(@vehicle1.last_service_date)
        expect(page).to have_content(@vehicle1.engine_hours)
      end
      it "US8 - I see a link at the top of the page that takes me to the vehicles index" do
        visit "/vehicles"

        page.should have_link("All Vehicles", :href=>"/vehicles")
      end
    end

    describe "US4 - When I visit '/child_table_name/:id'" do
      it "Then I see the child with that id including the child's attributes" do
        visit "/vehicles/#{@vehicle1.id}"

        expect(page).to have_content(@vehicle1.model_year)
        expect(page).to have_content(@vehicle1.make)
        expect(page).to have_content(@vehicle1.model)
        expect(page).to have_content(@vehicle1.mileage)
        expect(page).to have_content(@vehicle1.store_id)
        expect(page).to have_content(@vehicle1.seating)
        expect(page).to have_content(@vehicle1.last_service_date)
        expect(page).to have_content(@vehicle1.engine_hours)
        #save_and_open_page
      end
      it "US8 - I see a link at the top of the page that takes me to the vehicles index" do
        visit "/vehicles/#{@vehicle1.id}"

        page.should have_link("All Vehicles", :href=>"/vehicles")
      end
    end
  end
end