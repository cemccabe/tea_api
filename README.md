<a name="readme-top"></a>

# <p align="center"> Tea Subscription API </p>

## About Tea Subscription API

Tea Subscription API is a backend API that provides tea subscription services, including CRUD functionality for tea subscriptions, teas, and customers. This API was built using Ruby on Rails and PostgreSQL. This API was built as a solo project for Turing School of Software and Design's Back End Engineering program. The project spec can be found [here](https://mod4.turing.edu/projects/take_home/take_home_be).

#### Learning Goals/Project Requirements

* A strong understanding of Rails
* Ability to create restful routes
* Demonstration of well-organized code, following OOP
* Test Driven Development
* Clear documentation

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Getting Started

### Prerequisites

* Ruby 2.7.4
* Rails 5.2.8

### Installation

1. Clone the repo
   ```shell
   git clone git@github.com:cemccabe/tea_api.git
   ```
1. Install gems
   ```shell
   bundle install
   ```
1. Setup db
   ```shell
   rails db:{drop,create,migrate}
   ```
1. Run RSpec test suite
    ```shell
    bundle exec rspec
    ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Usage

### Database Schema

<img width="1076" alt="Database Schema" src="https://user-images.githubusercontent.com/46434166/233565871-719fbe2a-b3a9-415e-820e-ae335221c235.png">

### RESTful Endpoints

<details close>

* Root directory
  * `localhost:3000`

#### Create a Customer

```http
POST /api/v1/customers
```

<details close>
<summary> Details </summary>
<br>

Headers:<br>
```http
{ "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
```

Body:<br>
```http
{ 
  first_name: "FIRST NAME",
  last_name: "LAST NAME",
  email: "EMAIL",
  address: "ADDRESS"
}
```

Response:
```json
{
  "data": {
    "id": "14",
    "type": "customer",
    "attributes": {
      "first_name": "FIRST NAME",
      "last_name": "LAST NAME",
      "email": "EMAIL",
      "address": "ADDRESS"
    }
  }
}
```

</details>

---

#### Create a Tea

```http
POST /api/v1/teas
```

<details close>
<summary> Details </summary>
<br>

Headers:<br>
```http
{ "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
```

Body:<br>
```http
{ 
  title: "TEA TITLE",
  description: "DESCRIPTION",
  temperature: 120.5,
  brew_time: 15
}
```

Response:
```json
{
  "data": {
    "id": "51",
    "type": "tea",
    "attributes": {
      "title": "TEA TITLE",
      "description": "DESCRIPTION",
      "temperature": 120.5,
      "brew_time": 15
    }
  }
}
```

</details>

---

#### Create a Subscription

```http
POST /api/v1/subscriptions
```

<details close>
<summary> Details </summary>
<br>

Headers:<br>
```http
{ "CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
```

Body:<br>
```http
{ 
  title: "SUBSCRIPTION TITLE",
  price: 20.25,
  status: 1,
  frequency: 2,
  tea_id: 1,
  customer_id: 1
}
```

Note: `status` and `frequency` are enums. `status` can be either `inactive` or `active` and is denoted by a `0` or `1`, respectively. `frequency` can be either `weekly`, `monthly`, or `yearly` and is denoted by a `0`, `1`, or `2`, respectively.

Response:
```json
{
  "data": {
    "id": "31",
    "type": "subscription",
    "attributes": {
      "title": "SUBSCRIPTION TITLE",
      "price": 20.25,
      "status": "active",
      "frequency": "yearly",
      "tea_id": 1,
      "customer_id": 1
    }
  }
}
```

</details>

---

#### Update a Subscription

```http
PATCH /api/v1/subscriptions/<SUBSCRIPTION ID>
```

<details close>
<summary> Details </summary>
<br>

Headers:<br>
```http
{ "CONTENT_TYPE" => "application/json" }
```

Body:<br>
```http
{ 
  status: 0
}
```

Note: `status` is an enum. `status` can be either `inactive` or `active` and is denoted by a `0` or `1`, respectively. `status` is inactive by default.

Response:
```json
{
  "data": {
    "id": "1",
    "type": "subscription",
    "attributes": {
      "title": "Atlanta Hawks",
      "price": 12.84,
      "status": "inactive",
      "frequency": "monthly",
      "tea_id": 3,
      "customer_id": 1
    }
  }
}
```

</details>

---

#### Get a Customer's Subscriptions

```http
GET /api/v1/customers/<CUSTOMER ID>/subcriptions
```

<details close>
<summary> Details </summary>
<br>

Response:
```json
{
  "data": [
    {
      "id": "1",
      "type": "subscription",
      "attributes": {
        "title": "Atlanta Hawks",
        "price": 12.84,
        "status": "active",
        "frequency": "monthly",
        "tea_id": 3,
        "customer_id": 1
        }
    },
    {
      "id": "5",
      "type": "subscription",
      "attributes": {
        "title": "Milwaukee Bucks",
        "price": 26.82,
        "status": "inactive",
        "frequency": "monthly",
        "tea_id": 50,
        "customer_id": 1
        }
    },
    {...}
  ]
}
```

</details>
</details>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Developers

<div align="left">
  <img src="https://avatars.githubusercontent.com/u/46434166?v=4" alt="Profile" width="80" height="80">
  <p align="left">
    Christian McCabe<br>
    <a href="https://github.com/cemccabe">Github: cemccabe</a>
  </p>
</div>

<p align="right">(<a href="#readme-top">back to top</a>)</p>
