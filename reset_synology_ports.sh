if grep -e 80 -e 443 /usr/syno/share/nginx/server.mustache /usr/syno/share/nginx/DSM.mustache /usr/syno/share/nginx/WWWService.mustache; then
echo "Values will be changed"
sudo sed -i -e 's/80/81/' -e 's/443/444/' /usr/syno/share/nginx/server.mustache /usr/syno/share/nginx/DSM.mustache /usr/syno/share/nginx/WWWService.mustache && sudo systemctl restart nginx && sudo docker-compose restart -d
else
    echo "Do nothing"
fi

