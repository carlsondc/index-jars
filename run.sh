#!/bin/bash
sudo ./findJars.sh | tee all_jars | ./indexJars.sh > indexed
