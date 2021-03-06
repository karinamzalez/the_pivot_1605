class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      @item.set_business(current_user)
      flash[:success] = "Item with name, #{@item.name} successfully created!"
      redirect_to dashboard_path
    else
      flash[:danger]= @item.errors.full_messages.join(", ")
      redirect_to new_admin_item_path
    end
  end

  def edit
    @item = Item.find_by(slug: params[:id])
  end

  def update
    @item = Item.find_by(slug: params[:id])
    if @item.update(item_params)
     flash[:success] = "Your updates have been saved"
     redirect_to dashboard_path
   else
     flash.now[:danger] = @item.errors.full_messages.join(", ")
     render :edit
   end
 end

  def destroy
    item = Item.find_by(slug: params[:id])
    item.update_attribute("status", false)
    flash[:success] = "Successfully deactivated item"
    redirect_to dashboard_path
  end

private

  def item_params
    params.require(:item).permit(
    :name,
    :price,
    :description,
    :category_id,
    :image_url,
    :status,
    :slug
    )
  end
end
