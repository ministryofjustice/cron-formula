cron-formula
============

This formula creates cron setup and jobs from pillar data

Pillar example
--------------

.. code:: yaml

   cron:                                     # Main cron section
      jobs:                                  # A dictionary of cron jobs
         job1:                               # the job id
            name: helloworld                 # the command to be run
            minutes: 1                       # (optional) The information to be set into the minute section. Default is */30
            hour: 2                          # (optional) The information to be set in the hour section. Default is *
            dayweek: 3                       # (optional) The information to be set in the day of week section. Default is *
            daymonth:                        # (optional) The information to be set in the day of month section. Default is *
            user: john                       # (optional) The name of the user whose crontab needs to be modified, defaults to the root user
            random_delay: 0                  # (optional) set a max random delay before running the job
            one_instance: False              # (optional) True will ensure that only one instance runs the job
            comment: "This is my job!"       # (optional) User comment to be added on line previous the cron job
            log: "/var/log/helloworld.log"   # (optional) The file to log the command output to, defaults to cron.log
