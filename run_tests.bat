@echo off
:: Create results directory if not exists
if not exist results mkdir results

:: Run all tests
robot --exclude browser --outputdir results ^
      --report report.html ^
      --log log.html ^
      testcase/