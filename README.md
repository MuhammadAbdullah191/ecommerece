<h1>About This Project</h1>
<h2>Shop Online</h2>

Ecommerece app where user can list his products to sell online

Other then that user can order products as well. User cannot order his own product.

User can add comment or other people products

Cart is implemented which is a session based which will be destroyed as soon as session chenges or get destroyed

Devise is usad for user authentication

Stripe is used as a payment gateway

Deployment on heroku

<h1>Prerequisites</h1>
You must have rails 5 and ruby version > 2 installed. other then that you will need cloudinary and stripe developers account


<h1>Installation</h1>

 Get a free API Key from cloudinary and stripe
 Clone the repo
 git clone https://github.com/MuhammadAbdullah191/ecommerece.git
 run bundle install
 Enter your API in .env in following pattern
 <br/>
 // enter cloudinary key
 CLOUD_NAME= "ENTER YOUR API"

 // enter stripe key
 STRIPE_KEY="ENTER YOUR API"
 <br/>
 // add following postgress credintials
 <br/>
 POSTGRES_USER='ENTER YOUR User name'
 <br/>
// If you declared a password when creating the database:
<br/>
// POSTGRES_PASSWORD='password'
<br/>
POSTGRES_HOST='ENTER YOUR host'
<br/>
POSTGRES_DB='ENTER YOUR DB_NAME

// ADD FOLLOWING FOR DEVISE MAILER
<br/>
SENDMAIL_PASSWORD="PASSWORD HERE"
<br/>
SENDMAIL_USERNAME="Email here"

Bundle install and then start rails server


<h1>Contact</h1>

Contact me at @abdullah.badar@devsinc.com
