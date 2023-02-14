#!/bin/bash


# Install Node.js and npm
sudo apt-get update
sudo apt-get install -y nodejs npm

# Create a new directory for the project and navigate to it
mkdir disk-usage-api
cd disk-usage-api

# Create a new index.js file with the API code
cat <<EOF > index.js
const express = require('express');
const disk = require('diskusage');

const app = express();
const port = 3000;

app.get('/', (req, res) => {
  disk.check('/', (err, info) => {
    if (err) {
      console.error(err);
      res.status(500).send('Internal server error');
    } else {
      res.json({
        total: info.total,
        free: info.free,
        used: info.total - info.free,
      });
    }
  });
});

app.listen(port, () => {
  console.log('API server listening at http://localhost:' + port);
});
EOF

# Initialize the project with npm
npm init -y

# Install the required dependencies
npm install express diskusage

# Start the server
node index.js
