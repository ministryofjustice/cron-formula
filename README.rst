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
         disabled: False                  # (optional) True to disable the job, default is False
         minute: 1                        # (optional) The information to be set into the minute section. Default is */30
         hour: 2                          # (optional) The information to be set in the hour section. Default is *
         dayweek: 3                       # (optional) The information to be set in the day of week section. Default is *
         daymonth:                        # (optional) The information to be set in the day of month section. Default is *
         user: john                       # (optional) The name of the user whose crontab needs to be modified, defaults to the root user
         random_delay: 0                  # (optional) set a max random delay before running the job
         one_instance: False              # (optional) True will ensure that only one instance runs the job
         comment: "This is my job!"       # (optional) User comment to be added on line previous the cron job
         log: "/var/log/helloworld.log"   # (optional) The file to log the command output to, defaults to cron.log


Syntax idiosyncrasies
---------------------
Obviously shell scripts can have a very special syntax with special characters and so on. Sometimes you can get errors like:: 

   ParserError: while parsing a block mapping
     in "<unicode string>", line 22, column 7:
           - name: ' /usr/bin/python /srv/sal ...
                   ^
   expected <block end>, but found '<scalar>'
     in "<unicode string>", line 22, column 94:




Below is a complex example with some such special characters. This was done with the help of http://stackoverflow.com/questions/3790454/in-yaml-how-do-i-break-a-string-over-multiple-lines

.. code:: yaml

   process_foo_queue:                               # the job id
     name: |-
       docker exec my_container bash -c ''RAILS_ENV=production bundle exec rake foo:process_queue''
     disabled: False                  # (optional) True to disable the job, default is False
     minute: '*'                        # (optional) The information to be set into the minute section. Default is */30
     one_instance: True               # (optional) True will ensure that only one instance runs the job
     log: "/var/log/schedule.log"

So what is happening here is that the we enter the command in "name:" using |- to indicate a multiline string that does not have any newlines. The double quotation mark results to a single quotation mark. The minute: * may indicate an anchor reference, if so enclose in single quotes. Finally, although not used here, it is worth mentioning that the characters ``\`` and ``"`` must be escaped by ``\`` .
