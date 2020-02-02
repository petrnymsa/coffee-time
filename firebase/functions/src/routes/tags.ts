import { Router } from 'express';
import { logRequestError } from '../logger';
import { TagsRepository, NotFound } from '../firebase/tags';
import { TagReputation } from '../models/tag';

//todo document methods

export const tagsRoute = (tagsRepository: TagsRepository): Router => {

    const router = Router();

    router.get('/', async (req, res) => {
        try {
            const tags = await tagsRepository.all();
            res.json(tags);
        }
        catch (err) {
            logRequestError(req, err);
            res.status(500);
            res.send(err.message);
        }
    });

    router.get('/:placeId', async (req, res) => {
        try {
            const tags = await tagsRepository.getByPlaceId(req.params.placeId);
            res.json(tags)
        }
        catch (err) {
            logRequestError(req, err);

            if (err instanceof NotFound) {
                res.status(400);
            } else {
                res.status(500);
            }

            res.send(err.message);
        }

    });

    router.post('/:placeId', async (req, res) => {
        console.log(req.body);
        const data: TagReputation[] = req.body;
        const tags = data.map((d) => new TagReputation(d.id, d.likes, d.dislikes));
        try {
            await tagsRepository.updateTags(req.params.placeId, tags);
            res.status(204);
            res.end();
        } catch (err) {
            logRequestError(req, err);

            res.status(500);
            res.send(err.message);
        }


    });

    return router;
}