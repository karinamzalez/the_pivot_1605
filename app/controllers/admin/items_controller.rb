class Admin::ItemsController < ApplicationController
  def edit
    @item = Item.find_by(slug: params[:id])
  end

  def update
    item = Item.find_by(slug: params[:id])
    if item.update(item_params)
     flash[:success] = "Your updates have been saved"
     redirect_to dashboard_path
   else
     flash.now[:warning] = @item.errors.full_messages.join(", ")
     render :edit
   end
 end

  def destroy
    item = Item.find_by(slug: params[:id])
    item.update_attribute("status", false)
    flash[:success] = "Successfully deactivated item"
    redirect_to dashboard_path
  end

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
      flash.now[:warning]= @item.errors.full_messages.join(", ")
      render :new
    end
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
