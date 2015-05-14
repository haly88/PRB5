class LotesController < ApplicationController
  before_action :set_lote, only: [:show, :edit, :update, :destroy]

  # GET /lotes
  # GET /lotes.json
  def index
    @lotes = Lote.all
  end

  # GET /lotes/1
  # GET /lotes/1.json
  def show
  end

  # GET /lotes/new
  def new
    @lote = Lote.new
  end

  # GET /lotes/1/edit
  def edit
  end

  # POST /lotes
  # POST /lotes.json
  def create
    @lote = Lote.new(lote_params)

    respond_to do |format|
      if @lote.save
        format.html { redirect_to @lote, notice: 'Lote was successfully created.' }
        format.json { render :show, status: :created, location: @lote }
      else
        format.html { render :new }
        format.json { render json: @lote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lotes/1
  # PATCH/PUT /lotes/1.json
  def update
    respond_to do |format|
      if @lote.update(lote_params)
        format.html { redirect_to @lote, notice: 'Lote was successfully updated.' }
        format.json { render :show, status: :ok, location: @lote }
      else
        format.html { render :edit }
        format.json { render json: @lote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lotes/1
  # DELETE /lotes/1.json
  def destroy
    @lote.destroy
    respond_to do |format|
      format.html { redirect_to lotes_url, notice: 'Lote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lote
      @lote = Lote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lote_params
      params.require(:lote).permit(:nombre, :cordenadas, :area, :localidad)
    end
end
