module Delayed
  class Worker
    SLEEP = 5

    cattr_accessor :logger
    self.logger = if defined?(Merb::Logger)
      Merb.logger
    elsif defined?(RAILS_DEFAULT_LOGGER)
      RAILS_DEFAULT_LOGGER
    end

    def initialize(options={})
      @quiet = options[:quiet]
      Delayed::Job.min_priority = options[:min_priority] if options.has_key?(:min_priority)
      Delayed::Job.max_priority = options[:max_priority] if options.has_key?(:max_priority)
    end

    def start
      say "*** Starting job worker #{Delayed::Job.worker_name}"
      
      trap('TERM') { say 'Exiting...'; $exit = true }
      trap('INT')  { say 'Exiting...'; $exit = true }

      # silence the log so it doesnt get filled with sql statements
      bak_log_level = logger.level
      logger.level = Logger::ERROR
      loop do
        result = nil
        the_machine = nil

        realtime = Benchmark.realtime do

          until the_machine != nil
	  # this is where to set the machine if this is QA - need a flag
	    if 
            the_machine = Machine.find( :first, :conditions => {:status => 0, :online => true })
            if the_machine == nil
	      break if $exit
              sleep(30)
            else
              Delayed::Job.machine = the_machine
              result = Delayed::Job.work_off(1)
            end
          end
        end

        count = result.sum

        break if $exit

        if count.zero?
          sleep(SLEEP)
        else
          say "#{count} jobs processed at %.4f j/s, %d failed ..." % [count / realtime, result.last]
        end

        break if $exit
      end

    ensure
      Delayed::Job.clear_locks!
      logger.level = bak_log_level
    end

    def say(text)
      puts text unless @quiet
      logger.info text if logger
    end

  end
end
