// @ts-check

const fs = require("fs");
const dbMain = require("./db");

var initQueries = [];

(async () => {
  fs.readFileSync("./database_schemas/load_data.sql")
    .toString()
    .replace(/\r\n/g, "")
    .split(";")
    .forEach(function (query) {
      if (query.length > 0) {
        initQueries.push(query);
      }
    });

  let conn = await dbMain();
  for (let i = 0; i < initQueries.length; i++) {
    await conn
      .execute(initQueries[i])
      .then((data) => {
        // console.log("Returned from Database\n", data[0]);
        console.log(i, "successful");
      })
      .catch((error) => {
        console.log("Error:", error);
        console.log("Database could not be initialized successfully");
        return;
      });
  }
  conn.end();
})();
