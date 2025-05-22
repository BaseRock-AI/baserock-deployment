#!/bin/bash

chmod +x bundle/download_save_list.sh
chmod +x bundle/create_tar.sh
source ./bundle/bundle_vars.sh

./bundle/download_save_list.sh
./bundle/create_tar.sh