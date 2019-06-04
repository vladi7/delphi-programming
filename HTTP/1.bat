set OPENSSL_CONF=C:\OpenSSL-Win32\bin9\openssl.cnf 
C:\OpenSSL-Win32\bin9\openssl.exe genrsa 2048 > site-file.key
C:\OpenSSL-Win32\bin9\openssl.exe req -new -newkey rsa:2048 -nodes -out www.mywebsite.com.csr -keyout www.mywebsite.com.key -subj "/C=FR/ST=Calvados/L=CAEN/O=My organization/CN=www.mywebsite.com"
C:\OpenSSL-win32\bin9\openssl.exe req -new -key site-file.key > site-file.csr
C:\OpenSSL-win32\bin9\openssl.exe req -new -key site-file.key -config "C:\OpenSSL-win32\bin9\openssl.cnf" -out site-file.csr
