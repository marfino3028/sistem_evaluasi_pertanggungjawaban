# ATGO-API

run container  
`docker-compose up -d`  

setting pertama kali :  

1. update composer  
`docker exec -w /var/www/html atgo-api php composer.phar update`  

2. kopi *konfigurasi.contoh.php* ke *konfigurasi.php*, sesuaikan parameter koneksi database-nya  

coba buka http://localhost:1180  

stop container  
`docker-compose down`  

contoh cara eksekusi perintah console
`docker exec atgo-api php /var/www/html/console/boot.php main test`  

cara masuk ke shell container  
`docker exec -it atgo-api /bin/bash`  