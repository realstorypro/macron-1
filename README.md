AQUARIUS
--------

###### "with great power comes great responsibility"
     
     
![macron1](https://user-images.githubusercontent.com/433219/40011503-dbe773e4-575c-11e8-9c2c-dbb35c84dc1c.jpeg) 

## Running It
```bash
foreman s
```

## Background Jobs in Development
Make sure to ride sidekiq locally
```bash
foreman run sidekiq -C config/sidekiq.yml --verbose
```

## Mail in Development
We're utilizing the mailcatcher to catch the mail send in development environment.

If you don't have the gem already installed you do it by running the following
```
  gem install mailcatcher
```
  
You can then start the mail catcher via
```
  mailcatcher
```

You can read the sent mail by pointing the  web browser to  **http://127.0.0.1:1080/**

#### Helpful Documents
Documentation that may be useful to developers.

##### Testing
- https://wyeworks.com/blog/2018/1/16/Testing-Vuejs-in-Rails-with-Webpacker-and-Jest

##### Security
- https://bauland42.com/ruby-on-rails-content-security-policy-csp/

##### Deployment
- https://app.forestadmin.com/
