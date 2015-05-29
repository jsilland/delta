if 'serviceWorker' in navigator && 'Cache' in window
  navigator.serviceWorker.register('/ServiceWorker.js').then( (registration) ->
    console.log("ServiceWorker registration successful with scope: #{registration.scope}")
  ).catch( (err) ->
    console.log("ServiceWorker registration failed: #{err}");
  )