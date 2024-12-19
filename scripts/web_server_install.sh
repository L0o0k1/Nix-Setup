installing_web_server() {
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
# Ensure nginx is running.
# ------------------------
systemctl enable nginx
systemctl restart nginx

logs "Nginx Web Server Installed and Configured"
}