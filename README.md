MACRON 1
--------
[![codecov](https://codecov.io/gh/leouofa/aquarius/branch/master/graph/badge.svg?token=SpfdxrArOG)](https://codecov.io/gh/leouofa/aquarius)

##### "with great power comes great responsibility"
     
     
![macron1](https://classicanimemuseum.files.wordpress.com/2018/03/goshogun_hd.jpg) 

# Running Localy
```bash
foreman start --procfile=Procfile.dev
```

## Preparation
```bash

# pull the database
heroku pg:pull postgresql-symmetrical-54909 aquarius_development --app demo-idealogic-io-305
foreman run rake components:setup
```

## Enviornment Variables
```
FROM_EMAIL=noreply@idealogic.io
UPLOADCARE_PRIVATE_KEY
UPLOADCARE_PUBLIC_KEY
URL
```

### Mail (Development)
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

# Framework

## Site Settings
The site settings are stored in __SiteSettings__ and include the __Autoloadable__ module.
``` ruby
## Article Settings

module SiteSettings::Theme
  class Article < Setting
    include Autoloadable
  end
end

```

## Authentication
The authentication is driven by the auth.yml file located under _core/auth.yml_ and is structured as follows
```yml
roles:
abilities:
actions:
permissions:
    - role:
        - ability
```

#### Helpful Documents
Documentation that may be useful to developers.

##### Testing
- https://wyeworks.com/blog/2018/1/16/Testing-Vuejs-in-Rails-with-Webpacker-and-Jest

##### Security
- https://bauland42.com/ruby-on-rails-content-security-policy-csp/

##### Deployment
- https://app.forestadmin.com/
