import Express from "express";
import axios from "axios";

const app = Express();

const newsApi = axios.create({
  headers: {
    common: {
      Authorization: "Bearer a7b17f0c659e49daa0f2c4e18f232744",
    },
  },
});

app.get("/api/news", async (req, res, next) => {
  // const endpoint = "https://newsapi.org/v2/everything?domains=afr.com,businessinsider.com";
  const endpoint = "https://newsapi.org/v2/everything?q=wealth&sortBy=popularity";
  newsApi.get(endpoint)
    .then(function (response) {
      res.json(response.data);
    })
    .catch(function (error) {
      error.statusCode = error.response.status;
      next(error);
    })
});
export default app;
