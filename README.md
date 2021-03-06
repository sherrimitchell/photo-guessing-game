# API

## Overview

All access is over HTTPS, and access from the "https://vast-wildwood-6662.herokuapp.com" domain. All data is sent and received as JSON.

## Access Token

Assume that every request requires an access token unless stated otherwise. The access token must be provided in the header.

To do this make sure you set 'Access-Token' equal to the user's access token in every required request.

```
['Access-Token'] = 'f16395873f4bcee7ef5d46e531b9f659'
```

## Sign up, Login, User(s) info and Delete user

### New user registration

Access-Token:

Not required.

Path:

`POST '/users/register'`

Parameters:

| name       | type   | description                              |
|------------|--------|------------------------------------------|
| user_name   | string | username for user to be created          |
| password   | string | password has to be at least 8 characters |
| first_name | string | first name of user to be created         |
| last_name  | string | last name of user to be created          |
| email      | string | email of user to be created              |


Example data successful response:

```json
Response Status Code: 201

{
  "user_name": "whatever",
  "access_token": "f16395873f4bcee7ef5d46e531b9f659f16395873f4bcee7ef5d46e531b9f659",
  "first_name": "John",
  "last_name": "Doe",
  "email": "johndoe@gmail.com"
}
```

Example data failure response:

```json
Response Status Code: 422

{
  "errors": [
    "Password can't be blank",
    "Email can't be blank",
    "Email is not a valid email.",
    "User name can't be blank",
    "First name can't be blank",
    "Last name can't be blank"
  ]
}

```

### User login

Access-Token:

Not required.

Path:

`POST '/users/login'`

Parameters:

| name     | type   | description                                                 |
|----------|--------|-------------------------------------------------------------|
| user_name | string | username for the user you want get authentication key for   |
| password | string | password for the user you want get authentication token for |

Example data successful response:

```json
Response Status Code: 200

{
  "user_name": "whatever",
  "access_token": "f16395873f4bcee7ef5d46e531b9f659"
}
```

Example data failure response:

```json
Response Status Code: 422

{
  "message":"The username or password you supplied is incorrect."
}
```

### Get all users

Access-Token:

Not required.

Path:

`GET '/users'`

Parameters:

| name | type    | description                        |
|------|---------|------------------------------------|
| page | integer | defaults to 1, 25 results per page |


Example data successful response:

```json
Response Status Code: 200

[
  {
    "user_name": "rickard",
    "first_name": "rsdffdasdf",
    "last_name": "rsfsdfdfdf",
    "email": "rickard@supsssssssss.com",
    "created_at": "2015-06-19T20:46:47.041Z"
  },
  {
    "user_name": "dsfasdf",
    "first_name": "rsdffdasdf",
    "last_name": "rsfsdfdfdf",
    "email": "whattt@sup.com",
    "created_at": "2015-06-19T15:51:02.488Z"
  }
]
```

Example data failure response:

```json
Response Status Code: 404

{
  "message": "There are no users to display."
}
```

### Get current user info

Access-Token:

Required.

Path:

`GET '/user'`

Example data successful response:

```json

{
  "user_name": "dsfasdf",
  "first_name": "rsdffdasdf",
  "last_name": "rsfsdfdfdf",
  "email": "whattt@sup.com",
  "created_at": "2015-06-19T15:51:02.488Z"
}
```

Example data failure response:

```json
Response Status Code: 404

{
  "message": "There are no users to display."
}
```

### Delete current user

Access-Token:

Required.

Path:

`DELETE '/user'`

Parameters:

| name | type    | description                        |
|------|---------|------------------------------------|
| password | string | user has to supply password |

Example data successful response:

```json
Response Status Code: 200

{ 
  "message": "User has been deleted" 
}
```

Example data failure response:

```json
Response Status Code: 401

{
  "message": "Access Token not found."
}
```

```json
Response Status Code: 401

{
  "message": "Password you supplied is not correct"
}
```


## Posts

### Create post

Access-Token:

Required.

Path: 

`POST '/posts/new'`

Parameters

| name      | type   | description                            |
|-----------|--------|----------------------------------------|
| image_url | string | url for the image of the post          |
| answer    | string | answer for the post                    |

Example data successful response:

```json
Response Status Code: 201

{
  "id": 9,
  "post_info": {
    "image_url": "http://hello.com",
    "answer": "hello",
    "created_at": "2015-06-19T12:47:38.064Z",
    "updated_at": "2015-06-19T12:47:38.064Z"
  },
  "creator": {
    "user_name": "rick",
    "first_name": "Rick",
    "last_name": "Sun",
    "email": "rick@sunden.com"
  }
}
```

Example data failure response:

```json
Response Status Code: TBD

{
  "errors": [
    "Answer can't be blank",
    "Image url can't be blank"
  ]
}
```

### Show a specific post of the current user

Access-Token:

Required.

Path:

`GET '/post/:id'`

Example data successful response:

```json
Response Status Code: 200

{
  "id": 9,
  "post_info": {
    "image_url": "http://hello.com",
    "answer": "hello",
    "created_at": "2015-06-19T12:47:38.064Z",
    "updated_at": "2015-06-19T12:47:38.064Z"
  },
  "creator": {
    "user_name": "rick",
    "first_name": "Rick",
    "last_name": "Sun",
    "email": "rick@sunden.com"
  }
}
```

Example data failure response:

```json
Response Status Code: TBD

{
  "message": "This user does not have a post with that ID."
}
```

### List all of posts from current user

Access-Token:

Required.

Path: 

`GET '/posts/user'`

Parameters:

| name | type    | description                        |
|------|---------|------------------------------------|
| page | integer | defaults to 1, 25 results per page |

Example data successful response:

```json
Response Status Code: 200

[
  {
    "id": 10,
    "post_info": {
      "image_url": "http://google.com/image.jpg",
      "created_at": "2015-06-19T14:03:28.790Z"
    },
    "creator": {
      "user_name": "rick",
      "first_name": "Rick",
      "last_name": "Sun",
      "email": "rick@sunden.com"
    }
  },
  {
    "id": 9,
    "post_info": {
      "image_url": "http://hello.com",
      "created_at": "2015-06-19T12:47:38.064Z"
    },
    "creator": {
      "user_name": "rick",
      "first_name": "Rick",
      "last_name": "Sun",
      "email": "rick@sunden.com"
    }
  }
]
```

Example data failure response:

```json
Response Status Code: TBD

{
  "message": "This user does not have any posts."
}
```

### List all of posts made by the current user that have not been solved

Access-Token:

Required.

Path: 

`GET '/posts/user/notsolved'`

Parameters:

| name | type    | description                        |
|------|---------|------------------------------------|
| page | integer | defaults to 1, 25 results per page |

Example data successful response:

```json
Response Status Code: 200

[
  {
    "id": 10,
    "post_info": {
      "image_url": "http://google.com/image.jpg",
      "created_at": "2015-06-19T14:03:28.790Z"
    },
    "creator": {
      "user_name": "rick",
      "first_name": "Rick",
      "last_name": "Sun",
      "email": "rick@sunden.com"
    }
  },
  {
    "id": 9,
    "post_info": {
      "image_url": "http://hello.com",
      "created_at": "2015-06-19T12:47:38.064Z"
    },
    "creator": {
      "user_name": "rick",
      "first_name": "Rick",
      "last_name": "Sun",
      "email": "rick@sunden.com"
    }
  }
]
```

Example data failure response:

```json
Response Status Code: TBD

{
  "message": "This user does not have any posts."
}
```

### List all of posts made by the current user that have been solved

Access-Token:

Required.

Path: 

`GET '/posts/user/solved'`

Parameters:

| name | type    | description                        |
|------|---------|------------------------------------|
| page | integer | defaults to 1, 25 results per page |

Example data successful response:

```json
Response Status Code: 200

[
  {
    "id": 10,
    "post_info": {
      "image_url": "http://google.com/image.jpg",
      "created_at": "2015-06-19T14:03:28.790Z"
    },
    "creator": {
      "user_name": "rick",
      "first_name": "Rick",
      "last_name": "Sun",
      "email": "rick@sunden.com"
    }
  },
  {
    "id": 9,
    "post_info": {
      "image_url": "http://hello.com",
      "created_at": "2015-06-19T12:47:38.064Z"
    },
    "creator": {
      "user_name": "rick",
      "first_name": "Rick",
      "last_name": "Sun",
      "email": "rick@sunden.com"
    }
  }
]
```

Example data failure response:

```json
Response Status Code: TBD

{
  "message": "This user does not have any posts."
}
```

### Lists of posts from all users

Access-Token:

Not required.

Path:

`GET '/posts/all'`

Parameters:

| name | type    | description                        |
|------|---------|------------------------------------|
| page | integer | defaults to 1, 25 results per page |

Example data successful response:

```json
Response Status Code: 200

[
  {
    "id": 33,
    "post_info": {
      "image_url": "http://waat.com/image.jprg",
      "answer": "hello",
      "created_at": "2015-06-19T12:47:38.064Z",
      "updated_at": "2015-06-19T12:47:38.064Z"
    },
    "creator": {
      "user_name": "Hey",
      "first_name": "John",
      "last_name": "What",
      "email": "john@gmail.com"
    }
  },
  {
    "id": 22,
    "post_info": {
      "image_url": "http://google.com/image.jpg",
      "answer": "answer",
      "created_at": "2015-06-19T14:03:28.790Z",
      "updated_at": "2015-06-19T14:03:28.790Z"
    },
    "creator": {
      "user_name": "Mate",
      "first_name": "Jason",
      "last_name": "Derulo",
      "email": "wut@wut.com"
    }
  }
]
```

Example data failure response:

```json
Response Status Code: TBD

{
  "message": "There are no posts."
}
```

### Lists of posts that the current user can play

Access-Token:

Required.

Path:

`GET '/posts/all/playable'`

Parameters:

| name | type    | description                        |
|------|---------|------------------------------------|
| page | integer | defaults to 1, 25 results per page |

Example data successful response:

```json
Response Status Code: 200

[
  {
    "id": 33,
    "post_info": {
      "image_url": "http://waat.com/image.jprg",
      "answer": "hello",
      "created_at": "2015-06-19T12:47:38.064Z",
      "updated_at": "2015-06-19T12:47:38.064Z"
    },
    "creator": {
      "user_name": "Hey",
      "first_name": "John",
      "last_name": "What",
      "email": "john@gmail.com"
    }
  },
  {
    "id": 22,
    "post_info": {
      "image_url": "http://google.com/image.jpg",
      "answer": "answer",
      "created_at": "2015-06-19T14:03:28.790Z",
      "updated_at": "2015-06-19T14:03:28.790Z"
    },
    "creator": {
      "user_name": "Mate",
      "first_name": "Jason",
      "last_name": "Derulo",
      "email": "wut@wut.com"
    }
  }
]
```

Example data failure response:

```json
Response Status Code: TBD

{
  "message": "There are no posts."
}
```

### Lists of posts that the current user cannot play

Access-Token:

Required.

Path:

`GET '/posts/all/unplayable'`

Parameters:

| name | type    | description                        |
|------|---------|------------------------------------|
| page | integer | defaults to 1, 25 results per page |

Example data successful response:

```json
Response Status Code: 200

[
  {
    "id": 33,
    "post_info": {
      "image_url": "http://waat.com/image.jprg",
      "answer": "hello",
      "created_at": "2015-06-19T12:47:38.064Z",
      "updated_at": "2015-06-19T12:47:38.064Z"
    },
    "creator": {
      "user_name": "Hey",
      "first_name": "John",
      "last_name": "What",
      "email": "john@gmail.com"
    }
  },
  {
    "id": 22,
    "post_info": {
      "image_url": "http://google.com/image.jpg",
      "answer": "answer",
      "created_at": "2015-06-19T14:03:28.790Z",
      "updated_at": "2015-06-19T14:03:28.790Z"
    },
    "creator": {
      "user_name": "Mate",
      "first_name": "Jason",
      "last_name": "Derulo",
      "email": "wut@wut.com"
    }
  }
]
```

Example data failure response:

```json
Response Status Code: TBD

{
  "message": "There are no posts."
}
```

## Guesses

### User can guess

Posting to this path will get a response back with information including whether the current user has won with their guess. It will also prevent users from making the same guess twice and a user will not be able to guess on a post that has already been solved by ANYONE else. Check the error messages example.

Access-Token:

Required.

Path: 

`POST '/guesses'`

Parameters:

| name  | type   | description                            |
|-------|--------|----------------------------------------|
| post_id | integer | id of the post the user is making a guess on |
| guess | string | guess on the post                      |

Example data successful response:

```json
Response Status Code: 201

{
  "id": 30,
  "guess_info": {
    "guess": "money",
    "won": false,
    "number_of_guesses": 17,
    "points": null,
    "created_at": "2015-06-20T22:12:27.189Z"
  },
  "guesser": {
    "user_name": "sherri01",
    "first_name": "new",
    "last_name": "mitch",
    "email": "sherri@sherri01.com"
  },
  "post": {
    "image_url": "https://rocktransformed.s3.amazonaws.com/testImage..."
  }
}
```

Example data failure response:

```json
Response Status Code: TBD

{ 
  "message": "You cannot make a guess! You're too slow" 
}

Response Status Code: TBD
{ 
  "message": "You cannot make a guess on your own post. You are a cheater!" 
}
```

## Scoreboard

### Get top 10 users for all time

Access-Token:

Not required.

Path: 

`GET '/topscores'`

Parameters:

| name | type    | description                        |
|------|---------|------------------------------------|
| page | integer | defaults to 1, 10 results per page |

Example data successful response:

```json
Response Status Code: 200

[
{
  "user_name": "whatever",
  "score": 20
}
{
  "user_name": "anotheruser",
  "score": 40
}
]
```

Example data failure response:

```json
Response Status Code: TBD

{
  "message": "Sorry no scores to display."
}
```

### Get total score for a user

Access-Token:

Required.

Path: 

`GET '/user/score'`

Example data successful response:

```json
Response Status Code: 200

{
  "user_name": "whatever",
  "score": 20
}
```