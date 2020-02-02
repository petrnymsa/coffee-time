import { Router } from 'express';
import * as google from '../google';
import { logRequestError } from '../logger';
import { TagsRepository } from '../firebase/tags';

//todo documentation

export const places = (tagsRepository: TagsRepository): Router => {

    const router = Router();
    /**
     * Required params: 
     * - location
     * - radius
     * Optional params: 
     * - opennow
     * - pagetoken
     */
    router.get('/nearby', async (req, res) => {
        if (!req.query.location) {
            res.status(400)
            res.send('location parameter is missing');
            return;
        }

        if (!req.query.radius) {
            res.status(400)
            res.send('radius parameter is missing');
            return;
        }

        try {
            const language = req.language;
            const location = req.query.location;
            const radius = req.query.radius;
            const opennow = req.query.opennow;
            const pagetoken = req.query.pagetoken;

            let places = await google.getNearby(language, location, radius, opennow, pagetoken);

            if (places.status === 'OK') {
                for (let place of places.results) {
                    const tags = await tagsRepository.getByPlaceId(place.place_id);
                    place.tags = tags;
                }
            }

            res.send(places);
        }
        catch (err) {
            logRequestError(req, err);
            res.status(500);
            res.send(err.message);
        }
    });

    /**
     * Required params:
     * - input
     * Optional params:
     * - location and radius
     */
    router.get('/find', async (req, res) => {
        if (!req.query.input) {
            res.status(400)
            res.send('input parameter is missing');
            return;
        }

        try {
            const input = req.query.input;
            const language = req.language;
            const location = req.query.location;
            const radius = req.query.radius;

            let places = await google.findPlaces(input, language, location, radius);

            if (places.status === 'OK') {
                for (let place of places.candidates) {
                    const tags = await tagsRepository.getByPlaceId(place.place_id);
                    place.tags = tags;
                }
            }

            res.send(places);
        }
        catch (err) {
            logRequestError(req, err);
            res.status(500);
            res.send(err.message);
        }
    });

    /**
     * Required params:
     * - place_id
     */
    router.get('/detail/:id', async (req, res) => {
        try {
            const detail = await google.getPlaceDetail(req.params.id, req.language);
            res.send(detail);
        }
        catch (err) {
            logRequestError(req, err);
            res.status(500);
            res.send(err.message);
        }
    });

    return router;
}