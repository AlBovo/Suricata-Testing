#!/bin/sh
ip r replace default via 192.168.7.254

./tmNIDS.sh -99 # run all tests
