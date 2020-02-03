import { Tag, TagReputation, TagUpdate, TagChange } from "../models/tag";
const FieldValue = require('firebase-admin').firestore.FieldValue;
//todo documentation


export class TagsRepository {
    constructor(private db: FirebaseFirestore.Firestore) { }

    async all(): Promise<Tag[]> {
        const snapshot = await this.db.collection('tags').get();

        return snapshot.docs.map((doc) => {
            const data = doc.data();
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