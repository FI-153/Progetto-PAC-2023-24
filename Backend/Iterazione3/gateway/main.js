const express = require('express')
const axios = require('axios')
const bodyParser = require('body-parser')

const app = express()
app.use(bodyParser.json())

app.get('/', async (_, res) => {
  res.status(200).send("This is Radio Nowhere, is there anybody alive out there?")
})

app.get('/events', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta get al server
    const getResponse = await axios.get('http://64.23.165.209:8080/events', {
      headers: {
        'Authorization': authorization
      }
    });

    buildResponse(getResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

app.get('/events/:id', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta get al server
    const getResponse = await axios.get(`http://64.23.165.209:8080/events/${req.params.id}`, {
      headers: {
        'Authorization': authorization
      }
    });

    buildResponse(getResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

app.get('/profiles', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta get al server
    const getResponse = await axios.get('http://64.23.165.209:8080/profiles', {
      headers: {
        'Authorization': authorization
      }
    });

    buildResponse(getResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

app.get('/profiles/:id', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta get al server
    const getResponse = await axios.get(`http://64.23.165.209:8080/profiles/${req.params.id}`, {
      headers: {
        'Authorization': authorization
      }
    });

    buildResponse(getResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

app.get('/profile/reservations/:id', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta get al server
    const getResponse = await axios.get(`http://64.23.165.209:8080/profile/reservations/${req.params.id}`, {
      headers: {
        'Authorization': authorization
      }
    });

    buildResponse(getResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

app.delete('/events/:id', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta delete al server
    const getResponse = await axios.delete(`http://64.23.165.209:8080/events/${req.params.id}`, {
      headers: {
        'Authorization': authorization
      }
    });

    buildResponse(getResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

app.delete('/profiles/:id', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta delete al server
    const getResponse = await axios.delete(`http://64.23.165.209:8080/profiles/${req.params.id}`, {
      headers: {
        'Authorization': authorization
      }
    });

    buildResponse(getResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

app.delete('/reservations/:id', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta delete al server
    const getResponse = await axios.delete(`http://64.23.165.209:8080/reservations/${req.params.id}`, {
      headers: {
        'Authorization': authorization
      }
    });

    buildResponse(getResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})


app.post('/events/new', async (req, res) => {
  try {
    const { authorization } = req.headers;

    if (!authorization) {
      return res.sendStatus(401)
    }

    const postResponse = await axios.post(`http://64.23.165.209:8080/events/new`, req.body, {
      headers: {
        'Authorization': authorization
      }
    })

    buildResponse(postResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

app.post('/profiles', async (req, res) => {
  try {
    const { authorization } = req.headers;

    if (!authorization) {
      return res.sendStatus(401)
    }
    const postResponse = await axios.post(`http://64.23.165.209:8080/profiles/`, req.body, {
      headers: {
        'Authorization': authorization
      }
    })

    buildResponse(postResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

app.post('/events/reservation', async (req, res) => {
  try {
    const { authorization } = req.headers;

    if (!authorization) {
      return res.sendStatus(401)
    }
    const postResponse = await axios.post(`http://64.23.165.209:8080/events/reservation/`, req.body, {
      headers: {
        'Authorization': authorization
      }
    })

    buildResponse(postResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

function handleError(error, res) {
  console.error(error);
  res.status(500).send('Internal Server Error');
}

function buildResponse(response, res) {
  switch (response.status) {
    case 401:
      //Credenziali fornite sono sbagliate
      res.sendStatus(401)
      break;

    case 404:
      //Risorsa non trovata
      res.sendStatus(404)

    case 200:
      //Successo
      res.status(200).send(response.data)
      break;

    case 201:
      //Successo
      res.status(200).send(response.data)
      break;

    default:
      res.sendStatus(response.status)
      break;
  }
}

const PORT = 8085
app.listen(PORT, () => {
  console.log(`Radio Nowhere is playing on port: ${PORT}`)
})