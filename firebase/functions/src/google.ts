import * as rp from 'request-promise-native';
import { stringify as queryString } from 'querystring';
import { logInfo } from './logger';

export class ValidationError extends Error {
    constructor(message: string) {
        super(message);
    }
}

const nearbyBaseUri = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';
const findPlaceBaseUri = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?';
const detailBaseUri = 'https://maps.googleapis.com/maps/api/place/details/json?';
const photoBaseUri = 'https://maps.googleapis.com/maps/api/place/photo?'

// call given url - expect GET endpoint, with json
async function getResponse(url: string): Promise<any> {
    const options = {
        uri: url,
        method: 'GET',
        json: true
    };

    return rp(options);
}

/**
 * Search neraby cafes base on location and radius.  
 * @param language Language to use
 * @param location Search at given location
 * @param radius Circular radius in meters
 * @param openNow [optional] Return place only if is currently open
 * @param pageToken [optional] If provided returns next page. Other parameters are ignored. 
 */
export async function getNearby(language: string, location: string, radius: string, openNow?: string, pageToken?: string): Promise<any> {
    const params: any = {
        type: 'cafe',
        language: language,
        location: location,
        radius: radius,
        key: process.env.API_KEY
    }
    if (openNow || openNow === '') {
        params.opennow = openNow;
    }

    if (pageToken) {
        params.pagetoken = pageToken;
    }

    const url = nearbyBaseUri + queryString(params);
    logInfo(`getNearby: ${url}`);
    return getResponse(url);
}
/**
 * Search places based on user text query
 * @param input Text input to search
 * @param language Language to use
 * @param location [optional] If provided, circular locaitonbias is used at given location
 * @param radius [optional] Must be provided together with location. Circular radius in meters
 */
export async function findPlaces(input: string, language: string, location?: string, radius?: string): Promise<any> {
    const params: any = {
        input: encodeURIComponent(input),
        inputtype: 'textquery',
        language: language,
        fields: 'name,icon,formatted_address,place_id,types,photos,opening_hours,price_level,rating,geometry',
        key: process.env.API_KEY,
    }

    if (location && radius) {
        params.locationbias = `circle:${radius}@${location}`;
    }
    const url = findPlaceBaseUri + queryString(params);
    logInfo(`findPlaces: ${url}`);
    return getResponse(url);
}
/**
 * Returns place details
 * @param placeId Obtained place_id from google api
 * @param language Language to use
 */
export async function getPlaceDetail(placeId: string, language: string): Promise<any> {
    const params = {
        place_id: placeId,
        language: language,
        fields: 'url,photos,utc_offset,international_phone_number,formatted_phone_number,opening_hours,website,review',
        key: process.env.API_KEY
    }

    const url = detailBaseUri + queryString(params);
    logInfo(`getPlaceDetail: ${url}`);
    return getResponse(url);
}
/**
 * 
 * @param photoId photoreference obtained from google api
 * @param maxHeight Max height which photo should have. Value must be at interval [1, 1600]
 * @param maxWidth Max width which photo should have. Value must be at interval [1, 1600]
 */
export async function getPhoto(photoId: string, maxHeight?: number, maxWidth?: number): Promise<any> {
    if (!maxHeight && !maxWidth) {
        throw new ValidationError('Either maxheight or maxwidth must be provided');
    }

    if (maxHeight && (maxHeight < 0 || maxHeight > 1600)) {
        throw new ValidationError('maxheight value must be between 1 to 1600');
    }

    if (maxWidth && (maxWidth < 0 || maxWidth > 1600)) {
        throw new ValidationError('maxwidth value must be between 1 to 1600');
    }

    const params = {
        maxwidth: maxWidth,
        maxheight: maxHeight,
        photoreference: photoId,
        key: process.env.API_KEY
    };

    const url = photoBaseUri + queryString(params);
    logInfo(`getPhoto: ${url}`);
    const options = {
        uri: url,
        method: 'GET',
        resolveWithFullResponse: true,
        encoding: null
    };
    return rp(options);
}