import { Tag, TagReputation } from "../models/tag";

//todo documentation

export class NotFound extends Error {
    constructor(message: string) {
        super(message);
    }
}

export class TagsRepository {
    constructor(private db: FirebaseFirestore.Firestore) { }

    async all(): Promise<Tag[]> {
        const snapshot = await this.db.collection('tags').get();

        return snapshot.docs.map((doc) => {
            const data = doc.data();
            console.log(data);
            return new Tag(doc.id, data.title, data.icon);
        });
    }

    async getByPlaceId(placeId: string): Promise<TagReputation[]> {
        const cafeRef = this.db.collection('cafeTags').doc(placeId);

        const tags = await cafeRef.collection('tags').get();

        return tags.docs.map((doc) => {
            const data = doc.data();

            return new TagReputation(doc.id, data.likes, data.dislikes);
        });
    }

    async updateTags(placeId: string, tags: TagReputation[]) {
        const cafeRef = this.db.collection('cafeTags').doc(placeId);

        return Promise.all(tags.map((tag) => {
            const map = tag.toUpdateMap();
            return cafeRef.collection('tags').doc(tag.id).set(map, { merge: true });
        }));
    }
}