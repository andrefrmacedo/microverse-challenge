# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = filtered_users.page params[:page]

    respond_to do |format|
      format.json { render json: @users }
      format.html
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.json { render json: @user }
      format.html
    end
  end

  private

  def filtered_users
    params[:status] ? User.filter_by_status(params[:status]).order(:id) : User.order(:id)
  end
end
