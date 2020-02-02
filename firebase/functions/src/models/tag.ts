//todo documentation

export class Tag {
    constructor(
        public id: string,
        public title: string,
        public icon: string) { }
}

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