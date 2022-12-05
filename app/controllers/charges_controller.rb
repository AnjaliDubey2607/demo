class ChargesController < ApplicationController
    include ApplicationHelper
    before_action :cart
    def new
    end
          
    def create
        if params[:stripeEmail]==current_user.email   
        # Amount in cents
            Stripe.api_key = "sk_test_51M6rQqSEPNqv3a1zy89NXWTEsgfhDcbbZlcjeer5Fh2BJuugMWTtmjR2nMcJjo0rph93z7TfJvhYx6VZAtfDDh4G0008BlvejH"
            customer=""
            Stripe::Customer.list.data.each do |c|
                if c.email==params[:stripeEmail]
                    customer=c.id
                    break
                end
            end
            
            unless customer.present?
                customer = Stripe::Customer.create(
                :email => params[:stripeEmail],
                :source => params[:stripeToken]
                )
                customer=customer.id
            end
            
            payment_intent = Stripe::PaymentIntent.create(
                :customer => customer,
                :amount => cart.total_price.to_i.to_s+"00",
                :description => 'Rails Stripe transaction',
                :currency => 'inr'
            )
            # debugger
            Stripe::PaymentIntent.update(
                payment_intent.id,
                {metadata: {order_id: '6735'}},
            )
        
            Stripe::PaymentIntent.confirm(
                payment_intent.id,
                {payment_method: 'pm_card_visa'},
            )
            #redirect_to controller: 'customer/deshboard', action: 'payment_type', id: @cart.id, pay: 'cart'
            redirect_to customer_payment_type_path(@cart.id) 
        else
            flash[:error] = "email id you provided is not matched with your account email"
            redirect_to new_charge_path
        end
  
    rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to root_path            
    end
    private

    def cart
        @cart= Cart.current_user_cart(current_user.id)
    end

        
end
