# Step 1 — Installing the Components from the Ubuntu Repositories
# sudo apt update
# sudo apt install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools
# Step 2 — Creating a Python Virtual Environment
# sudo apt install python3-venv
# mkdir ~/myproject
# cd ~/myproject
# python3 -m venv myprojectenv(Create a virtual environment to store your Flask project’s Python requirements by typing:)
# source myprojectenv/bin/activate(Before installing applications within the virtual environment, you need to activate it. Do so by typing:)
# Step 3 — Setting Up a Flask Application
# pip install wheel
# pip install gunicorn flask
# nano ~/myproject/myproject.py
# from flask import Flask
# app = Flask(__name__)

# @app.route("/")
# def hello():
#     return "<h1 style='color:blue'>Hello There!</h1>"

# if __name__ == "__main__":
#     app.run(host='0.0.0.0')


# sudo ufw allow 5000
# python myproject.py

# Output
# Serving Flask app "myproject" (lazy loading)
#  * Environment: production
#    WARNING: Do not use the development server in a production environment.
#    Use a production WSGI server instead.
#  * Debug mode: off
#  * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)


#  http://"your_server"_ip:5000




# nano ~/myproject/wsgi.py


# from myproject import app

# if __name__ == "__main__":
#     app.run()



# Step 4 — Configuring Gunicorn
# cd ~/myproject
# gunicorn --bind 0.0.0.0:5000 wsgi:app






# Output
# [2020-05-20 14:13:00 +0000] [46419] [INFO] Starting gunicorn 20.0.4
# [2020-05-20 14:13:00 +0000] [46419] [INFO] Listening at: http://0.0.0.0:5000 (46419)
# [2020-05-20 14:13:00 +0000] [46419] [INFO] Using worker: sync
# [2020-05-20 14:13:00 +0000] [46421] [INFO] Booting worker with pid: 46421

 
#  http://your_server_ip:5000

#  deactivate


#  sudo nano /etc/systemd/system/myproject.service



#  [Unit]
# Description=Gunicorn instance to serve myproject
# After=network.target

# [Service]
# User="  "
# Group=www-data
# WorkingDirectory=/home/" "/myproject
# Environment="PATH=/home/" "/myproject/myprojectenv/bin"
# ExecStart=/home/" "/myproject/myprojectenv/bin/gunicorn --workers 3 --bind unix:myproject.sock -m 007 wsgi:app

# Install]
# WantedBy=multi-user.target


# sudo systemctl start myproject
# sudo systemctl enable myproject
# Let’s check the status:

# sudo systemctl status myproject


# Output
# ● myproject.service - Gunicorn instance to serve myproject
#      Loaded: loaded (/etc/systemd/system/myproject.service; enabled; vendor preset: enabled)
#      Active: active (running) since Wed 2020-05-20 14:15:18 UTC; 1s ago
#    Main PID: 46430 (gunicorn)
#       Tasks: 4 (limit: 2344)
#      Memory: 51.3M
#      CGroup: /system.slice/myproject.service
#              ├─46430 /home/sammy/myproject/myprojectenv/bin/python3 /home/sammy/myproject/myprojectenv/bin/gunicorn --workers 3 --bind unix:myproject.sock -m 007 wsgi:app
#              ├─46449 /home/sammy/myproject/myprojectenv/bin/python3 /home/sammy/myproject/myprojectenv/bin/gunicorn --workers 3 --bind unix:myproject.sock -m 007 wsgi:app
#              ├─46450 /home/sammy/myproject/myprojectenv/bin/python3 /home/sammy/myproject/myprojectenv/bin/gunicorn --workers 3 --bind unix:myproject.sock -m 007 wsgi:app
#              └─46451 /home/sammy/myproject/myprojectenv/bin/python3 /home/sammy/myproject/myprojectenv/bin/gunicorn --workers 3 --bind unix:myproject.sock -m 007 wsgi:app




# Step 5 — Configuring Nginx to Proxy Requests
# sudo nano /etc/nginx/sites-available/myproject
# server {
#     listen 80;
#     server_name your_domain www.your_domain;

#     location / {
#         include proxy_params;
#         proxy_pass http://unix:/home/sammy/myproject/myproject.sock;
#     }
# }

# sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
# sudo nginx -t
# sudo systemctl restart nginx
# sudo ufw delete allow 5000
# sudo ufw allow 'Nginx Full'


# http://your_domain


# source https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-20-04