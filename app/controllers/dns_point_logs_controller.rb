# frozen_string_literal: true

class DnsPointLogsController < ApplicationController
  before_action :set_dns_point_log, only: %i[show update destroy]

  # GET /dns_point_logs
  def index
    @dns_point_logs = DnsPointLog.all

    render json: @dns_point_logs
  end

  # GET /dns_point_logs/1
  def show
    render json: @dns_point_log
  end

  # POST /dns_point_logs
  def create
    @dns_point_log = DnsPointLog.new(dns_point_log_params)

    if @dns_point_log.save
      render json: @dns_point_log, status: :created, location: @dns_point_log
    else
      render json: @dns_point_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dns_point_logs/1
  def update
    if @dns_point_log.update(dns_point_log_params)
      render json: @dns_point_log
    else
      render json: @dns_point_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dns_point_logs/1
  def destroy
    @dns_point_log.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dns_point_log
    @dns_point_log = DnsPointLog.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dns_point_log_params
    params.require(:dns_point_log).permit(:user_id, :data)
  end
end
