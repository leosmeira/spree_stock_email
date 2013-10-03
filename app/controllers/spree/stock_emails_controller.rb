# encoding: utf-8
class Spree::StockEmailsController < ApplicationController

  def create
    product = Spree::Product.find_by_id(params[:stock_email][:product])
    redirect_to :back and return unless product

    stock_email = Spree::StockEmail.new
    stock_email.email = current_user ? current_user.email : params[:stock_email][:email]
    stock_email.product = product

    begin
      stock_email.save! unless stock_email.email_exists?
      flash[:success] = "Você receberá um email quando '#{product.name}' voltar ao estoque!"
    rescue => e
      flash[:notice] = "Ocorreu um erro ao tentar enviar o email. Por favor tente novamente."
    end

    redirect_to :back
  end

end
