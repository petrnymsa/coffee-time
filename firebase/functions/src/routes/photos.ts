import { Router } from 'express';
import * as google from '../google';
import { logRequestError } from '../logger';

export const photosRoute = (): Router => {
    const router = Router();
    /**
     * Required params:
     * - id - photo reference
     */
    router.get('/:id', async (req, res) => {
        try {
            const maxHeight = req.query.maxheight;
            const maxWidth = req.query.maxwidth;

            const response = await google.getPhoto(req.params.id, maxHeight, maxWidth);
            const photo = Buffer.from(response.body, 'base64');

            res.header(response.headers);
            res.send(photo);
        }
        catch (err) {
            logRequestError(req, err);
            if (err instanceof google.ValidationError) {
                res.status(400);
                res.json(err.message);
            } else {
                if (err.statusCode < 500) {
                    res.status(err.statusCode);
                    const msg = {
                        'error': 'Bad usage. Check photoreference.',
                        'internal': err
                    };
                    res.json(msg);
                } else {
                    res.status(500).json(err);
                }
            }
        }
    });

    return router;
};
