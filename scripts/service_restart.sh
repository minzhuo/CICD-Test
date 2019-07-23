#!/bin/bash

# basic setting 
# Exit immediately if a command exits with a non-zero status: set -e
# Exit immediately if any part of the pipeline fails: set -o pipefail
set -eo pipefail

### function ###
function main() {
	nginx -t
	service nginx reload	
}


#### 
echo "syntax check begin, and then reload nginx service."
main
echo "Done."

