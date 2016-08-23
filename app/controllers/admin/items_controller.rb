class Admin::ItemsController < ApplicationController
  def edit
    @item = Item.find_by(slug: params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(params)
     flash[:success] = "Your updates have been saved"
     redirect_to dashboard_path
   else
     flash.now[:warning] = @item.errors.full_messages.join(", ")
     render :edit
   end
  end
end
