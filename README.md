Dream.
=========

Dream. is a dream sharing mobile application.

The front end is developed with Ionic http://ionicframework.com/

The back end is written in D

Installation
--------------

Soon on android and ios app stores

API routes
--------------

Request over HTTP only


Host: http://0.0.0.0:15030

Root path: /api

Returned data's format: `JSON`

Every `POST` requests takes parameters.
These parameters needs to be serialized inside the request's body
in the `JSON` format.

##### Example:
###### Route: POST /api/dream
Parameters: `uint uid, uint category_id, string content`

Request's header:
* `Content-Type`: `application/json`

Request's body:
```json
{
  "uid": 1, // Numerical types such as uint needs to be numerical there too
  "category_id": 1,
  "content": "This is the content!" // String or char* needs to be quoted
}
```

***User resource***
* GET /api/user - Get every users
* GET /api/user/:uid - Get user with id *uid*
* POST /api/user - Parameters: `string email, string password, string token, string birthdate, string username`

***Dream resource***
* GET /api/dream - Get every dream
* GET /api/dream/:uid - Get dream with id *uid*
* GET /api/dream/incategory/:category_id - Get every dream in the category *
* POST /api/dream - Parameters: `uint uid, uint category_id, string content`

***Comment resource***
* GET /api/comment - Get every comments
* GET /api/comment/:uid - Get comment with id *uid*
* GET /api/comment/bydreamid/:dream_id - Get comments associated to the dream with the id *dream_id*
* GET /api/comment/byuserid/:uid - Get comments associated to the user with the id *uid*
* POST /api/comment - Parameters: `uint uid, uint dream_id, string content`


***Hashtag resource***
* GET /api/hashtag - Get every hashtags
* GET /api/hashtag/:uid - Get hashtag with id *uid*
* GET /api/hashtag/bydreamid/:dream_id - Get hashtags associated to the dream with the id *dream_id*
* GET /api/hashtag/byuserid/:uid - Get hashtags associated to the user with the id *uid*
* POST /api/hashtag - Parameters: `uint uid, uint hashtag_id, string content`
