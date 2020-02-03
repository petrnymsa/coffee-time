# API 

- CoffeeApi is hosted as firebase cloud functions 
- Internally for each requests will call Google API to obtain required data.
- After required data are obtained additional metadata (currently only place `tags`) are added to response.

- [API](#api)
  - [:world_map: Google API](#world_map-google-api)
    - [Find place](#find-place)
    - [Nearby search](#nearby-search)
    - [Place details](#place-details)
      - [Response](#response)
    - [Place photos](#place-photos)
      - [Response](#response-1)
  - [CoffeeApi](#coffeeapi)
    - [Places](#places)
    - [Tags](#tags)

## :world_map: Google API

Legend:

* :heavy_check_mark: required from client 
* :question: optional from client

* **bold** - required by Google API

### [Find place](https://developers.google.com/places/web-service/search#FindPlaceRequests)

```
https://maps.googleapis.com/maps/api/place/findplacefromtext/output?parameters
```

Parameters: 
* **key** - API key
* **input** - search input :heavy_check_mark:
* **inputtype** - always set to `textquery`
* *language* - language code. :question:
* *locationbias* - set to circle:radius@lat,lng. Lat, lng will come from client :question: 
* *fields* - see table below

| Field             | Note                    |
| ----------------- | ----------------------- |
| name              |                         |
| icon              |                         |
| formatted_address |                         |
| place_id          |                         |
| types             |                         |
| photos            |                         |
| opening_hours     | Returns only `open_now` |
| price_level       |                         |
| rating            | From 1.0 to 5.0         |

### [Nearby search](https://developers.google.com/places/web-service/search#PlaceSearchRequests)
```
https://maps.googleapis.com/maps/api/place/nearbysearch/output?parameters
```

Parameters: 
* **key** - API key
* **location** - latitude,longtitude :heavy_check_mark:
* **radius** - radius ( in meters ), max 50 000m :heavy_check_mark:
* *language* - language code. :question:
* *opennow* - if place does not have opening_hours, place is not returned. :question:
* *type* - type - should be always 'cafe'
* *pagetoken* - :question: 


### [Place details](https://developers.google.com/places/web-service/details)

```
https://maps.googleapis.com/maps/api/place/details/output?parameters
```

Parameters: 
* **key** - API key
* **place_id** :heavy_check_mark:
* *language* - language code. :question:
* *fields* 

| Field                      | Note |
| -------------------------- | ---- |
| url                        |      |
| photos                     |      |
| utc_offset                 |      |
| international_phone_number |      |
| opening_hours              |      |
| website                    |      |
| review                     |      |

:bookmark_tabs: Note about `opening_hours`. If `language` is provided, the `weekday_text` is properly formatted. However for custom formatting, the `periods[]` will be used. 

:warning: Be aware that if place is **always open**, the `close` section is missing and `open` section will have `day` == 0 and `time` == '0000'.


#### Response
* *Status*
* *result*


### [Place photos](https://developers.google.com/places/web-service/photos)
Find place and Nearby search will return at most one `photo` 

Place details returns up to ten `photo` elements.


```
https://maps.googleapis.com/maps/api/place/photo?parameters
```

Parameters: 
* **key** - API key
* **photoreference** :heavy_check_mark:
* **maxheight**, **maxwidth** :question:

#### Response
Image otherwise `HTTTP 403` when quota exceeded status is returned or `HTTP 400`. 


## CoffeeApi

Coffee API is divided to two parts - `Places` and `Tags`.

### Places

Each (besides /photo) place request has to start with `language` code. 

| Uri                             | Method | What                             | Application relevance            |
| ------------------------------- | ------ | -------------------------------- | -------------------------------- |
| /\<language\>/nearby?parameters | GET    | Nearby cafes                     | Cafe list                        |
| /\<language\>/find?parameters   | GET    | Cafes within area based on query | Cafe list                        |
| /\<language\>/detail/<place_id> | GET    | Place's details.                 | Detail page                      |
| /photo/<photo_reference>        | GET    | Photo                            | Cafe tile / Detail page carousel |

### Tags

| Uri              | Method | What                              | Application relevance                         |
| ---------------- | ------ | --------------------------------- | --------------------------------------------- |
| /tags            | GET    | All available tags                | At startup                                    |
| /tags/<place_id> | GET    | Get tags for given <place_id>     | After user submitted `tags review` :question: |
| /tags/<place_id> | POST   | Updates tags for given <place_id> | When user submits `tags review`               |
