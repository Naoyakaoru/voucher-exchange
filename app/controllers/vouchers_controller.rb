class VouchersController < ApplicationController
  def new
    @voucher = Voucher.new
  end

  def create
    @voucher = Voucher.new(voucher_params)
    if  @voucher.save
    else
     render :new
    end 
  end

  private
  def voucher_params
    params.require(:voucher).permit(:name, :tax_id, :tel)
  end
end
