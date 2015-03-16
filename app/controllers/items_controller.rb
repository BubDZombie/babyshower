class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :activate, :deactivate]

  def activate
    @item.available = true
    @item.save!
    render( 'show' )
  end

  def available
    @items = Item.where( available: true )
    render( 'index' )
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def deactivate
    @item.available = false
    @item.save!
    render( 'show' )
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /items/1/edit
  def edit
  end

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    if( params.has_key?( 'order' ))
      logger.debug( "Ordering by #{params['order']}." )
      @items = @items.order( params['order'] )
    end
    if( params.has_key?( 'available' ))
      logger.debug( "Filtering by available = #{params['available']}." )
      @items = @items.where( available: params['available'] )
    end
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  def taken
    @items = Item.where( available: false )
    render( 'index' )
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:link, :image_url, :msrp, :available)
    end
end
