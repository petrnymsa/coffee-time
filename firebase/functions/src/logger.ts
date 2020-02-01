import { Request } from 'express';

export const logRequestError = (req: Request, err: Error) => {
    console.error(`${req.originalUrl}|${req.method}|${err.message}`);
}

export const logError = (err: Error) => {
    console.error(err.message);
}