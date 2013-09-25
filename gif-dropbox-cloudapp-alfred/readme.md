
## GIF+Dropbox+Alfred+Cloudapp

Jonnie Hallman is the creator of original workflow:
**http://destroytoday.com/blog/gif-workflow/**

I simply added URL shortener that he point me to (https://gist.github.com/destroytoday/6425383).

Things you need:
- read the blog post http://destroytoday.com/blog/gif-workflow/
- dropbox account
- cloudapp account
- alfred with powerpack
- decent gif collection

Replace *** with your info.

Here is the code to replace in /bin/bash script (Alfred):

* * *

dropbox_url="https://dl.dropboxusercontent.com/u/***/gif/"
echo -ne ${dropbox_url}$(basename {query}) | pbcopy

#Based on Don Southard's "Share with Dropbox" script
#http://dirtdon.com
 
#Change this to your CloudApp Username
CLOUD_USERNAME="***"
#Change this to your CloudApp Password
CLOUD_PASSWORD="***"
 
URL=`pbpaste`
 
LINK=$(curl -s --digest -u $CLOUD_USERNAME:$CLOUD_PASSWORD \
     -H "Accept: application/json" \
     -H "Content-Type: application/json" \
     -d \
       '{
         "item": {
            "name":         "'$URL'",
            "redirect_url": "'$URL'"
         }
       }' \
     "http://my.cl.ly/items")
 
SHARE=`echo $LINK | grep "content_url" | awk 'BEGIN { FS = "," } ; { print $16}' | awk -F\" '{print $(NF-1)}'`
 
echo $SHARE | tr -d '\n' | pbcopy
echo $SHARE

