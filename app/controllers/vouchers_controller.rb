class VouchersController < ApplicationController
  before_action :authenticate_user!

  def index
    @vouchers = current_user.vouchers
  end

  def new
    @voucher = Voucher.new
  end

  def create
    @voucher = current_user.vouchers.new(voucher_params)
    if  @voucher.save
      redirect_to vouchers_path, notice: "已成功兌換，您的兌換券序號為"
    else
      render :new
    end 
  end

  private
  def voucher_params
    params.require(:voucher).permit(:name, :tax_id, :tel, :user_id)
  end
end
