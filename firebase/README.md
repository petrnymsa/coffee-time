# :bulb: Setup

:exclamation: Make sure you have setup `firebase cli` correctly. 

Create `.env` file within `functions` folder.

```
API_KEY=<google api key>
GOOGLE_APPLICATION_CREDENTIALS=<path to google service json config>
```

:warning: Note that `GOOGLE_APPLICATION_CREDENTIALS` is relative to **src** folder.

Within functions folder
```
npm install
```

## :hammer_and_wrench: Build and run locally

Within functions folder

```
npm run start
```

## :bookmark: Upload prepared tags 
If you want upload prepared tags within functions folder run
```
npm run upload-tags
```

## :rocket: Deploy time
Within functions folder

```
npm run deploy
```