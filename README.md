# TsunamiDeal

Link to the platform: https://tsunamideal-singlestoredb.herokuapp.com/

## About
An e-commerce website built using React.js with voice chat and fuzzy search, with real transactions implemented.

Originally implemented in PostgreSQL, this application has been migrated to SingleStore.

## Instructions To Run
The website and the database have been completely hosted online. Use the [link](https://tsunamideal-singlestoredb.herokuapp.com/) to run the application directly on your browser.

To run it locally, follow the steps below:
1. Clone the repository. All deployment files are inlcuded (for example, .env and firebase credentials).
2. The database is already initialized. In order to start from the beginning and use a different workspace, add your database credentials in the uploaded .env file and initialize the SingleStore database by running:
```
$ node initialize
```
Before running the above command, make sure to change the file name to './database_schemas/create_tables.sql' first and then to './database_schemas/load_data.sql'. In more details, change "<your_path>" in the following code section of **initialize.js**:
```js
fs.readFileSync("<your_path>")
    .toString()
    .replace(/\r\n/g, "")
    .split(";")
    .forEach(function (query) {
      if (query.length > 0) {
        initQueries.push(query);
      }
    });
```
3. Open a terminal window and run the following:
```
$ npm install
$ npm run client-install
$ npm run dev
```
4. A new browser window will open up with the website running in the local machine.

## Databases Used
SingleStoreDB has been used. This application has been migrated from PostgreSQL to SingleStore. However, the authentication and OTP functionalities have been implemented using Firebase services.
