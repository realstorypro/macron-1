MACRON-1
--------
[![codecov](https://codecov.io/gh/leouofa/aquarius/branch/master/graph/badge.svg?token=SpfdxrArOG)](https://codecov.io/gh/leouofa/aquarius)

# Local Setup

### Setting Up Database
You can import the database from an existing Heroku application with __pg:pull__ command.  
Replace the __postgresql-symmetrical-54909__ with the name of the database 
and __demo-idealogic-io-305__ with the name of the app you are pulling from.

```bash
heroku pg:pull postgresql-symmetrical-54909 aquarius_development --app demo-idealogic-io-305
foreman run rake components:setup
```

#### Running It
```bash
./bin/webpack-dev-server
foreman run sidekiq -C config/sidekiq.yml --verbose
foreman run rails s
```

## Setting Environment Variables
```
FROM_EMAIL=noreply@idealogic.io
UPLOADCARE_PRIVATE_KEY
UPLOADCARE_PUBLIC_KEY
```

## Database Setup


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

# Deployment
1. Remove existing packs
```bash
rm -rf public/packs
```

2. Precompile assets locally
```bash
foreman run rake assets:precompile
```

3. Push to Heroku
```bash
git push heroku master
```

# New Deployment
Add the rake task to Heroku Scheduler and set it to run every 10 minutes:
```bash
rake simple_scheduler
```

# Framework

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

## Site Settings
Every implementation of the platform can have its own settings stored in the database. 
We refer to them as "Site Settings".

### Modules
The Site Setting modules are configured under __/core/site_settings.yml__
```yaml
site_settings_theme_branding:
    klass: 'SiteSettings::Theme::Branding'
    path: 'admin_settings_theme_branding'
    enabled: true
```

The site settings are stored under __SiteSettings__ namespace and include the __Autoloadable__ module.
``` ruby
## Article Settings

module SiteSettings::Theme
  class Article < Setting
    include Autoloadable
  end
end

```

### Menus
In order for the modules to be viewable on the backend they must be enabled in the settings under __core/menus/site_settings__

```yaml
menu:
  settings:
    - section:
      - name: General
        hint: Set name, description, and url
        path: admin_settings_general
        icon: setting
        enabled: true
```

## Components
All components are defined under components.yml

## Areas
There are 3 areas in the application, which are defined under under __/app/models/areas/__.

- Header
- Content
- Footer



Every component can have those areas enabled. By default none are enabled.

```yml
  discussions:
    klass: 'Discussion'
    path: 'discussions'
    enabled: true
    areas:
      - content
```

## Elements

- Elements are defined in components.yml (change that )
- The Menu Elements are also defined in menu/elements.yml (maybe change that)

#### Helpful Documents
Documentation that may be useful to developers.

##### Testing
- https://wyeworks.com/blog/2018/1/16/Testing-Vuejs-in-Rails-with-Webpacker-and-Jest

##### Security
- https://bauland42.com/ruby-on-rails-content-security-policy-csp/

##### Deployment
- https://app.forestadmin.com/
