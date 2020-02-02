import * as rp from 'request-promise-native';
import { stringify as queryString } from 'querystring';

//todo documentation
export class ValidationError extends Error {
    constructor(message: string) {
        super(message);
    }
}

const nearbyBaseUri = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';
const findPlaceBaseUri = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?';
const detailBaseUri = 'https://maps.googleapis.com/maps/api/place/details/json?';
const photoBaseUri = 'https://maps.googleapis.com/maps/api/place/photo?'

async function getResponse(url: string): Promise<any> {
    const options = {
        uri: url,
        method: 'GET',
        json: true
    };

    return await rp(options);
}

export async function getNearby(language: string, location: string, radius: string, openNow?: boolean, pageToken?: string): Promise<any> {
    const params = {
        type: 'cafe',
        language: language,
        location: location,
        radius: radius,
        opennow: openNow,
        pagetoken: pageToken,
        key: process.env.API_KEY
    }

    const url = nearbyBaseUri + queryString(params);
    return getResponse(url);
}

export async function findPlaces(input: string, language: string, location?: string, radius?: string): Promise<any> {
    const params = {
        input: encodeURIComponent(input),
        inputtype: 'textquery',
        language: language,
        fields: 'name,icon,formatted_address,place_id,types,photos,opening_hours,price_level,rating',
        key: process.env.API_KEY,
        locationBias: '',
    }

    if (location && radius) {
        params.locationBias = `circle:${radius}@${location}`;
    }
    const url = findPlaceBaseUri + queryString(params);
    return getResponse(url);
}

export async function getPlaceDetail(placeId: string, language: string) {
    const params = {
        place_id: placeId,
        language: language,
        fields: 'url,photos,utc_offset,international_phone_number,formatted_phone_number,opening_hours,website,review',
        key: process.env.API_KEY
    }

    const url = detailBaseUri + queryString(params);

    return getResponse(url);
}

export async function getPhoto(photoId: string, maxHeight?: number, maxWidth?: number) {
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
        maxHeight: maxHeight,
        photoreference: photoId,
        key: process.env.API_KEY
    };

    const url = photoBaseUri + queryString(params);

    const options = {
        uri: url,
        method: 'GET',
        resolveWithFullResponse: true,
        encoding: null
    };
    return rp(options);
}