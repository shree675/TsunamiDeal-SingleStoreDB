require("dotenv").config();
const mysql = require("mysql2/promise");

const HOST = process.env.HOST;
const USER = "admin";
const PASSWORD = process.env.PASSWORD;
const DATABASE = process.env.DATABASE;

async function main() {
  let singleStoreConnection;
  try {
    singleStoreConnection = await mysql.createConnection({
      host: HOST,
      user: USER,
      password: PASSWORD,
      database: DATABASE,
    });

    console.log("You have successfully connected to SingleStore.");
  } catch (err) {
    console.error("ERROR", err);
    process.exit(1);
  } finally {
    if (singleStoreConnection) {
      await singleStoreConnection.end();
    }
  }
}

main();
