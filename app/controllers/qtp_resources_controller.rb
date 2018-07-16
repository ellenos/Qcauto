class QtpResourcesController < ApplicationController

  layout 'test_default'
  
  # GET /qtp_resources
  # GET /qtp_resources.xml
  def index
    silence_stream(STDOUT) do
      @qtp_resources = QtpResource.find(:all, :conditions=>['run_status != ?', 'WAITING'], :order=> 'id DESC')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @qtp_resources }
    end
  end

  # GET /qtp_resources/1
  # GET /qtp_resources/1.xml
  def show
    @qtp_resource = QtpResource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @qtp_resource }
    end
  end

  # GET /qtp_resources/new
  # GET /qtp_resources/new.xml
  def new
    @qtp_resource = QtpResource.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @qtp_resource }
    end
  end

  # POST /qtp_resources
  # POST /qtp_resources.xml
  def create
    #DelayedMonitor.too_long
    @qtp_resource = QtpResource.new(params[:qtp_resource])
    logger.debug "current database is " + @qtp_resource.dbcode

    #this can be removed, added to be backward compatible
    if @qtp_resource.coverage == nil then
      @qtp_resource.coverage = ""
    end

    #Set Coverage
    n = @qtp_resource.dbcode.index('_')
    if n != nil
      #logger.debug "found an underscore"
      a = @qtp_resource.dbcode.split('_')
      @qtp_resource.dbcode = a[0]
      @qtp_resource.coverage = a[1]
    elsif @qtp_resource.coverage.length < 3 then  #not set to at least full
       @qtp_resource.coverage = case params[:label]
        when "liveqc" then "medium"
        when "live" then "none"
        when "rebuildlive" then "light"
        else "full"
        end
    end
    @qtp_resource.label = params[:label]
    @qtp_resource.save

    @qtp_resource.run_from = 'prod'
    if qcauto_user_agent
      @qtp_resource.run_from = 'autosys'
    end
    if appworx_qaaw_user_agent
      @qtp_resource.run_from = 'qaaw'
    end
    if appworx_paaw_user_agent
      @qtp_resource.run_from = 'paaw'
    end
    if appworx_prod_user_agent
      @qtp_resource.run_from = 'prod'
    end
	if appworx_qa_user_agent
	  @qtp_resource.run_from = 'qa'
    end
	
	if @qtp_resource.coverage == 'none' then
	  @qtp_resource.run_status = 'PASSED'
	  logger.debug "set status to PASSED because label is live"
	else
	  @qtp_resource.run_status = 'WAITING'
	end
    
    #set database priority
    if @qtp_resource.run_from == 'qaaw' or @qtp_resource.run_from == 'paaw' then
      sPL = @qtp_resource.label + 'qa'
    else
      sPL = @qtp_resource.label
    end
    current_label = Label.find_by_name(sPL)
    db_priority = current_label.priority

    if sPL.slice(sPL.length-2, 2) == 'qc' or sPL == 'rebuild' or sPL == 'live' then
      dbp = Priority.find_by_dbcode(@qtp_resource.dbcode)
      if !dbp.nil?
        logger.debug "priority set by dbcode = " + dbp.priority.to_s
        db_priority = dbp.priority
      end
    end

    if @qtp_resource.coverage != 'none' then
      @qtp_resource.priority = db_priority
     #logger.debug "current label is " + @qtp_resource.label + " with priority " + db_priority.to_s
      t = Delayed::Job.enqueue QcautoDelayedNotification.new(@qtp_resource), db_priority
      @qtp_resource.delayed_job_id = t.id
    end
    @qtp_resource.save
    
    #Passes the qc_auto.pl script the id to check for return value
    if qcauto_user_agent
      render :nothing => true
    elsif appworx_qaaw_user_agent
      render :text => @qtp_resource.id.to_s
    elsif appworx_paaw_user_agent
      render :text => @qtp_resource.id.to_s
    elsif appworx_prod_user_agent
      render :text => @qtp_resource.id.to_s
	elsif appworx_qa_user_agent
      render :text => @qtp_resource.id.to_s
    else
	  render :text => @qtp_resource.id.to_s
      #redirect_to :action => :new
    end
  end
 

  # GET /qtp_resource/status/dbname
  def status
    #@qtp_resource = QtpResource.find_by_dbcode(params[:qtp_resource])
    @qtp_resource = QtpResource.find(params[:id])

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @qtp_resource }
    end


  end

  # DELETE /qtp_resources/1
  # DELETE /qtp_resources/1.xml
  def destroy
    @qtp_resource = QtpResource.find(params[:id])
    @qtp_resource.destroy

    respond_to do |format|
      format.html { redirect_to(qtp_resources_url) }
      format.xml  { head :ok }
    end
  end
end
