require 'rails_helper'

RSpec.describe "Cancel Subscription API" do
  describe "Cancel Subscription" do
    before(:each) do
      @cust_1 = Customer.create!(first_name: "Angel", last_name: "Byun", email: "angel123@email.com", address: "123 Littleton Way, Littleton, CO 80123")
      @cust_2 = Customer.create!(first_name: "Scott", last_name: "Le", email: "scottlovestea@email.com", address: "987 Main St, Aurora, CO, 80016")

      @tea_1 = Tea.create!(title: "Black", description: "Caffeinated, great hot, substitute for coffee, great with creamer of choice", temperature: "Hot", brew_time: "8-10 minutes")
      @tea_2 = Tea.create!(title: "Green", description: "Caffeinated, great hot, substitute for coffee, great as is or with honey", temperature: "Hot", brew_time: "8-10 minutes")
      @tea_3 = Tea.create!(title: "Hibiscus", description: "Uncaffeinated, best served cold, great tea when added with a splash of fruit juice", temperature: "Cold", brew_time: "4-6 minutes")
      @tea_4 = Tea.create!(title: "Butterfly Pea", description: "Uncaffeinated, best served cold, great for your immune system, watch it change color to purple when lemonade is added", temperature: "Cold", brew_time: "6-8 minutes")
      @tea_5 = Tea.create!(title: "Chamomile", description: "Uncaffeinated, great hot, great when stressed or unable to sleep with some honey and lemon", temperature: "Hot", brew_time: "8-9 minutes")
    end

    it "cancels a subscription" do
      subscription = Subscription.create!(title: "Hibiscus", price: "12.00", status: "Active", frequency: "Monthly", customer_id: @cust_1.id, tea_id: @tea_3.id)

      patch '/api/v0/unsubscribe', params: { id: subscription.id }

      expect(response).to be_successful
      expect(response.status). to eq(200)

      message = JSON.parse(response.body, symbolize_names: true)

      expect(message).to be_a(Hash)
      expect(message).to have_key(:message)
      expect(message[:message]).to eq("Your subscription is now canceled")
    end
  end
end