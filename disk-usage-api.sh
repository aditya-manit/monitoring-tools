#!/bin/bash

# Install Node.js and npm
sudo apt-get update
sudo apt-get install -y nodejs npm

# Create a directory for your project
mkdir disk-usage-api
cd disk-usage-api

# Create the index.js file with the disk usage function
cat << EOF > index.js
const disk = require('diskusage');

function diskUsage(callback) {
  disk.check('/', (error, info) => {
    if (error) {
      callback(error);
    } else {
      const data = {
        total: info.total,
        free: info.available,
        used: info.total - info.available
      };
      callback(null, data);
    }
  });
}

module.exports = diskUsage;
EOF

# Initialize the project with npm
npm init -y

# Install the diskusage package
npm install diskusage
