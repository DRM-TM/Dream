Dream.
=========

Dream. is a dream sharing mobile application.

Installation
--------------

Soon on android and ios app stores

API routes
--------------

Request over HTTP only


Host: http://0.0.0.0:15030

Root path: /api

Returned data's format: JSON

***User resource***
* GET /api/user - Get every users
* GET /api/user/:uid - Get user with id *uid*

***Dream resource***
* GET /api/dream
* GET /api/dream/:uid
* GET /api/dream/incategory/:category_id

***Comment resource***
* GET /api/comment - Get every comments
* GET /api/comment/:uid - Get comment with id *uid*
* GET /api/comment/bydreamid/:dream_id
* GET /api/comment/byuserid/:uid


***Hashtag resource***
* GET /api/hashtag - Get every hashtags
* GET /api/hashtag/:uid - Get hashtag with id *uid*
* GET /api/hashtag/bydreamid/:dream_id
* GET /api/hashtag/byuserid/:uid
