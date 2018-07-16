class DelayedMonitor < ActiveRecord::Base
  
  MAX_RUN_TIME = 4.hours
  #MAX_RUN_TIME = 2.minutes
  set_table_name :delayed_jobs

  # NextTaskSQL         = '(run_at <= ? AND (locked_at IS NULL OR locked_at < ?) OR (locked_by = ?)) AND failed_at IS NULL AND finished_at IS NULL'

  # "SELECT * FROM delayed_jobs WHERE created_at < '#{(Time.now-c['stale']).utc.strftime("%Y-%m-%d %H:%M:%S")}'"


  StuckTaskSQL        = 'first_started_at IS NOT NULL AND first_started_at < ? AND failed_at IS NULL'
  WaitingTaskSQL      = 'first_started_at IS NULL AND locked_at IS NULL AND failed_at IS NULL AND finished_at IS NULL'
  RunningTaskSQL      = 'first_started_at < ? AND failed_at IS NULL AND finished_at IS NULL'

  def self.waiting
    conditions = WaitingTaskSQL.dup
    records = ActiveRecord::Base.silence do
      find(:all, :conditions => conditions)
    end
    return records
  end

  def self.jobs_stuck()
    sql = StuckTaskSQL.dup
    conditions = [Time.now - MAX_RUN_TIME]
    conditions.unshift(sql)
    records = ActiveRecord::Base.silence do
      find(:all, :conditions => conditions)
    end
    return records
  end

  def self.too_long()
    find_stuck.each do |job|
      logger.debug "late job: " + job.id.to_s
      logger.debug "first_started at is " + job.run_at.to_s
    end
  end

  def self.number_of_jobs
    
    row = Delayed::Job.find_by_sql "SELECT * FROM delayed_jobs WHERE \
                                locked_at IS NULL and finished_at IS NULL"
    iCount = row.length
    logger.debug "Number of jobs: " + iCount.to_s
    return iCount.to_s
  end

  def self.get_dbcode(delayed_id)
    row = QtpResource.find_by_delayed_job_id(delayed_id)
    if row then
      dbcode = row.dbcode
    else
      dbcode = "none"
    end
    return dbcode
  end
  
end
