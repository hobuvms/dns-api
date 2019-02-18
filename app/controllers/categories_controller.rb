# frozen_string_literal: true

class CategoriesController < ApplicationController
  skip_before_action :authenticate_request

  # GET /categories
  def index
    if params[:parent_id].present?
      categories = Category.child_category(params[:parent_id])
    else
      categories ||= Category.top
    end
    render_json(categories.as_json(only: %i[name url parent_id]))
  end

  def details
    categories = Category.details
    render_json(categories)
  end
end
