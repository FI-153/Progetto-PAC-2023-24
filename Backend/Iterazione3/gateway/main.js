const express = require('express')
const axios = require('axios')
const bodyParser = require('body-parser')
const cors = require('cors')

const app = express()
app.use(bodyParser.json())
app.use(cors({
  origin: '*',
  allowedHeaders: 'X-Requested-With, Content-Type, Authorization',
}))

const BASE_IP = 'http://managers:8080'

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
    const getResponse = await axios.get(`${BASE_IP}/events`, {
      headers: {
        'Authorization': authorization
      }
    });

    buildResponse(getResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

app.get('/login', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta get al server per ottenere i dettagli del profilo
    const getResponse = await axios.get(`${BASE_IP}/login`, {
      headers: {
        'Authorization': authorization
      }
    });

    //Richiesta get al server per ottenere l'esperienza dell'utente
    const exp = await axios.get(`${BASE_IP}/profiles/level/${getResponse.data['id']}`, {
      headers: {
        'Authorization': authorization
      }
    })
    getResponse.data['experience'] = exp.data

    //Richiesta get al server per ottenere la lista degli eventi a cui l'utente è iscritto
    const bookedEvents = await axios.get(`${BASE_IP}/profiles/${getResponse.data['id']}/reservations`, {
      headers: {
        'Authorization': authorization
      }
    });
    var events = bookedEvents.data.map(function (elem) {
      return elem.event.id
    })
    getResponse.data['bookedEvents'] = events
    getResponse.data['pastBookedEvents'] = events

    buildResponse(getResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

/**
 * Prende una striunga rappresentante una data nel formato dd-mm-yyyy e la restituisce nel formato yyyy-mm-dd
 * @param {*} inputDate stringa della data in formato dd-mm-yyyy
 * @returns stringa della data in formato yyyy-mm-dd
 */
function formatDateFromString(inputDate) {
  var parts = inputDate.split("-")
  var formattedDate = new Date(parts[2], parts[1] - 1, parts[0])

  var year = formattedDate.getFullYear()
  var month = String(formattedDate.getMonth() + 1).padStart(2, '0')
  var day = String(formattedDate.getDate()).padStart(2, '0')

  return year + "-" + month + "-" + day
}

app.get('/events/weather/:date/:location', async (req, res) => {

  const date = formatDateFromString(req.params.date)

  try {
    const weather = await axios.get(`https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/${req.params.location}/${date}/${date}?unitGroup=metric&elements=tempmax%2Ctempmin%2Ctemp%2Cprecipprob%2Cwindspeed%2Cwinddir%2Cvisibility%2Cicon&include=days&key=B57LD5LPUGKMJNZVNEKM9XB6E&contentType=json`)

    const weatherData = weather.data.days[0];
    const weatherCond = {
      'descr':
        `La temperatura massima sarà di ${weatherData.tempmax}℃ e la minima di ${weatherData.tempmin}℃, con una probabilità che piova del ${weatherData.precipprob}%.`,
      'icon': weatherData.icon,
      'avgTmp': weatherData.temp,
      'visibility': weatherData.visibility
    }

    res.status(200).send(weatherCond)

  } catch (e) {
    res.status(503).send('Previsioni meteo non disponibili')
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
    const getResponse = await axios.get(`${BASE_IP}/events/${req.params.id}`, {
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
    const getResponse = await axios.get(`${BASE_IP}/profiles`, {
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
    const getResponse = await axios.get(`${BASE_IP}/profiles/${req.params.id}`, {
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
    const getResponse = await axios.get(`${BASE_IP}/profile/reservations/${req.params.id}`, {
      headers: {
        'Authorization': authorization
      }
    });

    buildResponse(getResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

/**
 * Ottieni le prenotazioni confermata per l'utente dato il suo id
 */
app.get('/profiles/:id/reservations', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta get al server
    const getResponse = await axios.get(`${BASE_IP}/profiles/${req.params.id}/reservations`, {
      headers: {
        'Authorization': authorization
      }
    });

    var events = getResponse.data.map(function (elem) {
      return elem.event
    })

    switch (getResponse.status) {
      case 200:
        //Successo
        console.log('>>> RICHIESTA SODDISFATTA\n' + getResponse.data)
        res.status(200).send(events)
        break;

      default:
        res.sendStatus(getResponse.status)
        break;
    }

  } catch (error) {
    handleError(error, res)
  }
})

/**
 * Ottieni gli id delle prenotazioni confermate per l'utente dato il suo id
 */
app.get('/profiles/:id/reservationsIds', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta get al server
    const getResponse = await axios.get(`${BASE_IP}/profiles/${req.params.id}/reservations`, {
      headers: {
        'Authorization': authorization
      }
    });

    var events = getResponse.data.map(function (elem) {
      return elem.event.id
    })

    switch (getResponse.status) {
      case 200:
        //Successo
        console.log('>>> RICHIESTA SODDISFATTA\n' + getResponse.data)
        res.status(200).send(events)
        break;

      default:
        res.sendStatus(getResponse.status)
        break;
    }

  } catch (error) {
    handleError(error, res)
  }
})

/**
 * Chiudi un evento per selezionarne i partecipanti dagli iscritti
 */
app.get('/events/:id/close', async (req, res) => {
  try {
    const { authorization } = req.headers;

    //Se non viene fornita autorizzazione
    if (!authorization) {
      return res.sendStatus(401)
    }

    //Richiesta get al server
    const getResponse = await axios.get(`${BASE_IP}/events/${req.params.id}/close`, {
      headers: {
        'Authorization': authorization
      }
    });

    switch (getResponse.status) {
      case 200:
        //Successo
        console.log('>>> RICHIESTA SODDISFATTA\n' + getResponse.data)
        res.status(200).send(getResponse.data)
        break;

      default:
        res.sendStatus(getResponse.status)
        break;
    }

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
    const getResponse = await axios.delete(`${BASE_IP}/events/${req.params.id}`, {
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
    const getResponse = await axios.delete(`${BASE_IP}/profiles/${req.params.id}`, {
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
    const getResponse = await axios.delete(`${BASE_IP}/reservations/${req.params.id}`, {
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

    const postResponse = await axios.post(`${BASE_IP}/events/new`, req.body, {
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

    const postResponse = await axios.post(`${BASE_IP}/profiles/`, req.body, {
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
    const postResponse = await axios.post(`${BASE_IP}/events/reservation/`, req.body, {
      headers: {
        'Authorization': authorization
      }
    })

    buildResponse(postResponse, res)

  } catch (error) {
    handleError(error, res)
  }

})

/**
 * Gestisce errori inerenti il geteway
 * @param {*} error 
 * @param {*} res 
 */
function handleError(error, res) {
  console.error(error);
  res.status(500).send(error);
}

/**
 * Costruimo la risposta da mandare al client in base alla risposta del server
 * @param {*} response Risposta del server
 * @param {*} res Risposta da inviare al client
 */
function buildResponse(response, res) {
  switch (response.status) {
    case 401:
      //Credenziali fornite sono sbagliate
      console.log('>>> AUTORIZZAZIONE FALLITA\n' + response.data)
      res.sendStatus(401)
      break;

    case 404:
      //Risorsa non trovata
      console.log('>>> RISORSA NON TROVATA\n' + response.data)
      res.sendStatus(404)
      break;

    case 200:
      //Successo
      console.log('>>> RICHIESTA SODDISFATTA\n' + response.data)
      res.status(200).send(response.data)
      break;

    case 201:
      //Successo
      console.log('>>> RICHIESTA SODDISFATTA\n' + response.data)
      res.status(201).send(response.data)
      break;

    case 202:
      //Successo (login)
      console.log('>>> RICHIESTA SODDISFATTA\n' + response.data)
      res.status(202).send(response.data)
      break

    default:
      res.sendStatus(response.status)
      break;
  }
}

const PORT = 8085
app.listen(PORT, () => {
  console.log(`Radio Nowhere is playing on port: ${PORT}`)
})
