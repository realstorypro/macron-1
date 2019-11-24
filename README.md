MACRON-1
--------
[![codecov](https://codecov.io/gh/leouofa/aquarius/branch/master/graph/badge.svg?token=SpfdxrArOG)](https://codecov.io/gh/leouofa/aquarius)

# Local Development

### Setting Up Database
You can import the database from an existing Heroku application with __pg:pull__ command.  

```bash
heroku pg:pull heroku_db_name aquarius_development --app heroku_app_name
foreman run rake components:setup
```

### Setting up Hypershield

#### Locally
#### On Heroku

### Setting Environment Variables
The environmental variables are stored in a .env file. They can be pulled down from an existing Heroku app.

```bash
heroku config -s -a heroku_app_name > .env
```

### Setting up Mailcatcher
We're using the mailcatcher to catch the mail send in development environment.

Install the gem by running
```bash
  gem install mailcatcher
```
  
Start the mail catcher server with
```bash
  mailcatcher
```
You can read sent mail by at  __http://127.0.0.1:1080/__

### Running It
```bash
./bin/webpack-dev-server
foreman run sidekiq -C config/sidekiq.yml --verbose
foreman run rails s
```

# Pull Requests
All changes must come in ways of pull requests and never committed directly to master. 

The must be precompiled locally prior to submitting a PR. This can be done by running the following command.
```bash
rm -rf public/packs; foreman run rake assets:precompile; git add .; gcam 'precompiled assets'
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
