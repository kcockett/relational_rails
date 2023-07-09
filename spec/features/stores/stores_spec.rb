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
      it "US6 - I see that records are ordered by most recently created first and next to each of the records I see when it was created" do
        visit "/stores"

        expect(page).to have_content(@store1.created_at)
        expect(page).to have_content(@store2.created_at)
        expect(page.text.index(@store2.store_name)).to be > page.text.index(@store1.store_name)
      end
      it "US8 - I see a link at the top of the page that takes me to the vehicles index" do
        visit "/stores" 

        expect(page).to have_link("All Vehicles", :href=>"/vehicles")
      end
      it "US9 - I see a link at the top of the page that takes me to the stores Index" do
        visit "/stores" 
        
        expect(page).to have_link("All Stores", :href=>"/stores")
      end
      it "US11 - I see a link to create a new store record, 'New Store" do
        visit "/stores"
        
        expect(page).to have_link("New Store", :href=>"/stores/new")
      end
      it "US11 - When I click this link, I am taken to '/store/new' where I see a form for a new store record" do
        visit "/stores"
        click_link('New Store')
        expect(current_path).to eq('/stores/new')
        expect(page).to have_css('#newstoreform')
      end
      it "US11 - When I fill out the form with a new store's attributes: And I click the button 'Create store' to submit the form, then a `POST` request is sent to the '/stores' route, a new store record is created, and I am redirected to the store Index page where I see the new store displayed." do
        visit "/stores/new"
        within('#newstoreform') do
          fill_in "store[store_name]", with: "New Store"
          fill_in "store[address1]", with: "123 Any Street"
          fill_in "store[address2]", with: "Suite 110"
          fill_in "store[city]", with: "Anytown"
          fill_in "store[state]", with: "CO"
          fill_in "store[zip_code]", with: "80000"
          page.choose('true')
          fill_in "store[manager_name]", with: "Joe Smith"
        end
        click_button("Submit")
        
        expect(current_path).to eq("/stores/")
      end
      
    end
    describe "When I visit '/stores/:id" do
      it "US2 - Then I see the store with that id including the store's attributes" do
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
      end
      it "US9 - I see a link at the top of the page that takes me to the stores Index" do
        visit "/stores/#{@store1.id}"
        
        expect(page).to have_link("All Stores", :href=>"/stores")
      end
      it "US10 - I see a link to take me to that stores's vehicles page" do
        visit "/stores/#{@store1.id}"
        
        expect(page).to have_link("Vehicles at this store", :href=>"/stores/#{@store1.id}/vehicles")
      end
      it "US12 - I see a link to update the store 'Update Store'" do
        visit "/stores/#{@store1.id}"
        
        expect(page).to have_link("Update Store", :href=>"/stores/#{@store1.id}/edit")
      end
      it "US12 - When I click the link 'Update Store' then I am taken to '/stores/:id/edit' where I see a form to edit the stores's attributes" do
        visit "/stores/#{@store1.id}"
        click_link('Update Store')

        expect(current_path).to eq("/stores/#{@store1.id}/edit")
        expect(page).to have_css('#updatestoreform')
      end
      it "US12 - When I fill out the form with updated information and I click the button to submit the form then a `PATCH` request is sent to '/stores/:id', the store's info is updated, and I am redirected to the store's Show page where I see the store's updated info" do
        visit "/stores/#{@store1.id}/edit"
        within('#updatestoreform') do
          fill_in "store[store_name]", with: "Moab Touring Co"
          fill_in "store[address1]", with: "123 Any Street"
          fill_in "store[address2]", with: "Suite 110"
          fill_in "store[city]", with: "Anytown"
          fill_in "store[state]", with: "CO"
          fill_in "store[zip_code]", with: "80000"
          page.choose('true')
          fill_in "store[manager_name]", with: "Joe Smith"
        end
        click_button("Submit")
        
        expect(current_path).to eq("/stores/#{@store1.id}")
        expect(page).to have_content("Moab Touring Co")
        expect(page).to have_content("123 Any Street")
        expect(page).to have_content("Suite 110")
        expect(page).to have_content("Anytown")
        expect(page).to have_content("80000")
        expect(page).to have_content("Joe Smith")
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
      it "US9 - I see a link at the top of the page that takes me to the stores Index" do
        visit "/stores/#{@store1.id}/vehicles"
        
        expect(page).to have_link("All Stores", :href=>"/stores")
      end
      it "US13 - Then I see a link to add a new vehicle for that store 'Create Vehicle'" do
        visit "/stores/#{@store1.id}/vehicles"
        
        expect(page).to have_link("Create Vehicle", :href=>"/stores/#{@store1.id}/vehicles/new")
      end
      it "US13 - When I click the 'Create Vehicle' link I am taken to '/stores/:store_id/vehicles/new' where I see a form to add a new adoptable vehicle" do
        visit "/stores/#{@store1.id}/vehicles"
        click_link('Create Vehicle')
        
        expect(current_path).to eq("/stores/#{@store1.id}/vehicles/new")
        expect(page).to have_css('#newvehicleform')
      end
      it "US13 - When I fill in the form with the vehicle's attributes and I click the button 'Create Vehicle' then a `POST` request is sent to '/stores/:store_id/vehicles', a new vehicle object/row is created for that store, and I am redirected to the store vehicles Index page where I can see the new vehicle listed" do
        visit "/stores/#{@store1.id}/vehicles/new"
        
        within('#newvehicleform') do
          fill_in "vehicle[model_year]", with: "2024"
          fill_in "vehicle[make]", with: "CFMoto"
          fill_in "vehicle[model]", with: "CForce 1000"
          fill_in "vehicle[mileage]", with: "5"
          fill_in "vehicle[seating]", with: "2"
          fill_in "vehicle[last_service_date]", with: "#{Time.now}"
          fill_in "vehicle[engine_hours]", with: "1"
        end
        click_button("Submit")
        
        expect(current_path).to eq("/stores/#{@store1.id}/vehicles")
        expect(page).to have_content("2024")
        expect(page).to have_content("CForce 1000")
      end
      it "US16 - Then I see a link to sort children in alphabetical order" do
        visit "/stores/#{@store1.id}/vehicles"
        
        expect(page).to have_link("Sort Vehicles")
        save_and_open_page
        expect(page.text.index(@vehicle1.make)).to be < page.text.index(@vehicle2.make)
        expect(page.text.index(@vehicle2.make)).to be < page.text.index(@vehicle3.make)
      end
      it "US16 - When I click on the link I'm taken back to the store's vehicle Index Page where I see all of the store's vehicles in alphabetical order" do
        visit "/stores/#{@store1.id}/vehicles"
        click_link('Sort Vehicles')
        
        expect(page.text.index(@vehicle2.make)).to be < page.text.index(@vehicle3.make)
        expect(page.text.index(@vehicle3.make)).to be < page.text.index(@vehicle1.make)
      end
    end
  end
end
#save_and_open_page