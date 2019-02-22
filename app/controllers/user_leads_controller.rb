class UserLeadsController < ApplicationController
  # before_action :set_user_lead, only: [:show, :update, :destroy]
  skip_before_action :authenticate_request, only: [:create]

  # GET /user_leads
  def index
    @user_leads = current_vendor.user_leads.as_json(only: :medium,
                                                    include: { user: { only: %i[name email phone company_name
                                                                                notes medium] } })

    render json: @user_leads
  end

  # GET /user_leads/1
  def show
    render json: @user_lead
  end

  # POST /user_leads
  def create
    if user_lead_params[:referral_code].present?
      vendor = Vendor.find_by(referral_code: user_lead_params[:referral_code])
      return render_json({ message: 'Referral Code Invalid.' }, false, :unprocessable_entity) if vendor.blank?
    else
      vendor = Vendor.find_by(referral_code: :hobuadmin)
    end

    user = get_user(user_lead_params)
    @user_lead = UserLead.find_or_initialize_by(vendor_id: vendor.id, user_id: user.id)
    @user_lead.medium = user_lead_params[:medium] if @user_lead.new_record?
    
    if @user_lead.save
      render json: @user_lead, status: :created
    else
      render_json({ error: @user_lead.errors.full_messages }, false, :unprocessable_entity)
    end
  end

  # PATCH/PUT /user_leads/1
  def update
    if @user_lead.update(user_lead_params)
      render json: @user_lead
    else
      render json: @user_lead.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_leads/1
  def destroy
    @user_lead.destroy
  end

  private

  def get_user(params)
    user = User.find_or_initialize_by(email: params[:email])
    return user unless user.new_record?

    user.role = :user
    user.name = params[:name]
    user.medium = params[:medium]
    user.password = "XYZ"
    user.save
    user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user_lead
    @user_lead = UserLead.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_lead_params
    params.require(:user_lead).permit(:referral_code, :name, :medium, :email)
  end
end
