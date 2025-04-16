#!/bin/bash

# Create results directory if not exists
mkdir -p results

# Run all tests
robot --exclude browser --outputdir results \
      --report report.html \
      --log log.html \
      testcase/