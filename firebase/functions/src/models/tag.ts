/**
 * Represents basic Tag structure
 */
export class Tag {
    constructor(
        public id: string,
        public title: string,
        public icon: string) { }
}

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
export class TagUpdate {
    constructor(
        public id: string,
        public change: TagChange
    ) { }
}