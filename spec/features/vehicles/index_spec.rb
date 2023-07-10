require "rails_helper"

describe "The vehicles pages" do
  before :each do
    @store1 = Store.create!(store_name: "Moab Tour Company", address1: "427 N. Main Street", address2: " ", city: "Moab", state: "UT", zip_code: "84532", currently_hiring: false, manager_name: "Brandon Daley", created_at: "2003-03-15 08:20:00+00", updated_at: Time.now) 
    @store2 = Store.create!(store_name: "Estes Park ATV Rentals", address1: "222 East Elkhorn Ave", address2: " ", city: "Estes Park", state: "CO", zip_code: "80517", currently_hiring: true, manager_name: "Andy Hitch", created_at: "2008-09-25 18:20:00+00", updated_at: Time.now)
    @vehicle1 = Vehicle.create!(model_year: 2019, make: "Yamaha", model: "WR250F", mileage: 0, repairs_needed: false, store_id: @store1.id, seating: 1, last_service_date: "2023-02-21 12:30:00+00", engine_hours: 150)
    @vehicle2 = Vehicle.create!(model_year: 2022, make: "CFMoto", model: "CForce 600 Touring", mileage: 425, repairs_needed: true, store_id: @store1.id, seating: 2, last_service_date: "2003-02-10 18:20:00+00", engine_hours: 0)
    @vehicle3 = Vehicle.create!(model_year: 2016, make: "Polaris", model: "Ace 900 SE", mileage: 525, repairs_needed: true, store_id: @store2.id, seating: 1, last_service_date: "2023-05-25 12:00:00+00", engine_hours: 0)
  end
  describe "As a visitor, when I visit '/vehicles'" do
    it "US3 - I see each vehicle in the system including the vehicle attributes" do
    
      #   User Story 3 overwritten by User Story 15
      #   visit "/vehicles"

      #   expect(page).to have_content(@vehicle1.model_year)
      #   expect(page).to have_content(@vehicle2.model_year)
      #   expect(page).to have_content(@vehicle1.make)
      #   expect(page).to have_content(@vehicle1.model)
      #   expect(page).to have_content(@vehicle3.model)
      #   expect(page).to have_content(@vehicle1.mileage)
      #   expect(page).to have_content(@vehicle1.store_id)
      #   expect(page).to have_content(@vehicle1.seating)
      #   expect(page).to have_content(@vehicle1.last_service_date)
      #   expect(page).to have_content(@vehicle1.engine_hours)
    end
    it "US8 - I see a link at the top of the page that takes me to the vehicles index" do
      visit "/vehicles"

      expect(page).to have_link("All Vehicles", :href=>"/vehicles")
    end
    it "US9 - I see a link at the top of the page that takes me to the stores Index" do
      visit "/vehicles"
      
      expect(page).to have_link("All Stores", :href=>"/stores")
    end
    it "US15 - Then I only see records where the boolean column is `true`" do
      visit "/vehicles"
      expect(page).to_not have_content("WR250F")
      expect(page).to have_content("Ace 900 SE")
      expect(page).to have_content("CForce 600 Touring")
    end
    it "US18 - Next to every vehicle, I see a link to edit that vehicle's info" do
      visit "/vehicles"

      all('h3').each do |h3|
        within(h3) do
          expect(page).to have_link('edit')
        end
      end
    end
    it "US18 - When I click the link I should be taken to that `vehicles` edit page where I can update its information" do
      visit "/vehicles"
      first('a', text: 'edit').click

      expect(current_path).to eq("/vehicles/#{@vehicle2.id}/edit")
    end
    it "US23 - Next to every vehicle, I see a link to delete that vehicle" do
      visit "/vehicles"
      all('h3').each do |h3|
        within(h3) do
          expect(page).to have_link('delete')
        end
      end
    end
    it "US23 - When I click the link I should be taken to the `vehicles` index page where I no longer see that vehicle" do
      visit "/vehicles"
      first('a', text: 'delete').click

      expect(current_path).to eq("/vehicles")
      expect(page).to_not have_content("#{@vehicle2.make}")
      expect(page).to have_content("#{@vehicle3.make}")
    end
  end
end