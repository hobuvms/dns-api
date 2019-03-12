require 'csv'
class UserLeadsController < ApplicationController
  before_action :set_user_lead, only: [:show, :update, :destroy]
  include ActionController::MimeResponds

  skip_before_action :authenticate_request, only: [:create]

  def index
    @user_leads = current_vendor.user_leads.includes(:user).as_json(only: %i[id medium notes name phone created_at updated_at],
                                                                    include: {user: {only: %i[id email] , include: {user_address: {only: [:id, :formatted_address]}}}})
                                                           .sort_by{|x| x[:name]}.reverse

    render json: @user_leads
  end

  def report
    d = Vendor.joins(:user_leads=>:orders)
              .joins('inner join users customer on customer.id = user_leads.user_id inner join user_addresses on customer.id = user_addresses.user_id').where('users.id = ?', current_vendor.id)
              .select("users.company_name Company_Name, user_leads.medium MEDIUM, orders.price PRICE, user_leads.created_at as FIRST_CONTACT_DATE, orders.updated_at LAST_UPDATED, user_leads.name CUSTOMER_NAME, orders.status, formatted_address, 1 as UNIT, city, postal_code, user_leads.phone PHONE_NUMBER, (product_id/1000) Internet, (product_id/100)%10 TV, (product_id/10)%10 HomePhone, (product_id%10) SHM, users.name, account_number, working_order, installation, orders.id order_iid, orders.installation_time, CASE WHEN status = \'installed\' THEN \'YES\' ELSE \'NO\' END AS Activated, users.name as rep_name, orders.details, DATE(expiry_date) expiry_date, orders.company_name order_company_name, users.referral_code referral_code, 0 rep_paid")
              .order('orders.updated_at desc')

    if params[:from_date].present?
      d = d.where('orders.updated_at > ?', Time.parse(params[:from_date]).beginning_of_day )
    end

    if params[:to_date].present?
      d = d.where('orders.updated_at < ?', Time.parse(params[:to_date]).end_of_day )
    end

    respond_to do |format|
      format.csv { send_data User.to_csv(d.uniq{|x| x.order_iid}), filename: "users-#{Date.today}.csv" }
    end

  end

  def create
    if user_lead_params[:referral_code].present?
      vendor = Vendor.where(Vendor.arel_table[:referral_code].matches(user_lead_params[:referral_code])).first
      return render_json({ message: 'Referral Code Invalid.' }, false, :unprocessable_entity) if vendor.blank?
    else
      vendor = Vendor.find_by(referral_code: :hobuadmin)
    end
    return generate_lead(user_lead_params, vendor, true)
  end

  def add_lead
    return generate_lead(user_lead_params, nil, false)
  end

  # PATCH/PUT /user_leads/1
  def update
    if @user_lead.update(user_lead_update_params)
      render_json(@user_lead.as_object)
    else
      render json: @user_lead.errors, status: :unprocessable_entity
    end
  end

  private

  def generate_lead(user_lead_params, vendor = nil, mailer = false)
    vendor ||= current_vendor
    user = get_user(user_lead_params)
    user_lead = UserLead.find_or_initialize_by(vendor_id: vendor.id, user_id: user.id)
    user_lead.medium = user_lead_params[:medium] if user_lead.new_record?
    user_lead.phone = user_lead_params[:phone]
    user_lead.name = user_lead_params[:name]
    user_lead.notes = user_lead_params[:notes]

    if user_lead.save
      if mailer != false
        OrderMailer.customer_send_email(name: user_lead.name, phone: user_lead.phone, address: user.user_address&.formatted_address,
                                        customer_email: user.email, notes: user_lead.notes.to_s).deliver_later!
        OrderMailer.vendor_send_email(name: user_lead.name, phone: user_lead.phone, address: user.user_address&.formatted_address,
                                      customer_email: user.email, vendor_email: vendor.email, notes: user_lead.notes.to_s).deliver_later!
      end
      render_json({ message: 'lead added', data: user_lead.as_object }, true, :created)
    else
      render_json({ error: user_lead.errors.full_messages }, false, :unprocessable_entity)
    end
  end

  def get_user(params)
    user = User.find_or_initialize_by(email: params[:email])
    if user.new_record?
      user.role = :user
      user.password = "XYZ"
      user.user_address_attributes = params[:user_address_attributes] if params[:user_address_attributes]
    else
      user.build_user_address if user.user_address.nil?
      user.user_address.update(params[:user_address_attributes])
    end

    user.save!
    user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user_lead
    @user_lead = UserLead.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_lead_params
    params.require(:user_lead).permit(:referral_code, :name, :medium, :email, :phone, :name, :notes,
                                      user_address_attributes: [%w[country_name postal_code latitude longitude city
                                                                   formatted_address region_name]])
  end

  def user_lead_update_params
    params.require(:user_lead).permit(:name, :phone, :notes, user_address_attributes: [%w[country_name postal_code latitude longitude city
                                                                   formatted_address region_name]])
  end
end
