#! /bin/bash

apt-get update && apt-get autoremove -y && apt-get install nginx -y && service nginx restart && service nginx status
