'use strict'
const axios = require('axios')
const cors = require('cors')

const newsApi = axios.create({
  headers: {
    common: {
      Authorization: process.env.NEWS_API_TOKEN,
    },
  },
})

module.exports = function (app, opts) {
  app.use(cors())

  app.get("/news", async (req, res, next) => {
    // const endpoint = "https://newsapi.org/v2/everything?domains=afr.com,businessinsider.com";
    const endpoint = "https://newsapi.org/v2/everything?q=wealth&sortBy=popularity"

    newsApi.get(endpoint)
      .then(response => {
        res.json(response.data);
      })
      .catch(error => {
        error.statusCode = error.response.status;
        next(error)
      })
  })
}
