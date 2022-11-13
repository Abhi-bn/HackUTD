FROM python:3.8   
# setup environment variable  
ENV DockerHOME=/home/app/webapp  

# set work directory  
RUN mkdir -p $DockerHOME  

# where your code lives  
WORKDIR $DockerHOME  

# set environment variables  
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1  

# install dependencies  
RUN pip install --upgrade pip  

COPY requirements.txt $DockerHOME/requirements.txt
# run this command to install all dependencies  
RUN pip install -r requirements.txt  
# copy whole project to your docker home directory. 
COPY . $DockerHOME/

# port where the Django app runs  
EXPOSE 8080  
# start server  
RUN python manage.py makemigrations