import * as fs from 'fs';
import { db } from '../firebase/connection';
const path = require("path");

async function exec() {
    try {
        const fPath = path.resolve(__dirname, "../assets/tags.json");
        const content = fs.readFileSync(fPath, 'utf8');
        const data: any[] = JSON.parse(content);

        const batch = db.batch();

        let i = 1;
        const count = data.length;

        data.forEach((d) => {
            const ref = db.collection('tags').doc(d.id);

            delete d.id;

            batch.set(ref, d, { merge: true });
            console.log(`Processed ${i}\\${count}`);
            i++;
        });

        console.log('Committing changes');
        await batch.commit();
        console.log('Done');

    } catch (err) {
        console.error(err);
    }
}

// tslint:disable-next-line: no-floating-promises
exec();