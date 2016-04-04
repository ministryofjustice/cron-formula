{% from "cron/map.jinja" import cron_defaults with context %}
{% for job_id, job_config in pillar.get('cron',{}).get('jobs',{}).iteritems() %}
{% set name = job_config.get('name') %}
{% set minute = job_config.get('minute', cron_defaults.default_minute) %}
{% set hour = job_config.get('hour', cron_defaults.default_hour) %}
{% set dayweek = job_config.get('dayweek', cron_defaults.default_dayweek) %}
{% set daymonth = job_config.get('daymonth', cron_defaults.default_daymonth) %}
{% set user = job_config.get('user', cron_defaults.default_user) %}
{% set random_delay = job_config.get('random_delay', cron_defaults.default_random_delay) %}
{% set one_instance = job_config.get('one_instance', cron_defaults.default_one_instance) %}
{% set comment = job_config.get('comment', cron_defaults.default_comment) %}
{% set log = job_config.get('log', cron_defaults.default_log) %}
{% set disabled = job_config.get('disabled', cron_defaults.default_disabled) %}
{% set cmd =  "" %}
{% if random_delay != '0' %}{% set cmd = cmd  +  " echo $(date -u) INFO: Entering random sleep phase... >> " + log + " 2>&1 && sleep $(expr $RANDOM \% " ~ random_delay + ") && " %}{% endif %}
{% if one_instance %}{% set cmd = cmd  +  " /usr/bin/python /srv/salt-formulas/_modules/asg.py && " %}{% endif %}
{% set cmd = cmd +  " " + name + " " + " >> " + log + " 2>&1 " %}
{% if disabled %}
cron_job_{{job_id}}:
  cron.absent:
    - identifier: '{{ job_id }}'
    - user: '{{ user }}'
{% else %}
cron_job_{{job_id}}:
  cron.present:
    - identifier: '{{ job_id }}'
    - name: '{{ cmd }}'
    - minute: '{{ minute }}'
    - hour: '{{ hour }}'
    - dayweek: '{{ dayweek }}'
    - daymonth: '{{ daymonth }}'
    - user: '{{ user }}'
    - comment: '{{ comment }}'
{% endif %}
{% endfor %}