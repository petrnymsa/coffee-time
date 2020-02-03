import { Request } from 'express';

/**
 * Log given Error along with request.Url
 * @param req Current request
 * @param err Error to log
 */
export const logRequestError = (req: Request, err: Error) => {
    console.error(`${req.originalUrl}|${req.method}|${err.message}`);
}
/**
 * Log given error
 * @param err Error
 */
export const logError = (err: Error) => {
    console.error(err.message);
}
/**
 * Log given message as info
 * @param msg Message to log
 */
export const logInfo = (msg: string) => {
    console.info(msg);
}