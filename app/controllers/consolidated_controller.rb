class ConsolidatedController < ApplicationController
	
layout 'test_default'	
	
  # GET /priorities
  # GET /priorities.xml
  def status
    #foo = Consolidated.con_status(params[:q])
    @result_array = Consolidated.con_status(params[:q])
    @con_db = params[:q]
    respond_to do |format|
      format.html # status.html.erb
      format.xml  { render :xml => @result_array }
    end
    #flash[:notice] = foo
  end

  end

  
