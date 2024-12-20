#!/bin/bash

# Function to install and configure a web server
installing_web_server() {
    # Create the default index.html file
    cat > /var/www/html/index.html << EOL
<!DOCTYPE html>
<html>
<head><title>Server Automated Setup</title></head>
<body>
    <h1>Server Successfully Configured</h1>
    <p>This server was set up automatically using bash scripts.</p>
</body>
</html>
EOL

    # ------------------------
    # Ensure nginx is running
    # ------------------------
    systemctl enable nginx
    systemctl restart nginx

    # Log the installation and configuration of the Nginx web server
    logs "Nginx Web Server Installed and Configured"
}
