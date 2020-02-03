import { Router } from 'express';
import { logRequestError } from '../logger';
import { TagsRepository } from '../firebase/tags';
import { TagUpdate } from '../models/tag';

export const tagsRoute = (tagsRepository: TagsRepository): Router => {

    const router = Router();

    router.get('/', async (req, res) => {
        try {
            const tags = await tagsRepository.all();
            res.json(tags);
        }
        catch (err) {
            logRequestError(req, err);
            res.status(500).json(err.message);
        }
    });

    router.get('/:placeId', async (req, res) => {
        try {
            const tags = await tagsRepository.getByPlaceId(req.params.placeId);
            res.json(tags)
        }
        catch (err) {
            logRequestError(req, err);
            res.status(500);
            res.json(err.message);
        }

    });

    router.post('/:placeId', async (req, res) => {
        const data: TagUpdate[] = req.body;
        const updates = data.map((d) => {

            if (d.change !== 'like' && d.change !== 'dislike') {
                res.status(400).json(`Provided tag update: ${d.id},${d.change} does not have valid change value.`);
            }

            return new TagUpdate(d.id, d.change);
        });
        try {
            await tagsRepository.updateTags(req.params.placeId, updates);
            res.status(204).end();
        } catch (err) {
            logRequestError(req, err);
            res.status(500).json(err.message);
        }
    });

    return router;
}