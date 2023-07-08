require "rails_helper"
describe "The stores pages" do
  before :each do
    @store1 = Store.create!(store_name: "Moab Tour Company", address1: "427 N. Main Street", address2: " ", city: "Moab", state: "UT", zip_code: "84532", currently_hiring: false, manager_name: "Brandon Daley", created_at: "2003-03-15 08:20:00+00", updated_at: Time.now) 
    @store2 = Store.create!(store_name: "Estes Park ATV Rentals", address1: "222 East Elkhorn Ave", address2: " ", city: "Estes Park", state: "CO", zip_code: "80517", currently_hiring: true, manager_name: "Andy Hitch", created_at: "2001-09-25 18:20:00+00", updated_at: Time.now)
    @vehicle1 = Vehicle.create!(model_year: 2019, make: "Yamaha", model: "WR250F", mileage: 0, repairs_needed: false, store_id: @store1.id, seating: 1, last_service_date: "2023-02-21 12:30:00+00", engine_hours: 150)
    @vehicle2 = Vehicle.create!(model_year: 2022, make: "CFMoto", model: "CForce 600 Touring", mileage: 425, repairs_needed: true, store_id: @store1.id, seating: 2, last_service_date: "2003-02-10 18:20:00+00", engine_hours: 0)
    @vehicle3 = Vehicle.create!(model_year: 2016, make: "Polaris", model: "Ace 900 SE", mileage: 525, repairs_needed: true, store_id: @store2.id, seating: 1, last_service_date: "2023-05-25 12:00:00+00", engine_hours: 0)
  end
  describe "As a visitor" do
    describe "When I visit '/stores'" do
      it "I see the name of each parent record in the system" do
        visit "/stores"
        expect(page).to have_content(@store1.store_name)
        expect(page).to have_content(@store2.store_name)
      end

      it "US6 - I see that records are ordered by most recently created first
      And next to each of the records I see when it was created" do
        visit "/stores"

        expect(page).to have_content(@store1.created_at)
        expect(page).to have_content(@store2.created_at)
        expect(page.text.index(@store2.store_name)).to be > page.text.index(@store1.store_name)
      end
      it "US8 - I see a link at the top of the page that takes me to the vehicles index" do
        visit "/stores" 

        expect(page).to have_link("All Vehicles", :href=>"/vehicles")
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
      end
      it "US7 - I see a count of the number of children associated with this parent" do
        visit "/stores/#{@store1.id}"
        expect(page).to have_content("Vehicles in store: #{Vehicle.where(store_id: @store1.id).count}")
        
        visit "/stores/#{@store2.id}"
        expect(page).to have_content("Vehicles in store: #{Vehicle.where(store_id: @store2.id).count}")
      end
      it "US8 - I see a link at the top of the page that takes me to the vehicles index" do
        visit "/stores/#{@store1.id}"
        
        expect(page).to have_link("All Vehicles", :href=>"/vehicles")
        save_and_open_page
      end
    end
    
    describe "When I visit '/stores/:id/vehicles" do
      it "Then I see each vehicle that is associated with that store with each vehicle's attributes" do
        visit "/stores/#{@store1.id}/vehicles"
        
        expect(page).to have_content(@vehicle1.model_year)
        expect(page).to have_content(@vehicle2.model_year)
        expect(page).to have_content(@vehicle1.make)
        expect(page).to have_content(@vehicle1.model)
        expect(page).to have_content(@vehicle2.model)
        expect(page).to have_content(@vehicle1.mileage)
        expect(page).to have_content(@vehicle2.mileage)
        
        expect(page).to_not have_content(@vehicle3.model_year)
        expect(page).to_not have_content(@vehicle3.make)
        expect(page).to_not have_content(@vehicle3.model)
        expect(page).to_not have_content(@vehicle3.mileage)
        
      end
      it "US8 - I see a link at the top of the page that takes me to the vehicles index" do
        visit "/stores/#{@store1.id}/vehicles"
  
        expect(page).to have_link("All Vehicles", :href=>"/vehicles")
      end
    end
  end
end