class RetentionEmailsController < ApplicationController
  before_action :set_retention_email, only: %i[ show edit update destroy ]

  # GET /retention_emails or /retention_emails.json
  def index
    @retention_emails = RetentionEmail.all
  end


  def search
    @users = []
    # date_from = params[:date_from].present? ? params[:date_from] : nil
    # date_to = params[:date_to].present? ? params[:date_to] : nil

    check_param = validate_range_params(params[:date_from], params[:date_to])

    
    @users = User.find_by_date_ranges(check_param[:date_from], check_param[:date_to]) if check_param[:valid]
    

    if request.post?
      if check_param[:valid]
        if is_search_click?
          redirect_to search_retention_emails_path(date_from: check_param[:date_from], date_to: check_param[:date_to])
        elsif is_send_click?
          @users = User.find_by_date_ranges(check_param[:date_from], check_param[:date_to])
          @users.each do |user|
            user.create_reten_email_record(params[:body], check_param[:date_from], check_param[:date_to])
          end

        end
      else
        flash.now[:notice] = check_param[:message]
        redirect_to search_retention_emails_path(date_from: params[:date_from], date_to: params[:date_to])
      end
      
    end

    
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "author-retention-users-#{Time.zone.today}.csv" }
    end
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

    def is_search_click?
      params[:commit] == "Search"
    end

    def is_send_click?
      params[:commit] == "Send"
    end

    def validate_range_params(from_param, to_param)
      date_from = parse_date(from_param)
      date_to = parse_date(to_param)

      return_obj = {
        date_from: date_from,
        date_to: date_to,
        valid: false
      }

      if date_from.present? && date_to.present?
        if date_from < date_to
          return_obj.merge!(messge: "Okay", valid: true)
        else
          return_obj.merge!(messge: "Start date should be greater than from date.")
        end
      elsif !date_from.present? && date_to.present?
        return_obj.merge!(messge: "From date required!")
      elsif date_from.present? && !date_to.present?
        return_obj.merge!(messge: "End date required!")
      else
        return_obj.merge!(messge: "Invalid Params")
      end

      return_obj
    end

    def parse_date(param_date)
      return nil unless param_date.present?
      date_obj = Date.parse(param_date) rescue nil 
      date_obj = nil unless (date_obj.is_a?(Date) || date_obj.is_a?(Time))
      date_obj
    end
end
