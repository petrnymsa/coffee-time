import { Router } from 'express';
import * as google from '../google';
import { logRequestError } from '../logger';
import { TagsRepository } from '../firebase/tags';

export const placesRoute = (tagsRepository: TagsRepository): Router => {
  const router = Router();
  /**
   * Required params:
   * - location
   * Optional params:
   * - opennow
   * - pagetoken
   * - radius
   */
  router.get('/nearby', async (req, res) => {
    if (!req.query.location) {
      res.status(400);
      res.json('location parameter is missing');
    }

    try {
      const language = req.language;
      const location = req.query.location;
      const radius = req.query.radius;
      const opennow = req.query.opennow;
      const pagetoken = req.query.pagetoken;

      const nearbyPlaces = await google.getNearby(
        language,
        location,
        radius,
        opennow,
        pagetoken
      );

      if (nearbyPlaces.status === 'OK') {
        for (const place of nearbyPlaces.results) {
          const tags = await tagsRepository.getByPlaceId(place.place_id);
          place.tags = tags;
        }
      }

      res.json(nearbyPlaces);
    } catch (err) {
      logRequestError(req, err);
      res.status(500).json(err.message);
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
      res.status(400).json('input parameter is missing');
    }

    try {
      const input = req.query.input;
      const language = req.language;
      const location = req.query.location;
      const radius = req.query.radius;

      const foundPlaces = await google.findPlaces(
        input,
        language,
        location,
        radius
      );

      if (foundPlaces.status === 'OK') {
        for (const place of foundPlaces.candidates) {
          const tags = await tagsRepository.getByPlaceId(place.place_id);
          place.tags = tags;
        }
      }

      res.json(foundPlaces);
    } catch (err) {
      logRequestError(req, err);
      res.status(500).json(err.message);
    }
  });

  /**
   * Required params:
   * - place_id
   */
  router.get('/detail/:id', async (req, res) => {
    try {
      const detail = await google.getPlaceDetail(req.params.id, req.language);
      res.json(detail);
    } catch (err) {
      logRequestError(req, err);
      res.status(500).json(err.message);
    }
  });

  return router;
};
