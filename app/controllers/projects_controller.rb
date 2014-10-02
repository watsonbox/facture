class ProjectsController < ApplicationController
  respond_to :json

  def index
    respond_with Project.all_with_unpaid_invoices
  end

  def show
    respond_with Project.find(params[:id])
  end
end
