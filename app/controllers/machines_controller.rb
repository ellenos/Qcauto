class MachinesController < ApplicationController

  layout 'test_default'

  # GET /machines
  # GET /machines.xml
  def index
    silence_stream(STDOUT) do
      @machines = Machine.find(:all, :order=> 'name')
    end
   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @machines }
    end
  end

  # GET /machines/1
  # GET /machines/1.xml
  def show
    @machine = Machine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @machine }
    end
  end

  # GET /machines/new
  # GET /machines/new.xml
  def new
    @machine = Machine.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @machine }
    end
  end

  # GET /machines/1/edit
  def edit
    @machine = Machine.find(params[:id])
  end

  # POST /machines
  # POST /machines.xml
  def create
    @machine = Machine.new(params[:machine])

    respond_to do |format|
      if @machine.save
        flash[:notice] = 'Machine was successfully created.'
        format.html { redirect_to(@machine) }
        format.xml  { render :xml => @machine, :status => :created, :location => @machine }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @machine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /machines/1
  # PUT /machines/1.xml
  def update
    @machine = Machine.find(params[:id])

    respond_to do |format|
      if @machine.update_attributes(params[:machine])
        flash[:notice] = 'Machine was successfully updated.'
        format.html { redirect_to(@machine) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @machine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.xml
  def destroy
    @machine = Machine.find(params[:id])
    @machine.destroy

    respond_to do |format|
      format.html { redirect_to(machines_url) }
      format.xml  { head :ok }
    end
  end
  
  def offline
    @machine = Machine.find(params[:id])
    @machine.online = false
    @machine.save
     respond_to do |format|
        flash[:notice] = 'Machine status has been set to offline.'
        format.html { redirect_to :action => :index }
        format.xml  { head :ok }
      end   
  end
  
  def set_all_offline
    @machines = Machine.find(:all, :order=> 'name')
    @machines.each do |machine|
      machine.online = false
      machine.save
     end
  end
  
  
  def online
    @machine = Machine.find(params[:id])
    @machine.online = true
    @machine.save
     respond_to do |format|
        flash[:notice] = 'Machine status has been set to online.'
        format.html { redirect_to :action => :index }
        format.xml  { head :ok }
      end   
  end


  def reboot
    @machine = Machine.find(params[:id])
    @machine.reboot_machine
    respond_to do |format|
        flash[:notice] = 'Machine is being rebooted.'
        format.html { redirect_to :action => :index }
        format.xml  { head :ok }
    end
  end
  
end
