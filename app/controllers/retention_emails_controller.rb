class RetentionEmailsController < ApplicationController
  before_action :set_retention_email, only: %i[ show edit update destroy ]

  # GET /retention_emails or /retention_emails.json
  def index
    @retention_emails = RetentionEmail.all
  end

  # GET /retention_emails/1 or /retention_emails/1.json
  def show
  end

  # GET /retention_emails/new
  def new
    @retention_email = RetentionEmail.new
  end

  # GET /retention_emails/1/edit
  def edit
  end

  # POST /retention_emails or /retention_emails.json
  def create
    @retention_email = RetentionEmail.new(retention_email_params)

    respond_to do |format|
      if @retention_email.save
        format.html { redirect_to retention_email_url(@retention_email), notice: "Retention email was successfully created." }
        format.json { render :show, status: :created, location: @retention_email }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @retention_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /retention_emails/1 or /retention_emails/1.json
  def update
    respond_to do |format|
      if @retention_email.update(retention_email_params)
        format.html { redirect_to retention_email_url(@retention_email), notice: "Retention email was successfully updated." }
        format.json { render :show, status: :ok, location: @retention_email }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @retention_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retention_emails/1 or /retention_emails/1.json
  def destroy
    @retention_email.destroy

    respond_to do |format|
      format.html { redirect_to retention_emails_url, notice: "Retention email was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retention_email
      @retention_email = RetentionEmail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def retention_email_params
      params.require(:retention_email).permit(:body, :date_from, :date_to)
    end
end
