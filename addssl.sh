echo "Domain: "
read domain
apt install -y rpl letsencrypt
mkdir /var/www/$domain
cd /var/www/$domain
mkdir public
cd public
echo "<?php
phpinfo();
?>" > index.php
chown -R www-data:www-data /var/www/$domain
service nginx stop
letsencrypt certonly --standalone -d $domain
cd /root/
sed "s/bichruletka.ru/$domain/g" ssl.conf > /etc/nginx/sites-available/$domain
ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/
service nginx restart


