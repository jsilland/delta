CACHE_NAME = 'peregrine-v1'

self.addEventListener('fetch', (event) ->
  event.respondWith(
    caches.match(event.request)
      .then( (response) ->
        if (response)
          return response

        fetchRequest = event.request.clone()

        fetch(fetchRequest).then(
          (response) ->
            if(!response || response.status != 200 || response.type != 'basic')
              return response

            responseToCache = response.clone()

            caches.open(CACHE_NAME)
              .then( (cache) ->
                cache.put(event.request, responseToCache)
              )

            return response
        )
      )
  )
)