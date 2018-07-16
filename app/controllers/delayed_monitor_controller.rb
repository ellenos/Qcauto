class DelayedMonitorController < ApplicationController
  layout 'test_default'
  
  def index
  end
  

  def all
    silence_stream(STDOUT) do
      @delayed_jobs = Delayed::Job.find(:all, :order=> 'id DESC')
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def waiting
    silence_stream(STDOUT) do
      @waiting_jobs = DelayedMonitor.waiting
      @stuck_jobs = DelayedMonitor.jobs_stuck()
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def running
    silence_stream(STDOUT) do
      @running_jobs = Machine.find(:all, :conditions=>['status = ?', 1])
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def stuck
    silence_stream(STDOUT) do
      @jobs_stuck = DelayedMonitor.jobs_stuck()
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  
end
