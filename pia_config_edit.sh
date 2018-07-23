#!/bin/bash
# script to edit PIA opnevpn client config files for alpine linux contianer
# Inspired by private-internet-access-vpn by flamusdiu at
# https://aur.archlinux.org/packages/private-internet-access-vpn/
# This script removes spaces from file names and adds in file paths 
# for the pem, crt, and login file. It also appends lines to use the 
# up.sh and down.sh scripts.

# path and filename variables
path="/vpn/"
login_file=".login"
old_extension="ovpn"
new_extension="conf"

# removes spaces from file names and set extension to conf
for file in *.$old_extension
 do
  f1="${file// /_}"
  mv "$file" "${f1%.$old_extension}.$new_extension"
done

# adds extra info/lines to each file
# -i $file makes the change directly to the file (i stands for in place)
for file in *.$new_extension
 do
 sed "s:auth-user-pass:& $path$login_file:" -i $file
 sed "s:crl-verify.:&$path:" -i $file
 sed "s:ca\s:&$path:" -i $file
 sed 's:aes-128-cbc:AES-128-CBC:' -i $file
 sed 's:sha1:SHA1:' -i $file
 sed 's:aes-256-cbc:AES-256-CBC:' -i $file
 sed 's:sha256:SHA256:' -i $file
 echo "" >> $file
 echo "auth-nocache" >> $file
 echo "script-security 2" >> $file
 echo "up /etc/openvpn/up.sh" >> $file
 echo "down /etc/openvpn/down.sh" >> $file
done
