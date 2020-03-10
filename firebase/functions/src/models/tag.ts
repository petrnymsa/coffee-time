/**
 * Asociated tag with place. 
 * Contains information about likes and dislikes and computed score.
 */
export class TagReputation {

    public score: number;

    constructor(
        public id: string,
        public likes: number,
        public dislikes: number) {
        this.score = likes - dislikes;
    }

    toUpdateMap(): object {
        return {
            "likes": this.likes,
            "dislikes": this.dislikes
        }
    }
}

/**
 * Represents tag update - like or dislike
 */
export enum TagChange {
    like = 'like',
    dislike = 'dislike'
}

/**
 * Represents concrete tag update. 
 */
export interface TagUpdate {
    id: string,
    change: TagChange
}