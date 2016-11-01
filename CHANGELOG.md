## UNRELEASED

* Fix random delay string conversion check
* Change random delay shell to bash as cron runs with /bin/sh and they are not
* Make random delay command link a `;` as with `&&` may prevent the job from
  running if sleep with bad input (or for any reason) fails.

## v0.0.1

* Fix random delay to not run sleep when value is 0
* Escape the cron % char
* Fix setting random delay
* Fix minutes->minute and hours->hour typos
* Default crons to every 30 mins
* Use disabled key in pillar to switch off job instead of enabled
* Update README to show enabled setting as optional
* Default to once every ten minutes
* Add formula requirement on aws-formula for one_instance asg check
* Make jobs disable-able
* Initial cron salt configuration and docs

