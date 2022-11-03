//@ts-check

const express = require("express");
const cors = require("cors");
const path = require("path");
const dbMain = require("./db");

const app = express();
app.use(cors());

app.use(express.json({ limit: "10mb" }));
app.use(express.urlencoded({ limit: "10mb" }));

let conn = null;

const connect = async () => {
  conn = await dbMain();
};

connect();

if (process.env.NODE_ENV === "production") {
  app.use(express.static("client/build"));
  app.get("*", (req, res) => {
    res.sendFile(path.resolve(__dirname, "client", "build", "index.html"));
  });
}

app.post("/api/query", async (req, res) => {
  if (req.body.query === "") {
    res.json({});
  }
  const result = await conn.execute(req.body.query);
  // console.log(rows[0]);
  let resval;
  try {
    resval = {
      rows: result[0],
    };
  } catch {
    resval = result;
  }
  res.json(resval);
});

const port = process.env.PORT || 5001;

app.listen(port, () => `Server running on port ${port}`);
