class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy]
  before_action :validate_permission, only: [:select_movement, :select_dashboard, :select_paid_or_bill]

  def index
    @accounts = Account.filter(params)
    render json: @accounts
  end

  def all_parents
    @accounts = Account.all_parents(params[:user_id])
    render json: @accounts
  end

  def show
    render json: @account
  end

  def create
    parent = Account.find(params[:parent_id])
    if parent.present?
      parent.children.create(name: params[:name], user_id: params[:user_id]) 
      render json: @account, status: :created, location: @account
    else
      render json: 'parent_id is required'
    end
  end

  def update
    parent = Account.find(params[:parent_id])
    @account.update_attribute :parent, parent if parent.present?
    if @account.update(account_params)
      render json: @account
    else
      render json: 'parent_id is required'
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  private
    def set_account
      @account = Account.find(params[:id])
    end

    def validate_permission       
      return [] unless Permission.where(user_id: params[:user_id]).present?
    end

    def account_params
      params.require(:account).permit(:name, :type_account, :code, :ancestry, :user_id)
    end
end
