## Puppy Playdate 

Does your dog seem bored? Are you curious about any dog park meet ups or social events near you? Puppy Playdate is designed to meet the need for dog socialization, allowing users to connect with nearby dogs for playdates, ensuring their pets enjoy regular and enriching social interactions. The app uses geolocation so you can peak at a map and see just how close your dogs new best friend might be. You can host a doggy meet up, receive invites to them, schedule a 1 on 1 meet up and more.

### Come check out the app here!
* Insert link to deployment here.

## Built With
<img src="https://logowik.com/content/uploads/images/heroku8748.jpg" alt="drawing" width="100"/>
<img src="https://mikewilliamson.files.wordpress.com/2010/05/rails_on_ruby.jpg" alt="drawing" width="75"/>
<img src="https://codekitapp.com/images/help/free-bootstrap-icon@2x.png" alt="drawing" width="100"/>
<!-- <img src="https://logowik.com/content/uploads/images/circleci8026.jpg" alt="drawing" width="100"/> -->
<img src="https://www.loginradius.com/blog/static/a9dad0fc4bf1af95243aa5e2d017bc22/a8669/google_cover.jpg" alt="drawing" width="100"/>

## Gems and testing 
- [Faraday](https://github.com/lostisland/faraday) gem to interact with APIs
- [JSONAPI Serializer](https://github.com/jsonapi-serializer/jsonapi-serializer) gem for formatting JSON responses
- [SimpleCov](https://github.com/simplecov-ruby/simplecov) gem for code coverage tracking
<!-- - [Sidekiq](https://sidekiq.org/) gem for background workers -->
- [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers) gem for testing assertions
- [Capybara](https://github.com/morris-lab/Capybara) gem for end to end testing 
- [Lanchy](https://github.com/copiousfreetime/launchy) gem for inspection and debugging
<!-- - [jsbundling-rails](https://github.com/rails/jsbundling-rails) / [cssbundling-rails](https://github.com/rails/cssbundling-rails) gems for styling  -->
- [omniauth](https://github.com/omniauth/omniauth) / [omniauth-rails_csrf_protection](https://github.com/cookpad/omniauth-rails_csrf_protection) gems for oauth

- [Postman](https://www.postman.com/) to check API endpoints
- [VCR](https://github.com/vcr/vcr) / [Webmock](https://github.com/bblimke/webmock) to stub HTTP requests in tests to simulate API interactions

## API's Consumed

<img src="https://www.loginradius.com/blog/static/a9dad0fc4bf1af95243aa5e2d017bc22/a8669/google_cover.jpg" alt="drawing" width="100"/> <br>
Google Address Validation: https://developers.google.com/maps/documentation/address-validation/overview <br>
Google Places: https://developers.google.com/maps/documentation/places/web-service <br>
Google Maps:  https://www.google.com/maps/embed/v1/place?key=YOUR_API_KEY&q=YOUR_LOCATION&zoom=13maptype=satellite <br>




## Getting Started
These instructions will give you a copy of the project up and running on your local machine for development and testing purposes. 


## Install Intructions

#### Backend

Clone Repo:  
```git clone git@github.com:Puppy-Playdate/puppy_playdate_be.git```  
Open in Code editor: <br>
```cd puppy_playdate_be```  
Install Gems: <br>
```bundle install```  
Setup the Database: <br>
```rails db:{drop,create,seed,migrate}```<br>
Launch Server:<br>
```rails s```  

#### Frontend
Clone Repo:  <br>
```git clone git@github.com:Puppy-Playdate/puppy_playdate_fe.git```  <br>
Open in Code editor: <br>
```cd puppy_playdate_fe```<br>
Launch Server: <br>
```rails s```

* The backend runs on 'http://localhost:3000/'
* The frontend runs on 'http://localhost:5000/'

**GO HERE TO EXPLORE.**


## Running the tests

To run all test use ```bundle exec rspec```. 

All tests should be passing, if not..
-   Backend
    - don't forget to `bundle install`
    - `rails db:{drop,create,seed,migrate}`
- Frontend
    - Clear all cassettes. Right click and delete `vcr_cassettes` folder

Make use of simplecov with `open coverage/index.html`


## Contributors

* Tommy Takahashi 
    * [LinkedIn:](https://www.linkedin.com/in/tommy-takahashi/)
    * [Github:](https://github.com/ttakahashi1591)

* Miranda Delaney 
    * [LinkedIn:](https://www.linkedin.com/in/mld52/)
    * [Github:](https://github.com/delaneymiranda1)

* Eric Belongea 
    * [LinkedIn:](https://www.linkedin.com/in/eric-belongea/)
    * [Github:](https://github.com/EricBelongea)

* Blake Sergesketter
    * [LinkedIn:](https://www.linkedin.com/in/b-sergesketter/)
    * [Github:](https://github.com/bserge13)

* Justin Lee
    * [LinkedIn:](https://www.linkedin.com/in/justin-lee-438035294/)
    * [Github:](https://github.com/JustinSteel)


## Acknowledgments
May use this area for any hat tip to anyone whose code is used, inspiration, helpers (instructors), etc.


## PLACEHOLDER FOR PICTURES SHOWING EXAMPLES OR PARTS OF THE PROJECT WE'RE PROUD OF.