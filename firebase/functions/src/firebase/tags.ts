import { TagReputation, TagUpdate, TagChange } from "../models/tag";
const FieldValue = require('firebase-admin').firestore.FieldValue;

export class TagsRepository {
    constructor(private db: FirebaseFirestore.Firestore) { }

    /**
     * @returns All existing tags
     */
    async all(): Promise<FirebaseFirestore.DocumentData[]> {
        const snapshot = await this.db.collection('tags').get();

        return snapshot.docs.map((doc) => {
            const data = doc.data();
            return data;
        });
    }

    /**
     * @param placeId place_id obtained from Google Places API search
     * @returns All asocitaed tags with given placeId
     */
    async getByPlaceId(placeId: string): Promise<TagReputation[]> {
        const cafeRef = this.db.collection('cafeTags').doc(placeId);

        const tags = await cafeRef.collection('tags').get();

        return tags.docs.map((doc) => {
            const data = doc.data();

            return new TagReputation(doc.id, data.likes, data.dislikes);
        });
    }

    /**
     * Updates given tags at place identified by placeId
     * @param placeId place_id obtained from Google Places API search
     * @param tags All updated tags
     */
    async updateTags(placeId: string, tags: TagUpdate[]) {
        const cafeRef = this.db.collection('cafeTags').doc(placeId);

        return Promise.all(tags.map((tag) => {
            const docRef = cafeRef.collection('tags').doc(tag.id);

            if (tag.change === TagChange.like) {
                const inc = FieldValue.increment(1);
                return docRef.set({
                    likes: inc
                }, { merge: true });
            } else {
                return docRef.set({
                    dislikes: FieldValue.increment(1)
                }, { merge: true });
            }
        }));
    }
}