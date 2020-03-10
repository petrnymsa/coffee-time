# API 

- CoffeeApi is hosted as firebase cloud functions. 
- Internally for each *place* request is called Google API to obtain required data.
- After required data are obtained additional metadata (currently only place `tags`) are added to response.

- [API](#api)
  - [:coffee: CoffeeApi](#coffee-coffeeapi)
    - [Places](#places)
      - [/\<language\>/nearby?parameters](#languagenearbyparameters)
      - [/\<language\>/find?parameters](#languagefindparameters)
    - [Photo](#photo)
    - [Tags](#tags)
      - [GET Response](#get-response)
    - [POST /tags/<place_id>](#post-tagsplaceid)
  - [Place responses](#place-responses)
  - [:world_map: Google API](#worldmap-google-api)
    - [Find place](#find-place)
    - [Nearby search](#nearby-search)
    - [Place details](#place-details)
      - [Response](#response)
        - [Status](#status)
    - [Place photos](#place-photos)
      - [Response](#response-1)

## :coffee: CoffeeApi

Coffee API is REST API used to get near cafest along with tags.

### Places

Each place request has to start with `language` code. 

| Uri                             | Method | What                             |
| ------------------------------- | ------ | -------------------------------- |
| /\<language\>/nearby?parameters | GET    | Nearby cafes                     |
| /\<language\>/find?parameters   | GET    | Cafes within area based on query |
| /\<language\>/detail/<place_id> | GET    | Place's details.                 |

#### /\<language\>/nearby?parameters 
Get nearby cafes. 

Parameters:
- *location=lat,lng* :heavy_check_mark:
- *radius* :heavy_check_mark: Radius in meters. 
- *opennow* Return only if is currently opened.
- *pagetoken* Get next page.

#### /\<language\>/find?parameters 
Cafes within area based on text query. 

Parameters:
- *query* :heavy_check_mark:
- *location=lat,lng* 
- *radius* Radius in meters.

:warning: Location and radius has to be together.

### Photo
| Uri                      | Method | What  |
| ------------------------ | ------ | ----- |
| /photo/<photo_reference> | GET    | Photo |

### Tags

| Uri              | Method | What                              |
| ---------------- | ------ | --------------------------------- |
| /tags            | GET    | All available tags                |
| /tags/<place_id> | GET    | Get tags for given <place_id>     |
| /tags/<place_id> | POST   | Updates tags for given <place_id> |


#### GET Response
Each tag is represnted as follows: 

```json
{
        "title": "accessible",
        "translations": {
            "cs": "bezbariérový přístup"
        },
        "icon": {
            "code": 61843,
            "package": "font_awesome_flutter",
            "family": "FontAwesomeSolid"
        },
        "id": "accessible"
    },
```

Where
- *id* is unique `String` identificator
- *title* is English version
- *icon* is mapped IconData
- *translations* - mapped translations. Optional. 

### POST /tags/<place_id>
 - Expecting array of TagUpdate model.
 - Conent is `application/json`

Each tag update is represented as follows

```json
{
  "id": "tag",
  "change": "like|dislike"
}
```
Change is `string enum` with value 'like' or 'dislike'. 

## Place responses
See [Google API Response](#Response) and described fields. 


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
* *language* - language code. :heavy_check_mark:
* *locationbias* - set to circle:radius@lat,lng. Lat, lng will come from client :question: 
* *fields* - see table below

| Field             | Note                    |
| ----------------- | ----------------------- |
| name              |                         |
| icon              |                         |
| geometry          |                         |
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
* *language* - language code. :heavy_check_mark:
* *opennow* - if place does not have opening_hours, place is not returned. :question:
* *type* - type - always set to 'cafe'
* *pagetoken* - :question: 


### [Place details](https://developers.google.com/places/web-service/details)

```
https://maps.googleapis.com/maps/api/place/details/output?parameters
```

Parameters: 
* **key** - API key
* **place_id** :heavy_check_mark:
* *language* - language code. :heavy_check_mark:
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

:bookmark_tabs: Note about `opening_hours`. If `language` is provided, the `weekday_text` is properly formatted.

:warning: Be aware that if place is **always open**, the `close` section is missing and `open` section will have `day` == 0 and `time` == '0000'.


#### Response

Find, Nearby and Detail has similiar response format: 

```json
{
  "html_attributions": [],
  "status": <status>,
  "result": {}
}
```

Note that *result* field is different for each type:

- Find = "candidates"
- Nearby = "results"
- Detail = "result"

##### Status
Even when bad request is made, api still returns HTTP 200 OK. Current status is stored in *status* field. [source](https://developers.google.com/places/web-service/details#PlaceDetailsStatusCodes)

```
    OK indicates that no errors occurred; the place was successfully detected and at least one result was returned.
    UNKNOWN_ERROR indicates a server-side error; trying again may be successful.
    ZERO_RESULTS indicates that the referenced location (place_id) was valid but no longer refers to a valid result. This may occur if the establishment is no longer in business.
    OVER_QUERY_LIMIT indicates any of the following:
        You have exceeded the QPS limits.
        Billing has not been enabled on your account.
        The monthly $200 credit, or a self-imposed usage cap, has been exceeded.
        The provided method of payment is no longer valid (for example, a credit card has expired).

    See the Maps FAQ for more information about how to resolve this error.
    REQUEST_DENIED indicates that your request was denied, generally because:
        The request is missing an API key.
        The key parameter is invalid.
    INVALID_REQUEST generally indicates that the query (place_id) is missing.
    NOT_FOUND indicates that the referenced location (place_id) was not found in the Places database.
```

### [Place photos](https://developers.google.com/places/web-service/photos)
Find place and Nearby search will return at most one `photo` 

Place details returns up to ten `photo` elements.


```
https://maps.googleapis.com/maps/api/place/photo?parameters
```

Parameters: 
* **key** - API key
* **photoreference** :heavy_check_mark:
* **maxheight**, **maxwidth**  :heavy_check_mark:

#### Response
Byte Image data otherwise `HTTTP 403` when quota exceeded status or `HTTP 400`. 
