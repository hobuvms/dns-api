class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /orders
  def index
    orders = current_vendor.orders.includes(:user_lead).as_json(only: %i[product_id account_number working_order 
                                                                         created_at id company_name price installation
                                                                         expiry_date details],
                                                                include: {user_lead: {only: %i[id]}})
    render_json(orders)
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    user = current_vendor.user_leads.where(id: order_params[:user_lead_id]).first
    return render_json({ message: 'User not part of Vendor' }, false, 422) if user.blank?

    @order = Order.new(order_params.merge(vendor_id: current_vendor.id))
    if @order.save
      render_json(@order.as_object, true, :created)
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_update_params)
      render_json(@order.as_object)
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  def customer_orders
    puts current_vendor.user_leads.inspect
    user_lead = current_vendor.user_leads.where(user_id: params[:id]).first
    return render_json("Not Auth", false, 422) unless user_lead.present?
    order = current_vendor.orders.where(user_lead_id: user_lead.id)
    render_json(order)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find_by!(id: params[:id], vendor_id: current_vendor.id)
    # raise "NoOrde" unless @order
  end

  # Only allow a trusted parameter "white list" through.
  def order_params
    params.require(:order).permit(:user_lead_id, :product_id, :account_number, :working_order, :company_name, :price, :installation, :expiry_date, :details)
  end

  def order_update_params
    params.require(:order).permit(:account_number, :working_order, :company_name, :price, :installation, :expiry_date, :details)
  end
end
