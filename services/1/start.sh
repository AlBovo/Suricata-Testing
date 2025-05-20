#!/bin/sh
ip r add 192.168.8.0/24 via 192.168.7.254

./tmNIDS.sh -99 # run all tests
