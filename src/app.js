import express from "express";

const app = express();

// Example route
app.get("/", (req, res) => {
    res.status(200).send("Hello, From Acquisitions!");
});

export default app;
