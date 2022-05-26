class LineItemsController < ApplicationController
  before_action :set_quote
  before_action :set_line_item_date
  before_action :set_line_item, only: [:edit, :update, :destroy]

  def new
    @line_item = LineItem.new
  end

  def create
    @line_item = @line_item_date.line_items.build(line_items_params)
    if @line_item.save
      respond_to do |format|
        format.turbo_stream{ flash.now[:notice] = "Item was successfully saved"}
        format.html{ redirect_to quote_path(@quote), notice: "Item was successfully saved" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @line_item.update(line_items_params)
      respond_to do |format|
        format.html{ redirect_to quote_path(@quote), notice: "Item was successfully updated" }
        format.turbo_stream{flash.now[:notice]= "Item was successfully updated"}
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    respond_to do |format|
      if @line_item.destroy
        format.html{redirect_to quote_path(@quote), notice: "Item has been successfully destroyed"}
        format.turbo_stream{flash.now[:notice] = "Item was successfully destroyed"}
      end
    end
  end

  private

  def line_items_params
    params.require(:line_item).permit(:name, :description, :quantity, :unit_price, :line_item_date_id)
  end

  def set_quote
    @quote = Quote.find(params[:quote_id])
  end

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def set_line_item_date
    @line_item_date = LineItemDate.find(params[:line_item_date_id])
  end
end